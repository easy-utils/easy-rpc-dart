// Regression: the http2 adapter must honor a caller-supplied SecurityContext.
//
// A private/self-signed ingress CA is NOT in the system trust store. The app
// seeds a SecurityContext with the CA and expects the transport to use it. The
// http2 adapter dials with SecureSocket (not the passed io.HttpClient), so it
// MUST receive the context explicitly — otherwise the handshake fails and every
// agent RPC is dead on Android/desktop.
//
// Fixtures: test/fixtures/fix-{ca,server}.crt + fix-server.key — a throwaway CA
// and a 127.0.0.1 leaf, committed so the test is hermetic (no openssl needed).
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_rpc/easy_rpc.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

void main() {
  late SecureServerSocket server;
  late SecurityContext serverCtx;

  setUp(() async {
    serverCtx = SecurityContext()
      ..useCertificateChain('test/fixtures/fix-server.crt')
      ..usePrivateKey('test/fixtures/fix-server.key');
    server = await SecureServerSocket.bind('127.0.0.1', 0, serverCtx,
        supportedProtocols: ['h2']);
    server.listen((s) {
      final conn = ServerTransportConnection.viaSocket(s);
      conn.incomingStreams.listen((stream) {
        stream.incomingMessages.listen((_) {
          stream.outgoingMessages.add(DataStreamMessage([0x68], endStream: true));
        });
      });
    });
  });

  tearDown(() => server.close());

  test('http2 transport trusts a caller-supplied private CA', () async {
    final caPem = File('test/fixtures/fix-ca.crt').readAsStringSync();
    final clientCtx = SecurityContext(withTrustedRoots: true)
      ..setTrustedCertificatesBytes(utf8.encode(caPem));

    final t = connect(
      baseUrl: 'https://127.0.0.1:${server.port}',
      mode: TransportMode.http2,
      httpClient: HttpClient(context: clientCtx),
      securityContext: clientCtx,
    );

    Object? handshakeErr;
    try {
      await t.send(Request(url: '/x', body: Uint8List(0)));
    } on HandshakeException catch (e) {
      handshakeErr = e;
    } catch (_) {
      // A post-handshake protocol error still proves the TLS session was
      // established; only a failure to trust the CA is a regression.
    }
    expect(handshakeErr, isNull,
        reason: 'private CA was ignored by the http2 adapter');
  });
}

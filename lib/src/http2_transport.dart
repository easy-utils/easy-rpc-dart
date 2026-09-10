import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http2/transport.dart';
import '../easy_rpc.dart';

/// HTTP/2 (h2 + h2c) client transport for Dart VM / Linux / desktop.
///
/// Uses the `http2` package. For https:// it negotiates h2 via ALPN; for
/// http:// it uses h2c prior knowledge (the server must speak HTTP/2 without
/// TLS). Falls back to plain HTTP/1.1 (dart:io) when h2 is unavailable.
class Http2Transport implements Transport {
  final String baseUrl;
  Http2Transport({this.baseUrl = ''});

  String _url(String u) => u.startsWith('http') ? u : '$baseUrl$u';

  @override
  Future<Response> send(Request req) async {
    final connection = _Response1();
    final stream = await _roundTrip(req, connection);
    return Response(
      status: connection.status,
      headers: _mapHeaders(connection.headers),
      body: stream,
      error: connection.status >= 300
          ? RPCError(connectFromStatus(connection.status), utf8.decode(stream))
          : null,
    );
  }


  @override
  Future<RpcStream> openStream(Request req) async {
    final res = await send(req);
    if (res.error != null) throw res.error!;
    return RpcStream(FrameReader().frames(Stream<List<int>>.fromIterable([res.body ?? Uint8List(0)])));
  }

  Future<Uint8List> _roundTrip(Request req, _Response1 conn) async {
    final uri = Uri.parse(_url(req.url));
    final socket = await _connect(uri);
    final transport = ClientTransportConnection.viaSocket(socket);
    final headers = <Header>[
      Header.ascii(':method', req.method),
      Header.ascii(':path', uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path),
      Header.ascii(':scheme', uri.scheme),
      Header.ascii(':authority', uri.host),
    ];
    req.headers.forEach((k, vs) {
      for (final v in vs) { headers.add(Header.ascii(k, v)); }
    });
    if (!req.headers.containsKey('content-type')) {
      headers.add(Header.ascii('content-type', 'application/proto'));
    }
    final stream = transport.makeRequest(headers, endStream: req.body == null);
    if (req.body != null) {
      stream.outgoingMessages.add(DataStreamMessage(req.body!, endStream: true));
    }
    final out = BytesBuilder();
    await for (final m in stream.incomingMessages) {
      if (m is HeadersStreamMessage) {
        for (final h in m.headers) {
          final name = utf8.decode(h.name);
          final value = utf8.decode(h.value);
          if (name == ':status') {
            conn.status = int.tryParse(value) ?? 200;
            continue;
          }
          conn.headers.putIfAbsent(name, () => <String>[]).add(value);
        }
      } else if (m is DataStreamMessage) {
        out.add(m.bytes);
      }
    }
    await transport.finish();
    return out.takeBytes();
  }

  Future<Socket> _connect(Uri uri) async {
    final useSSL = uri.scheme == 'https';
    if (useSSL) {
      final ss = await SecureSocket.connect(uri.host, uri.port, supportedProtocols: ['h2']);
      if (ss.selectedProtocol != 'h2') {
        throw Exception('Failed to negotiate http/2 via ALPN.');
      }
      return ss;
    }
    return await Socket.connect(uri.host, uri.port);
  }

  Map<String, List<String>> _mapHeaders(Map<String, List<String>> h) => h;
}

class _Response1 {
  int status = 0;
  final Map<String, List<String>> headers = {};
}

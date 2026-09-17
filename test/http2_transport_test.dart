// Http2Transport (h2c prior-knowledge, dart `http2` package) against the Go
// conformance server — the locally-testable variant of the Dart bridge family
// (Cronet/Cupertino/Fetch need devices or a browser).
import 'dart:io';

import 'package:easy_rpc/easy_rpc.dart';
import 'package:easy_rpc/src/http2_transport.dart';
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance.pb.dart' as pb;
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance_easyrpc.dart';
import 'package:test/test.dart';

void main() {
  final base = Platform.environment['EASY_RPC_BASE'] ?? 'http://127.0.0.1:18888';
  final t = Http2Transport(baseUrl: base);
  final c = ConformanceServiceClient(t);

  test('echo unary over h2c', () async {
    final res = await c.echo(pb.EchoRequest(input: 'hi'));
    expect(res.output, 'echo:hi');
  });

  test('count server-stream over h2c', () async {
    final idx = <int>[];
    await for (final r in c.count(pb.CountRequest(count: 3))) {
      idx.add(r.index);
    }
    expect(idx, [0, 1, 2]);
  });

  test('stream-fail surfaces end-stream error over h2c', () async {
    final seen = <int>[];
    RPCError? err;
    try {
      await for (final r in c.streamFail(
          pb.StreamFailRequest(emitBefore: 2, code: 13, message: 'boom'))) {
        seen.add(r.index);
      }
    } on RPCError catch (e) {
      err = e;
    }
    expect(seen, [0, 1]);
    expect(err?.code, 13);
  });

  test('fail-details carries structured details over h2c', () async {
    RPCError? err;
    try {
      await c.failDetails(pb.FailDetailsRequest(
        code: 8,
        message: 'limited',
        detailType: 'type.googleapis.com/google.rpc.RetryInfo',
        detailText: 'retry:5s',
      ));
    } on RPCError catch (e) {
      err = e;
    }
    expect(err?.code, 8);
    expect(err?.details?.single.type, 'type.googleapis.com/google.rpc.RetryInfo');
    expect(String.fromCharCodes(err!.details!.single.value), 'retry:5s');
  });
}

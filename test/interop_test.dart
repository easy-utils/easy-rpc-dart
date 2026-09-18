import 'dart:io';
import 'package:easy_rpc/easy_rpc.dart';
import 'package:easy_rpc/src/http2_transport.dart';
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance.pb.dart' as pb;
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance_easyrpc.dart';
import 'package:test/test.dart';

Transport _transport(String base) {
  // Unified transport vocabulary (spec §7.1): io | http2 (default io).
  final name = Platform.environment['EASY_RPC_TRANSPORT'] ?? 'io';
  return name == 'http2' ? Http2Transport(baseUrl: base) : IoTransport(baseUrl: base);
}

void main() {
  final base = Platform.environment['EASY_RPC_BASE'] ?? 'http://127.0.0.1:18888';

  test('echo unary -> Go server (via generated client)', () async {
    final t = _transport(base);
    final c = ConformanceServiceClient(t);
    final res = await c.echo(pb.EchoRequest(input: 'hi'));
    expect(res.output, 'echo:hi');
  });

  test('count stream -> Go server', () async {
    final c = ConformanceServiceClient(_transport(base));
    final idx = <int>[];
    await for (final r in c.count(pb.CountRequest(count: 3))) {
      idx.add(r.index);
    }
    expect(idx, [0, 1, 2]);
  });

  test('unary trailer surfaces', () async {
    final c = ConformanceServiceClient(_transport(base));
    final res = await c.echoTrailer(pb.EchoTrailerRequest(input: 'x'));
    expect(res.output, 'trailer:x');
    expect(c.lastTrailers['x-trl'], ['unary-x']);
  });

  test('stream trailer surfaces', () async {
    final c = ConformanceServiceClient(_transport(base));
    final idx = <int>[];
    await for (final r in c.countTrailer(pb.CountTrailerRequest(count: 2))) {
      idx.add(r.index);
    }
    expect(idx, [0, 1]);
    expect(c.lastStream!.trailers()['x-ctrailer'], ['done']);
  });

  test('unary error surfaces', () async {
    final c = ConformanceServiceClient(_transport(base));
    RPCError? err;
    try {
      await c.fail(pb.FailRequest(message: 'nope'));
    } on RPCError catch (e) {
      err = e;
    }
    expect(err?.code, 3);
  });
}

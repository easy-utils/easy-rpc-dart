import 'dart:typed_data';
import 'package:easy_rpc/easy_rpc.dart';
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance.pb.dart' as pb;
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance_easyrpc.dart';
import 'package:test/test.dart';

void main() {
  test('echo unary -> Go server (via generated client)', () async {
    final t = Transport(baseUrl: 'http://127.0.0.1:18888');
    final c = ConformanceServiceClient(t);
    final res = await c.echo(pb.EchoRequest(input: 'hi'));
    expect(res.output, 'echo:hi');
  });
}

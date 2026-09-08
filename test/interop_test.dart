import 'dart:typed_data';
import 'package:easy_rpc/easy_rpc.dart';
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance.pb.dart' as pb;
import 'package:test/test.dart';

void main() {
  test('echo unary -> Go server', () async {
    final t = Transport();
    final req = Request(
      url: 'http://127.0.0.1:18888/v1/echo',
      body: pb.EchoRequest(input: 'hi').writeToBuffer(),
    );
    final res = await t.send(req);
    expect(res.status, 200);
    final out = pb.EchoResponse.fromBuffer(res.body!);
    expect(out.output, 'echo:hi');
  });
}

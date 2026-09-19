import 'dart:convert';
import 'package:easy_rpc/easy_rpc.dart';
import 'package:easy_rpc/src/easyrpc/conformance/v1/conformance.pb.dart' as pb;
import 'package:test/test.dart';

// Transport-independent JSON codec tests (proto3 JSON).
void main() {
  test('content kind mapping', () {
    expect(contentKindOf('application/proto'), 'proto');
    expect(contentKindOf('application/json; charset=utf-8'), 'json');
    expect(contentKindOf('application/connect+json'), 'json');
    expect(contentKindOf('text/plain'), null);
    expect(contentTypeFor(false, 'json'), 'application/json');
    expect(contentTypeFor(true, 'json'), 'application/connect+json');
  });

  test('json string round-trip', () {
    final m = pb.EchoResponse(output: 'echo:hi');
    final bytes = encodeMsg(m, 'json');
    expect(utf8.decode(bytes), contains('"output"'));
    expect(utf8.decode(bytes), contains('echo:hi'));
    final back = decodeMsg<pb.EchoResponse>(bytes, () => pb.EchoResponse(), 'json');
    expect(back.output, 'echo:hi');
  });

  test('json bytes are base64', () {
    final m = pb.EchoBytesResponse(data: [0, 1, 2, 0xff, 0xfe, 0x80]);
    final bytes = encodeMsg(m, 'json');
    expect(utf8.decode(bytes), contains('AAEC'));
    final back = decodeMsg<pb.EchoBytesResponse>(bytes, () => pb.EchoBytesResponse(), 'json');
    expect(back.data, m.data);
  });

  test('json ignores unknown fields', () {
    final json = utf8.encode('{"count":42,"unknownField":"x"}');
    final m = decodeMsg<pb.CountRequest>(json, () => pb.CountRequest(), 'json');
    expect(m.count, 42);
  });
}

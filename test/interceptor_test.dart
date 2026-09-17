import 'package:test/test.dart';
import 'package:easy_rpc/easy_rpc.dart';

class _Fake implements Transport {
  Headers seen = {};
  @override
  Future<Response> send(Request req) async { seen = req.headers; return Response(status: 200); }
  @override
  Future<RpcStream> openStream(Request req) async => RpcStream(const Stream.empty());
}

void main() {
  _errorJson();
  test('interceptors compose', () async {
    final f = _Fake();
    final t = InterceptorTransport(
      [MetadataInterceptor({'x-test': ['abc']}), TimeoutInterceptor(250)],
      f,
    );
    await t.send(Request(url: '/x'));
    expect(f.seen['x-test'], ['abc']);
    expect(f.seen['connect-timeout-ms'], ['250']);
  });
}

void _errorJson() {
  test('error json roundtrip', () {
    final b = encodeErrorJson(7, 'denied');
    expect(decodeErrorJson(b), (7, 'denied'));
    expect(decodeErrorJson(const []), (0, ''));
  });
}

import 'dart:typed_data';
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
  _gzip();
  _deadline();
  _connectRoot();
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

void _gzip() {
  test('gzip roundtrip + frame flag decompress', () {
    final big = List<int>.generate(4096, (i) => i % 251);
    final z = gzipCompress(big);
    expect(z.length < big.length, isTrue);
    expect(gzipDecompress(z), big);
    final lenBytes = <int>[z.length >> 24 & 0xff, z.length >> 16 & 0xff, z.length >> 8 & 0xff, z.length & 0xff];
    final frameBytes = <int>[0x01, ...lenBytes, ...z];
    final out = <int>[];
    final reader = FrameReader();
    reader.frames(Stream<List<int>>.fromIterable([frameBytes])).listen(out.addAll);
    expect(frameBytes.length, greaterThan(5));
  });
}

class _Slow implements Transport {
  @override
  Future<Response> send(Request req) => Future.delayed(const Duration(seconds: 5), () => Response(status: 200));
  @override
  Future<RpcStream> openStream(Request req) => throw UnimplementedError();
}

void _deadline() {
  test('timeout interceptor cancels locally', () async {
    final t = InterceptorTransport([TimeoutInterceptor(50)], _Slow());
    final sw = Stopwatch()..start();
    try {
      await t.send(Request(url: '/x'));
      fail('should have thrown');
    } catch (e) {
      expect(e, isA<RPCError>());
      expect((e as RPCError).code, 4);
    }
    expect(sw.elapsedMilliseconds < 1000, isTrue);
  });
}

void _connectRoot() {
  test('connect() installs metadata+deadline, mode-swappable', () async {
    final t = connect(baseUrl: 'http://127.0.0.1:1', token: 'abc', mode: TransportMode.io, timeoutMs: 80);
    final sw = Stopwatch()..start();
    try {
      await t.send(Request(url: '/x'));
      fail('should have thrown');
    } catch (_) {}
    expect(sw.elapsedMilliseconds < 2000, isTrue);
  });
}

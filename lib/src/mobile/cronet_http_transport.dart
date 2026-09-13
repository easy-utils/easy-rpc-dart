// Cronet HTTP client transport for Android (via `cronet_http`).
// Covers HTTP/1 + HTTP/2 + HTTP/3 at the Cronet (system) level.
//
// Flutter-only: requires `cronet_http` (which requires the Flutter SDK). The
// pure Dart VM build excludes this file (see analysis_options.yaml).
import 'dart:typed_data';
import 'package:cronet_http/cronet_http.dart';
import '../../easy_rpc.dart';

class CronetHttpTransport implements Transport {
  final String baseUrl;
  CronetHttpTransport({this.baseUrl = ''});

  String _url(String u) => u.startsWith('http') ? u : '$baseUrl$u';

  @override
  Future<Response> send(Request req) async {
    final resp = await CronetClient().post(_url(req.url),
        headers: req.headers, body: req.body);
    return Response(
      status: resp.status,
      headers: resp.headers,
      body: resp.bodyBytes,
      error: resp.status >= 300
          ? rpcErrorFrom(resp.status, resp.headers, resp.bodyBytes)
          : null,
    );
  }

  @override
  @override
  Future<RpcStream> openStream(Request req) async {
    final res = await send(req);
    if (res.error != null) throw res.error!;
    return RpcStream(FrameReader().frames(Stream<List<int>>.fromIterable([res.body ?? Uint8List(0)])));
  }
}

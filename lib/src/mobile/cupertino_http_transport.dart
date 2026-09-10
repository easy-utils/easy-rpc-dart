// Cupertino HTTP client transport for iOS/macOS (via `cupertino_http`).
// Covers HTTP/1 + HTTP/2 + HTTP/3 at the NSURLSession (system) level.
//
// Flutter-only: requires `cupertino_http` (which requires the Flutter SDK). The
// pure Dart VM build excludes this file (see analysis_options.yaml).
import 'dart:typed_data';
import 'package:cupertino_http/cupertino_http.dart';
import '../../easy_rpc.dart';

class CupertinoHttpTransport implements Transport {
  final String baseUrl;
  CupertinoHttpTransport({this.baseUrl = ''});

  String _url(String u) => u.startsWith('http') ? u : '$baseUrl$u';

  @override
  Future<Response> send(Request req) async {
    final resp = await CupertinoClient().post(_url(req.url),
        headers: req.headers, body: req.body);
    return Response(
      status: resp.status,
      headers: resp.headers,
      body: resp.bodyBytes,
      error: resp.status >= 300
          ? RPCError(connectFromStatus(resp.status), String.fromCharCodes(resp.bodyBytes))
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

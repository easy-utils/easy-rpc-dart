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

  /// cupertino_http takes single-valued headers; flatten our multi-value map.
  Map<String, String> _flatHeaders(Map<String, List<String>> h) =>
      h.map((k, v) => MapEntry(k, v.first));

  @override
  Future<Response> send(Request req) async {
    // cupertino_http 3.x removed the default CupertinoClient() constructor;
    // defaultSessionConfiguration() exists in 2.x and 3.x alike.
    final resp = await CupertinoClient.defaultSessionConfiguration()
        .post(Uri.parse(_url(req.url)), headers: _flatHeaders(req.headers), body: req.body);
    // cupertino_http exposes single-valued headers; widen to multi-value.
    final headers = resp.headers.map((k, v) => MapEntry(k, [v]));
    return Response(
      status: resp.statusCode,
      headers: headers,
      body: resp.bodyBytes,
      error: resp.statusCode >= 300
          ? rpcResponseError(resp.statusCode, headers, resp.bodyBytes)
          : null,
    );
  }

  @override
  Future<RpcStream> openStream(Request req) async {
    final res = await send(req);
    if (res.error != null) throw res.error!;
    return RpcStream(FrameReader().frames(Stream<List<int>>.fromIterable([res.body ?? Uint8List(0)])));
  }
}

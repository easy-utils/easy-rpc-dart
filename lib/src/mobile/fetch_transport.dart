// Fetch HTTP client transport for the Web. The browser's fetch covers
// HTTP/1 + HTTP/2 + HTTP/3 automatically.
//
// Web-only: uses the `package:http`-style fetch adapter. The pure Dart VM build
// excludes this file (see analysis_options.yaml).
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../easy_rpc.dart';

class FetchTransport implements Transport {
  final String baseUrl;
  FetchTransport({this.baseUrl = ''});

  String _url(String u) => u.startsWith('http') ? u : '$baseUrl$u';

  @override
  Future<Response> send(Request req) async {
    final resp = await http.post(Uri.parse(_url(req.url)),
        headers: _mapHeaders(req.headers), body: req.body);
    return Response(
      status: resp.statusCode,
      headers: _mapStringHeaders(resp.headers),
      body: resp.bodyBytes,
      error: resp.statusCode >= 300
          ? rpcResponseError(resp.statusCode, resp.headers, resp.bodyBytes)
          : null,
    );
  }

  @override
  Future<RpcStream> openStream(Request req) async {
    final resp = await http.post(Uri.parse(_url(req.url)),
        headers: _mapHeaders(req.headers), body: req.body);
    if (resp.statusCode >= 300) {
      throw rpcResponseError(resp.statusCode, resp.headers, resp.bodyBytes)!;
    }
    // Web fetch returns the whole body at once; de-frame it into payloads.
    final chunks = Stream<List<int>>.fromIterable([resp.bodyBytes]);
    return RpcStream(FrameReader().frames(chunks));
  }

  Map<String, String> _mapHeaders(Map<String, List<String>> h) {
    final out = <String, String>{};
    h.forEach((k, vs) => out[k] = vs.join(','));
    return out;
  }

  Map<String, List<String>> _mapStringHeaders(Map<String, String> h) {
    final out = <String, List<String>>{};
    h.forEach((k, v) => out[k] = [v]);
    return out;
  }
}

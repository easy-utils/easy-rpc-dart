// Cronet HTTP client transport for Android (via `cronet_http`).
// Covers HTTP/1 + HTTP/2 + HTTP/3 at the Cronet (system) level.
//
// Flutter-only: requires `cronet_http` (which requires the Flutter SDK). The
// pure Dart VM build excludes this file (see analysis_options.yaml).
import 'dart:async';
import 'dart:typed_data';

import 'package:cronet_http/cronet_http.dart';
import 'package:http/http.dart' as http;
import '../../easy_rpc.dart';

class CronetHttpTransport implements Transport {
  /// The caller-built Cronet client (engine options — QUIC/h2, context
  /// wiring, trust configuration — live on the CronetClient the application
  /// constructed, e.g. ); defaults to
  /// a client with a fresh default engine.
  final http.Client _client;
  final String baseUrl;

  CronetHttpTransport({http.Client? client, this.baseUrl = ''})
      : _client = client ?? CronetClient.defaultCronetEngine();

  String _url(String u) => u.startsWith('http') ? u : '$baseUrl$u';

  Map<String, String> _flat(Map<String, List<String>> h) =>
      h.map((k, v) => MapEntry(k, v.first));

  Map<String, List<String>> _widen(Map<String, String> h) =>
      h.map((k, v) => MapEntry(k, [v]));

  @override
  Future<Response> send(Request req) async {
    final resp = await _client.post(Uri.parse(_url(req.url)),
        headers: _flat(req.headers), body: req.body);
    final headers = _widen(resp.headers);
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
    // All easy-rpc calls are POST (spec §0), so no method is carried on the
    // request. Non-streaming request object carrying the whole body: cronet_http
    // buffers request bodies internally anyway (`finalize().toBytes()`), and
    // a StreamedRequest here deadlocks — its single-subscription controller
    // is drained by that same toBytes() before the client subscribes, so the
    // send future never completes. The RESPONSE is still streamed
    // incrementally into the shared FrameReader (END terminates, end-stream
    // errors surface via the stream, truncation is caught by finish()).
    final request = http.Request('POST', Uri.parse(_url(req.url)))
      ..headers.addAll(_flat(req.headers))
      ..bodyBytes = req.body ?? Uint8List(0);
    final resp = await _client.send(request);
    final headers = _widen(resp.headers);
    if (resp.statusCode >= 300) {
      final body = await resp.stream.toBytes();
      throw rpcResponseError(resp.statusCode, headers, body)!;
    }
    return RpcStream(FrameReader()
        .frames(resp.stream.map((c) => Uint8List.fromList(c))));
  }
}

extension on Stream<List<int>> {
  Future<List<int>> toBytes() async {
    final builder = BytesBuilder(copy: false);
    await for (final c in this) {
      builder.add(c);
    }
    return builder.takeBytes();
  }
}

// Dart easy-rpc core: zero-runtime-bindings Transport + Connect wire
// (unary + server-stream). The bridge uses the official dart:io HttpClient
// (HTTP/1.1), which supports unary + chunked server-streams — matching the
// Go conformance server (net/http). Trade any HTTP runtime via a Transport.
import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';



// Core is transport-agnostic: it exposes ONLY the abstract Transport contract,
// the wire primitives (Request/Response/RpcStream/framing) and a default
// dart:io bridge. Platform bridges (Http2Transport / FetchTransport /
// CronetHttpTransport / CupertinoHttpTransport) live in their own files and are
// imported explicitly by the caller — so generated SDKs never pull Flutter
// runtime deps. See `lib/src/http2_transport.dart`, `lib/src/mobile/*`.
export 'src/easyrpc/conformance/v1/conformance.pb.dart';

typedef Headers = Map<String, List<String>>;

class RPCError implements Exception {
  final int code;
  final String message;
  RPCError(this.code, this.message);
  @override
  String toString() => 'easyrpc: code=$code $message';
}

class Request {
  final String url;
  final String method;
  final Headers headers;
  final Uint8List? body;
  Request({required this.url, this.method = 'POST', this.headers = const {}, this.body});
}

class Response {
  final int status;
  final Headers headers;
  final Uint8List? body;
  final RPCError? error;
  Response({required this.status, this.headers = const {}, this.body, this.error});

}

int httpStatus(int code) => switch (code) {
      1 => 499,
      3 => 400,
      4 => 504,
      5 => 404,
      6 => 409,
      7 => 403,
      8 => 429,
      9 => 400,
      10 => 409,
      11 => 400,
      12 => 501,
      14 => 503,
      16 => 401,
      _ => 500,
    };

/// Reconstruct an RPCError from a response's `connect-code`/`connect-error`
/// headers (the HTTP status alone is lossy). \`body\` is the raw error body.
RPCError rpcErrorFrom(int status, Map<String, List<String>> headers, List<int> body) {
  final code = headers['connect-code']?.first;
  final c = code == null ? null : int.tryParse(code);
  if (c != null) return RPCError(c, headers['connect-error']?.first ?? '');
  return RPCError(connectFromStatus(status), body.isEmpty ? '' : utf8.decode(body));
}

int connectFromStatus(int status) => switch (status) {
      400 => 3,
      404 => 5,
      403 => 7,
      401 => 16,
      429 => 8,
      503 => 14,
      409 => 10,
      504 => 4,
      501 => 12,
      499 => 1,
      _ => 13,
    };

const kEndStream = 0x02;

/// Connect code -> stable lowercase wire name.
const Map<int, String> kCodeNames = {
  0: 'ok', 1: 'canceled', 2: 'unknown', 3: 'invalid_argument',
  4: 'deadline_exceeded', 5: 'not_found', 6: 'already_exists',
  7: 'permission_denied', 8: 'resource_exhausted', 9: 'failed_precondition',
  10: 'aborted', 11: 'out_of_range', 12: 'unimplemented', 13: 'internal',
  14: 'unavailable', 15: 'data_loss', 16: 'unauthenticated',
};

String codeToString(int code) => kCodeNames[code] ?? 'unknown';

int codeFromString(String name) {
  for (final e in kCodeNames.entries) {
    if (e.value == name) return e.key;
  }
  return 2;
}

Uint8List frame(Uint8List payload, {bool end = false}) {
  final out = Uint8List(5 + payload.length);
  out[0] = end ? kEndStream : 0;
  ByteData.sublistView(out).setUint32(1, payload.length);
  out.setRange(5, 5 + payload.length, payload);
  return out;
}

/// Encode an END-frame payload in the Connect end-stream JSON shape; a clean
/// end is empty.
Uint8List encodeEndStream(int code, String message) {
  if (code == 0) return Uint8List(0);
  final json = '{"error":{"code":"${codeToString(code)}",'
      '"message":${jsonEncode(message)}}}';
  return Uint8List.fromList(utf8.encode(json));
}

/// Decode a Connect end-stream payload into (code, message); (0, '') = clean.
(int, String) decodeEndStream(Uint8List payload) {
  if (payload.isEmpty) return (0, '');
  try {
    final v = jsonDecode(utf8.decode(payload));
    if (v is! Map || v['error'] is! Map) return (0, '');
    final e = v['error'] as Map;
    return (
      e['code'] is String ? codeFromString(e['code'] as String) : 2,
      e['message'] is String ? e['message'] as String : '',
    );
  } catch (_) {
    return (0, '');
  }
}

const String kHeaderTimeout = 'connect-timeout-ms';

/// Parse the Connect timeout header into milliseconds (0 = none).
int parseTimeout(String? value) {
  if (value == null || value.isEmpty) return 0;
  final n = int.tryParse(value);
  return (n == null || n <= 0) ? 0 : n;
}

/// Attach a deadline to a request.
Request withTimeout(Request req, int timeoutMs) {
  if (timeoutMs <= 0) return req;
  return Request(
    url: req.url,
    method: req.method,
    headers: {...req.headers, kHeaderTimeout: ['$timeoutMs']},
    body: req.body,
  );
}

class FrameReader {
  Uint8List _acc = Uint8List(0);
  Stream<Uint8List> frames(Stream<List<int>> chunks) async* {
    await for (final c in chunks) {
      _acc = Uint8List.fromList([..._acc, ...c]);
      while (true) {
        if (_acc.length < 5) break;
        final flags = _acc[0];
        final len = ByteData.sublistView(_acc).getUint32(1);
        if (_acc.length < 5 + len) break;
        final payload = Uint8List.fromList(_acc.sublist(5, 5 + len));
        _acc = Uint8List.fromList(_acc.sublist(5 + len));
        if ((flags & kEndStream) != 0) {
          final (code, message) = decodeEndStream(payload);
          if (code != 0) throw RPCError(code, message);
          return;
        }
        yield payload;
      }
    }
  }
}

class RpcStream {
  final Stream<Uint8List> _payloads;
  RpcStream(this._payloads);
  Stream<Uint8List> get messages => _payloads;
  void cancel() {}
}

/// The Transport contract: any HTTP runtime bridge must implement this to be
/// usable by generated clients. Bridges keep zero runtime bindings — the core
/// only speaks the Connect wire through [send]/[openStream].
abstract class Transport {
  Future<Response> send(Request req);
  Future<RpcStream> openStream(Request req);
}

/// dart:io-based bridge (HTTP/1.1 + chunked server-streams, TLS via a custom
/// CA). This is the default native transport.
/// A call interceptor: mutate the request (auth/metadata), impose a deadline,
/// observe, or short-circuit. `next_` performs the call.
abstract class Interceptor {
  Future<Response> unary(Request req, Future<Response> Function(Request) next_) => next_(req);
  Future<RpcStream> stream(Request req, Future<RpcStream> Function(Request) next_) => next_(req);
}

/// Apply interceptors (first = outermost) around a Transport.
class InterceptorTransport implements Transport {
  final List<Interceptor> _ics;
  final Transport _inner;
  InterceptorTransport(this._ics, this._inner);

  @override
  Future<Response> send(Request req) {
    Future<Response> call(Request r) => _inner.send(r);
    Future<Response> dispatch(int i, Request r) {
      if (i >= _ics.length) return call(r);
      return _ics[i].unary(r, (nr) => dispatch(i + 1, nr));
    }
    return dispatch(0, req);
  }

  @override
  Future<RpcStream> openStream(Request req) {
    Future<RpcStream> call(Request r) => _inner.openStream(r);
    Future<RpcStream> dispatch(int i, Request r) {
      if (i >= _ics.length) return call(r);
      return _ics[i].stream(r, (nr) => dispatch(i + 1, nr));
    }
    return dispatch(0, req);
  }
}

/// Attach fixed metadata to every call.
class MetadataInterceptor extends Interceptor {
  final Headers md;
  MetadataInterceptor(this.md);
  Request _aug(Request req) {
    final h = Map<String, List<String>>.from(req.headers);
    for (final e in md.entries) { h.putIfAbsent(e.key, () => e.value); }
    return Request(url: req.url, method: req.method, headers: h, body: req.body);
  }
  @override
  Future<Response> unary(Request req, Future<Response> Function(Request) n) => n(_aug(req));
  @override
  Future<RpcStream> stream(Request req, Future<RpcStream> Function(Request) n) => n(_aug(req));
}

/// Attach a Connect deadline to every call.
class TimeoutInterceptor extends Interceptor {
  final int ms;
  TimeoutInterceptor(this.ms);
  @override
  Future<Response> unary(Request req, Future<Response> Function(Request) n) => n(withTimeout(req, ms));
  @override
  Future<RpcStream> stream(Request req, Future<RpcStream> Function(Request) n) => n(withTimeout(req, ms));
}

class IoTransport implements Transport {
  final io.HttpClient _client;
  final String baseUrl;
  IoTransport({io.HttpClient? client, this.baseUrl = ''}) : _client = client ?? io.HttpClient();
  String _url(String u) => u.startsWith('http') ? u : '$baseUrl$u';

  @override
  Future<Response> send(Request req) async {
    final uri = Uri.parse(_url(req.url));
    final r = await _client.openUrl(req.method, uri);
    r.headers.contentType = io.ContentType('application', 'proto');
    req.headers.forEach((k, vs) {
      for (final v in vs) {
        r.headers.add(k, v);
      }
    });
    if (req.body != null) r.add(req.body!);
    final resp = await r.close();
    final body = await resp.fold<Uint8List>(Uint8List(0), (a, b) => Uint8List.fromList([...a, ...b]));
    final hdrs = _hdrs(resp.headers);
    return Response(
      status: resp.statusCode,
      headers: hdrs,
      body: body,
      error: resp.statusCode >= 300 ? _errorOf(hdrs, resp.statusCode, body) : null,
    );
  }

  @override
  Future<RpcStream> openStream(Request req) async {
    final uri = Uri.parse(_url(req.url));
    final r = await _client.openUrl(req.method, uri);
    r.headers.contentType = io.ContentType('application', 'connect+proto');
    req.headers.forEach((k, vs) {
      for (final v in vs) {
        r.headers.add(k, v);
      }
    });
    if (req.body != null) r.add(req.body!);
    final resp = await r.close();
    // Use raw byte stream: resp is Stream<List<int>>.
    final raw = resp as Stream<List<int>>;
    return RpcStream(FrameReader().frames(raw));
  }

  /// Reconstruct the exact RPCError from the `connect-code`/`connect-error`
  /// headers the server sends (the HTTP status alone is lossy — several
  /// Connect codes map to 400/409/500).
  RPCError _errorOf(Headers h, int status, Uint8List body) =>
      rpcErrorFrom(status, h, body);

  Headers _hdrs(io.HttpHeaders h) {
    final out = <String, List<String>>{};
    h.forEach((k, values) => out[k] = values);
    return out;
  }

  void close() => _client.close();
}

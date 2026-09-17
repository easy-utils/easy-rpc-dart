// Dart easy-rpc core: zero-runtime-bindings Transport + Connect wire
// (unary + server-stream). The bridge uses the official dart:io HttpClient
// (HTTP/1.1), which supports unary + chunked server-streams — matching the
// Go conformance server (net/http). Trade any HTTP runtime via a Transport.
import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'src/http2_transport.dart';



// Core is transport-agnostic: it exposes ONLY the abstract Transport contract,
// the wire primitives (Request/Response/RpcStream/framing) and a default
// dart:io bridge. Platform bridges (Http2Transport / FetchTransport /
// CronetHttpTransport / CupertinoHttpTransport) live in their own files and are
// imported explicitly by the caller — so generated SDKs never pull Flutter
// runtime deps. See `lib/src/http2_transport.dart`, `lib/src/mobile/*`.
export 'src/easyrpc/conformance/v1/conformance.pb.dart';

typedef Headers = Map<String, List<String>>;

/// A structured error detail (spec §4.1, aligned with Connect Error Details /
/// gRPC google.rpc status details). [type] is a type URL; [value] is opaque
/// bytes (typically an encoded protobuf message).
class ErrorDetail {
  final String type;
  final Uint8List value;
  const ErrorDetail(this.type, this.value);
  @override
  bool operator ==(Object other) =>
      other is ErrorDetail &&
      other.type == type &&
      other.value.length == value.length &&
      _bytesEqual(other.value, value);
  @override
  int get hashCode => Object.hash(type, Object.hashAll(value));
  static bool _bytesEqual(Uint8List a, Uint8List b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
  @override
  String toString() => 'ErrorDetail($type, ${value.length}B)';
}

class RPCError implements Exception {
  final int code;
  final String message;
  /// Optional structured details (spec §4.1); opaque to the wire layer.
  final List<ErrorDetail>? details;
  RPCError(this.code, this.message, [this.details]);
  @override
  String toString() => 'easyrpc: code=$code $message';
}

class Request {
  final String url;
  final String method;
  final Headers headers;
  final Uint8List? body;
  /// Local cancellation channel (a Completer that completes on abort). Adapters
  /// that support abort honour it; others ignore it.
  final Future<void>? abort;
  Request({
    required this.url,
    this.method = 'POST',
    this.headers = const {},
    this.body,
    this.abort,
  });
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
/// Backward-compatible alias (delegates to [rpcResponseError]).
RPCError rpcErrorFrom(int status, Map<String, List<String>> headers, List<int> body) =>
    rpcResponseError(status, headers, body)!;

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

List<Map<String, String>> _wireDetails(List<ErrorDetail>? details) =>
    (details ?? const [])
        .map((d) => {'type': d.type, 'value': base64.encode(d.value)})
        .toList();

/// Parse the wire details array; malformed entries are skipped, never fatal
/// (matrix M7).
List<ErrorDetail>? _parseWireDetails(Object? v) {
  if (v is! List) return null;
  final out = <ErrorDetail>[];
  for (final el in v) {
    if (el is! Map) continue;
    final t = el['type'];
    final val = el['value'];
    if (t is! String || t.isEmpty || val is! String || val.isEmpty) continue;
    try {
      out.add(ErrorDetail(t, base64.decode(val)));
    } catch (_) {
      // invalid base64: skip the entry
    }
  }
  return out.isEmpty ? null : out;
}

/// Connect unary error body {"code":name,"message":...[,details]}.
List<int> encodeErrorJson(int code, String message, [List<ErrorDetail>? details]) {
  final body = <String, Object?>{'code': codeToString(code), 'message': message};
  final wire = _wireDetails(details);
  if (wire.isNotEmpty) body['details'] = wire;
  return utf8.encode(jsonEncode(body));
}

/// Parse a Connect unary error body; (0, '', null) when not an error body.
(int, String, List<ErrorDetail>?) decodeErrorJson(List<int> body) {
  if (body.isEmpty) return (0, '', null);
  try {
    final v = jsonDecode(utf8.decode(body));
    if (v is Map && v['code'] is String) {
      return (
        codeFromString(v['code'] as String),
        (v['message'] as String?) ?? '',
        _parseWireDetails(v['details']),
      );
    }
  } catch (_) {}
  return (0, '', null);
}

/// Reconstruct an RPCError from a response, preferring the exact connect-code
/// header, then the Connect JSON body, then the lossy status mapping.
RPCError? rpcResponseError(int status, Map<String, List<String>> headers, List<int> body) {
  if (status < 300) return null;
  final code = headers['connect-code']?.first;
  final c = code == null ? null : int.tryParse(code);
  if (c != null) {
    // The header carries the exact code; the JSON body (when present) may
    // still carry details - merge them (details never travel in headers).
    final (_, _, hd) = decodeErrorJson(body);
    return RPCError(c, headers['connect-error']?.first ?? '', hd);
  }
  final (c2, m2, d2) = decodeErrorJson(body);
  if (c2 != 0) return RPCError(c2, m2, d2);
  return RPCError(connectFromStatus(status), body.isEmpty ? '' : utf8.decode(body));
}

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
/// end is empty. Details (spec §4.1) are included when non-empty.
Uint8List encodeEndStream(int code, String message, [List<ErrorDetail>? details]) {
  if (code == 0) return Uint8List(0);
  final err = <String, Object?>{'code': codeToString(code), 'message': message};
  final wire = _wireDetails(details);
  if (wire.isNotEmpty) err['details'] = wire;
  return Uint8List.fromList(utf8.encode(jsonEncode({'error': err})));
}

/// Decode a Connect end-stream payload into (code, message, details);
/// (0, '', null) = clean end. Malformed input is a clean end (matrix M2); an
/// error object without a code maps to 2 (M3/M4); unknown fields ignored (M5).
(int, String, List<ErrorDetail>?) decodeEndStream(Uint8List payload) {
  if (payload.isEmpty) return (0, '', null);
  try {
    final v = jsonDecode(utf8.decode(payload));
    if (v is! Map || v['error'] is! Map) return (0, '', null);
    final e = v['error'] as Map;
    return (
      e['code'] is String ? codeFromString(e['code'] as String) : 2,
      e['message'] is String ? e['message'] as String : '',
      _parseWireDetails(e['details']),
    );
  } catch (_) {
    return (0, '', null);
  }
}

const String kHeaderTimeout = 'connect-timeout-ms';
const String kHeaderProtocolVersion = 'connect-protocol-version';
const String kHeaderAcceptEncoding = 'connect-accept-encoding';
const String kEncodingGzip = 'gzip';
const int kCompressMinBytes = 1024;

/// gzip-compress bytes (identity on failure).
List<int> gzipCompress(List<int> data) {
  try { return io.GZipCodec().encode(data); } catch (_) { return data; }
}

/// gzip-decompress bytes (identity on failure).
List<int> gzipDecompress(List<int> data) {
  try { return io.GZipCodec().decode(data); } catch (_) { return data; }
}
const String kConnectProtocolVersion = '1';
const int kDefaultMaxMessageBytes = 4 * 1024 * 1024;

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
        if (len > kDefaultMaxMessageBytes) {
          throw RPCError(8, 'frame too large: $len > $kDefaultMaxMessageBytes');
        }
        if (_acc.length < 5 + len) break;
        var payload = Uint8List.fromList(_acc.sublist(5, 5 + len));
        _acc = Uint8List.fromList(_acc.sublist(5 + len));
        if ((flags & 0x01) != 0) {
          payload = Uint8List.fromList(gzipDecompress(payload));
        }
        if ((flags & kEndStream) != 0) {
          final (code, message, details) = decodeEndStream(payload);
          if (code != 0) throw RPCError(code, message, details);
          return;
        }
        yield payload;
      }
    }
  }
}

/// Adapter modes. [auto] picks by platform.
enum TransportMode { auto, io, http2 }

/// Composition root: pick an adapter by [mode], install the built-in metadata/
/// deadline interceptors, then any [extra]. Swapping [mode] leaves the
/// interceptors unchanged.
Transport connect({
  required String baseUrl,
  String token = '',
  TransportMode mode = TransportMode.auto,
  int timeoutMs = 0,
  List<Interceptor> extra = const [],
  io.HttpClient? httpClient,
}) {
  final base = baseUrl.endsWith('/')
      ? baseUrl.substring(0, baseUrl.length - 1)
      : baseUrl;
  Transport inner;
  switch (mode) {
    case TransportMode.http2:
      inner = Http2Transport(baseUrl: base);
      break;
    case TransportMode.io:
    case TransportMode.auto:
      inner = IoTransport(client: httpClient ?? io.HttpClient(), baseUrl: base);
      break;
  }
  final ics = <Interceptor>[
    if (token.isNotEmpty) MetadataInterceptor({'authorization': ['Bearer $token']}),
    if (timeoutMs > 0) TimeoutInterceptor(timeoutMs),
    ...extra,
  ];
  return ics.isEmpty ? inner : InterceptorTransport(ics, inner);
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

/// Attach a Connect deadline to every call; races and aborts locally so it
/// works over any adapter.
class TimeoutInterceptor extends Interceptor {
  final int ms;
  TimeoutInterceptor(this.ms);

  Future<T> _run<T>(Request req, Future<T> Function(Request) next) async {
    if (ms <= 0) return next(req);
    final ctrl = Completer<void>();
    final withAbort = Request(
      url: req.url,
      method: req.method,
      headers: req.headers,
      body: req.body,
      abort: ctrl.future,
    );
    final timed = withTimeout(withAbort, ms);
    try {
      return await next(timed).timeout(Duration(milliseconds: ms), onTimeout: () {
        ctrl.complete();
        throw RPCError(4, 'deadline exceeded');
      });
    } on TimeoutException {
      ctrl.complete();
      throw RPCError(4, 'deadline exceeded');
    }
  }

  @override
  Future<Response> unary(Request req, Future<Response> Function(Request) n) => _run(req, n);
  @override
  Future<RpcStream> stream(Request req, Future<RpcStream> Function(Request) n) => _run(req, n);
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
      rpcResponseError(status, h, body)!;

  Headers _hdrs(io.HttpHeaders h) {
    final out = <String, List<String>>{};
    h.forEach((k, values) => out[k] = values);
    return out;
  }

  void close() => _client.close();
}

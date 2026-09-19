// Dart easy-rpc core: zero-runtime-bindings Transport + Connect wire
// (unary + server-stream). The bridge uses the official dart:io HttpClient
// (HTTP/1.1), which supports unary + chunked server-streams — matching the
// Go conformance server (net/http). Trade any HTTP runtime via a Transport.
import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:protobuf/protobuf.dart' show GeneratedMessage;
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
  final Headers headers;
  final Uint8List? body;
  /// Local cancellation channel (a Completer that completes on abort). Adapters
  /// that support abort honour it; others ignore it.
  final Future<void>? abort;
  Request({
    required this.url,
    this.headers = const {},
    this.body,
    this.abort,
  });
}

class Response {
  final int status;
  final Headers headers;
  final Uint8List? body;
  /// Unary trailing metadata (demuxed from `trailer-*` response headers).
  final Headers trailers;
  final RPCError? error;
  Response({required this.status, this.headers = const {}, this.body, this.trailers = const {}, this.error});
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

/// Encode as UNPADDED standard base64 — matches Connect
/// (base64.RawStdEncoding).
String _b64Encode(List<int> data) => base64.encode(data).replaceAll('=', '');

/// Decode standard OR URL-safe base64, padded OR unpadded (Connect sends
/// unpadded). Throws on invalid input.
Uint8List _b64Decode(String s) {
  var t = s.replaceAll('-', '+').replaceAll('_', '/');
  if (t.length % 4 == 1) {
    throw const FormatException('invalid base64 length');
  }
  while (t.length % 4 != 0) {
    t += '=';
  }
  return Uint8List.fromList(base64.decode(t));
}

List<Map<String, String>> _wireDetails(List<ErrorDetail>? details) =>
    (details ?? const [])
        .map((d) => {'type': d.type, 'value': _b64Encode(d.value)})
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
      out.add(ErrorDetail(t, _b64Decode(val)));
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
Uint8List encodeEndStream(int code, String message,
    [List<ErrorDetail>? details, Headers metadata = const {}]) {
  final obj = <String, Object?>{};
  if (code != 0) {
    final err = <String, Object?>{'code': codeToString(code), 'message': message};
    final wire = _wireDetails(details);
    if (wire.isNotEmpty) err['details'] = wire;
    obj['error'] = err;
  }
  if (metadata.isNotEmpty) {
    final md = <String, List<String>>{};
    metadata.forEach((k, v) { if (v.isNotEmpty) md[k] = v; });
    if (md.isNotEmpty) obj['metadata'] = md;
  }
  return Uint8List.fromList(utf8.encode(jsonEncode(obj)));
}

/// A decoded END frame: code/message/details + trailing metadata.
class EndStream {
  final int code;
  final String message;
  final List<ErrorDetail>? details;
  final Headers metadata;
  EndStream(this.code, this.message, this.details, this.metadata);
}

/// Split headers into (headers, trailers) by the `trailer-` prefix.
(Headers, Headers) demuxTrailers(Headers all) {
  final h = <String, List<String>>{};
  final t = <String, List<String>>{};
  all.forEach((k, v) {
    if (k.toLowerCase().startsWith('trailer-')) {
      t[k.substring(8).toLowerCase()] = v;
    } else {
      h[k] = v;
    }
  });
  return (h, t);
}

/// Merge trailers into headers using the `trailer-` prefix.
Headers muxTrailers(Headers headers, Headers trailers) {
  final out = Map<String, List<String>>.from(headers);
  trailers.forEach((k, v) => out['trailer-${k.toLowerCase()}'] = v);
  return out;
}

/// Per-RPC context for generated handlers: request metadata + trailer channel.
class HandlerContext {
  final Headers headers;
  final _trailers = <String, List<String>>{};
  HandlerContext(this.headers);
  void setTrailer(String key, String value) =>
      _trailers[key] = [...(_trailers[key] ?? const []), value];
  Headers get trailers => _trailers;
}

const String kContentTypeUnary = 'application/proto';
const String kContentTypeStream = 'application/connect+proto';
const String kContentTypeUnaryJson = 'application/json';
const String kContentTypeStreamJson = 'application/connect+json';

/// Map a Content-Type to a codec ('proto' | 'json'), or null when unsupported.
String? contentKindOf(String? contentType) {
  final ct = (contentType ?? '').split(';').first.trim().toLowerCase();
  switch (ct) {
    case 'application/proto':
    case 'application/connect+proto':
      return 'proto';
    case 'application/json':
    case 'application/connect+json':
      return 'json';
  }
  return null;
}

/// True when the content type denotes the streaming shape.
bool isStreamContentType(String? contentType) {
  final ct = (contentType ?? '').split(';').first.trim().toLowerCase();
  return ct == 'application/connect+proto' || ct == 'application/connect+json';
}

/// The response Content-Type for a shape + codec.
String contentTypeFor(bool stream, String kind) => kind == 'json'
    ? (stream ? kContentTypeStreamJson : kContentTypeUnaryJson)
    : (stream ? kContentTypeStream : kContentTypeUnary);

/// Encode a generated message in the given codec (proto3 JSON uses the
/// canonical `toProto3Json` mapping: lowerCamelCase names, int64-as-string,
/// bytes base64, Any `@type`).
Uint8List encodeMsg(GeneratedMessage msg, String kind) => kind == 'json'
    ? Uint8List.fromList(utf8.encode(jsonEncode(msg.toProto3Json())))
    : msg.writeToBuffer();

/// Decode bytes into a generated message in the given codec. JSON ignores
/// unknown fields (matching Connect / protojson).
T decodeMsg<T extends GeneratedMessage>(List<int> data, T Function() create, String kind) {
  final msg = create();
  if (kind == 'json') {
    msg.mergeFromProto3Json(jsonDecode(utf8.decode(data)), ignoreUnknownFields: true);
  } else {
    msg.mergeFromBuffer(data);
  }
  return msg;
}

/// Decode a Connect end-stream payload into (code, message, details);
/// (0, '', null) = clean end. Malformed input is a clean end (matrix M2); an
/// error object without a code maps to 2 (M3/M4); unknown fields ignored (M5).
EndStream decodeEndStream(Uint8List payload) {
  if (payload.isEmpty) return EndStream(0, '', null, const {});
  try {
    final v = jsonDecode(utf8.decode(payload));
    if (v is! Map) return EndStream(0, '', null, const {});
    var metadata = <String, List<String>>{};
    final md = v['metadata'];
    if (md is Map) {
      md.forEach((k, val) {
        if (k is String && val is List) {
          final vs = val.whereType<String>().toList();
          if (vs.isNotEmpty) metadata[k] = vs;
        }
      });
    }
    final e = v['error'];
    if (e is! Map) return EndStream(0, '', null, metadata);
    return EndStream(
      e['code'] is String ? codeFromString(e['code'] as String) : 2,
      e['message'] is String ? e['message'] as String : '',
      _parseWireDetails(e['details']),
      metadata,
    );
  } catch (_) {
    return EndStream(0, '', null, const {});
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

/// gzip-decompress bytes. THROWS RPCError(13) on corrupt input (fault matrix
/// M10): a flagged-but-corrupt gzip payload is a protocol error, never raw
/// compressed bytes.
List<int> gzipDecompress(List<int> data) {
  try {
    return io.GZipCodec().decode(data);
  } catch (e) {
    throw RPCError(13, 'corrupt gzip frame: $e');
  }
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
    headers: {...req.headers, kHeaderTimeout: ['$timeoutMs']},
    body: req.body,
  );
}

class FrameReader {
  Uint8List _acc = Uint8List(0);
  Headers trailers = const {};
  Stream<Uint8List> frames(Stream<List<int>> chunks) async* {
    var sawEnd = false;
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
          sawEnd = true;
          final es = decodeEndStream(payload);
          if (es.metadata.isNotEmpty) trailers = es.metadata;
          if (es.code != 0) throw RPCError(es.code, es.message, es.details);
          return;
        }
        yield payload;
      }
    }
    // Fault matrix F2/M8: the Connect protocol requires every server-stream
    // to terminate with an END frame; a body that ends without one (or with
    // trailing partial bytes) was truncated mid-stream.
    if (_acc.isNotEmpty) {
      throw RPCError(13, 'truncated frame at end of stream');
    }
    if (!sawEnd) {
      throw RPCError(13, 'stream ended without END frame');
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
  final Headers Function() _trailers;
  RpcStream(this._payloads, [this._trailers = _noTrailers]);
  static Headers _noTrailers() => const {};
  Stream<Uint8List> get messages => _payloads;
  Headers trailers() => _trailers();
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
    return Request(url: req.url, headers: h, body: req.body);
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
    final r = await _client.openUrl('POST', uri);
    // Caller-supplied headers first (incl. a caller content-type — the JSON
    // codec depends on it); default ONLY when absent, shaped per call type.
    final hasCt = req.headers.keys.any((k) => k.toLowerCase() == 'content-type');
    req.headers.forEach((k, vs) {
      for (final v in vs) {
        r.headers.add(k, v);
      }
    });
    if (!hasCt) r.headers.contentType = io.ContentType('application', 'proto');
    r.headers.add('Accept-Encoding', 'gzip');
    if (req.body != null) r.add(req.body!);
    final resp = await r.close();
    var body = await resp.fold<Uint8List>(Uint8List(0), (a, b) => Uint8List.fromList([...a, ...b]));
    final all = _hdrs(resp.headers);
    final (hdrs, trailers) = demuxTrailers(all);
    if ((hdrs['content-encoding']?.isNotEmpty ?? false) && hdrs['content-encoding']!.first == 'gzip' && body.isNotEmpty) {
      body = Uint8List.fromList(gzipDecompress(body));
    }
    return Response(
      status: resp.statusCode,
      headers: hdrs,
      body: body,
      trailers: trailers,
      error: resp.statusCode >= 300 ? _errorOf(hdrs, resp.statusCode, body) : null,
    );
  }

  @override
  Future<RpcStream> openStream(Request req) async {
    final uri = Uri.parse(_url(req.url));
    final r = await _client.openUrl('POST', uri);
    // Caller-supplied headers first; default ONLY when absent.
    final hasCt = req.headers.keys.any((k) => k.toLowerCase() == 'content-type');
    req.headers.forEach((k, vs) {
      for (final v in vs) {
        r.headers.add(k, v);
      }
    });
    if (!hasCt) {
      r.headers.contentType = io.ContentType('application', 'connect+proto');
    }
    r.headers.add('Connect-Accept-Encoding', 'gzip');
    if (req.body != null) r.add(req.body!);
    final resp = await r.close();
    final raw = resp as Stream<List<int>>;
    final reader = FrameReader();
    return RpcStream(reader.frames(raw), () => reader.trailers);
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

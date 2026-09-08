// Dart easy-rpc core: zero-runtime-bindings Transport + Connect wire
// (unary + server-stream). The bridge uses the official dart:io HttpClient
// (HTTP/1.1), which supports unary + chunked server-streams — matching the
// Go conformance server (net/http). Trade any HTTP runtime via a Transport.
import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';



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
      3 => 400,
      5 => 404,
      7 => 403,
      8 => 429,
      16 => 401,
      14 => 503,
      _ => 500,
    };

int connectFromStatus(int status) => switch (status) {
      400 => 3,
      404 => 5,
      403 => 7,
      401 => 16,
      429 => 8,
      503 => 14,
      _ => 13,
    };

const kEndStream = 0x02;

Uint8List frame(Uint8List payload, {bool end = false}) {
  final out = Uint8List(5 + payload.length);
  out[0] = end ? kEndStream : 0;
  ByteData.sublistView(out).setUint32(1, payload.length);
  out.setRange(5, 5 + payload.length, payload);
  return out;
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
        yield payload;
        if ((flags & kEndStream) != 0) return;
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

class Transport {
  final io.HttpClient _client;
  final String baseUrl;
  Transport({io.HttpClient? client, this.baseUrl = ''}) : _client = client ?? io.HttpClient();
  String _url(String u) => u.startsWith('http') ? u : '$baseUrl$u';

  Future<Response> send(Request req) async {
    final uri = Uri.parse(_url(req.url));
    final r = await _client.openUrl(req.method, uri);
    r.headers.contentType = io.ContentType('application', 'proto');
    if (req.body != null) r.add(req.body!);
    final resp = await r.close();
    final body = await resp.fold<Uint8List>(Uint8List(0), (a, b) => Uint8List.fromList([...a, ...b]));
    return Response(
      status: resp.statusCode,
      headers: _hdrs(resp.headers),
      body: body,
      error: resp.statusCode >= 300 ? RPCError(connectFromStatus(resp.statusCode), body.isEmpty ? '' : utf8.decode(body)) : null,
    );
  }

  Future<RpcStream> openStream(Request req) async {
    final uri = Uri.parse(_url(req.url));
    final r = await _client.openUrl(req.method, uri);
    r.headers.contentType = io.ContentType('application', 'connect+proto');
    if (req.body != null) r.add(req.body!);
    final resp = await r.close();
    // Use raw byte stream: resp is Stream<List<int>>.
    final raw = resp as Stream<List<int>>;
    return RpcStream(FrameReader().frames(raw));
  }

  Headers _hdrs(io.HttpHeaders h) {
    final out = <String, List<String>>{};
    h.forEach((k, values) => out[k] = values);
    return out;
  }

  void close() => _client.close();
}

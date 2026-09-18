// Wire golden-vector conformance (transport-independent): the protocol layer
// must reproduce easy-rpc-spec/conformance/wire-vectors.json. Frames are
// byte-exact; JSON payloads compare SEMANTICALLY (key order is not significant).
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_rpc/easy_rpc.dart';
import 'package:test/test.dart';

Map<String, dynamic> _load() {
  final f = File('test/testdata/wire-vectors.json');
  return jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
}

String _hex(List<int> b) => b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
Uint8List _unhex(String s) =>
    Uint8List.fromList([for (var i = 0; i < s.length; i += 2) int.parse(s.substring(i, i + 2), radix: 16)]);
String _canon(List<int> b) => jsonEncode(jsonDecode(utf8.decode(b)));
String _canonStr(String s) => jsonEncode(jsonDecode(s));

void main() {
  final v = _load();

  test('frames (byte-exact)', () {
    for (final f in (v['frames'] as List).cast<Map<String, dynamic>>()) {
      final e = f['encode'] as Map<String, dynamic>;
      final raw = frame(_unhex(e['payloadHex'] as String), end: e['end'] as bool);
      if (e['compressed'] as bool) raw[0] |= 0x01;
      expect(_hex(raw), f['bytesHex'], reason: f['name'] as String);
    }
  });

  test('end-stream decode+encode (semantic)', () {
    for (final m in (v['endStream'] as List).cast<Map<String, dynamic>>()) {
      final dec = m['decode'] as Map<String, dynamic>;
      final es = decodeEndStream(_unhex(dec['bytesHex'] as String));
      expect(es.code, m['code'], reason: '${m['name']} code');
      expect(es.message, m['message'], reason: '${m['name']} message');
      if (m['metadata'] != null) expect(es.metadata, m['metadata'], reason: '${m['name']} metadata');
      final enc = m['encode'] as Map<String, dynamic>?;
      if (enc != null && m['bytesHex'] != null) {
        final md = <String, List<String>>{};
        final em = enc['metadata'] as Map<String, dynamic>?;
        em?.forEach((k, val) => md[k] = (val as List).cast<String>());
        final got = encodeEndStream(enc['code'] as int, enc['message'] as String, null, md);
        expect(_canon(got), _canonStr(utf8.decode(_unhex(m['bytesHex'] as String))), reason: '${m['name']} encode');
      }
    }
  });

  test('unary error json (semantic)', () {
    for (final u in (v['unaryError'] as List).cast<Map<String, dynamic>>()) {
      final enc = u['encode'] as Map<String, dynamic>;
      final ds = enc['details'] as List?;
      final details = ds
          ?.map((d) => ErrorDetail((d as Map)['type'] as String, _unhex(d['valueHex'] as String)))
          .toList();
      final got = encodeErrorJson(enc['code'] as int, enc['message'] as String, details);
      expect(_canon(got), _canonStr(utf8.decode(_unhex(u['bytesHex'] as String))), reason: u['name'] as String);
    }
  });

  test('trailer mux/demux', () {
    for (final t in (v['trailerHeaders'] as List).cast<Map<String, dynamic>>()) {
      final demux = t['demux'] as Map<String, dynamic>?;
      if (demux != null) {
        final md = <String, List<String>>{};
        demux.forEach((k, val) => md[k] = (val as List).cast<String>());
        final (h, tl) = demuxTrailers(md);
        expect(h, t['headers'], reason: '${t['name']} headers');
        expect(tl, t['trailers'], reason: '${t['name']} trailers');
      }
      final mux = t['mux'] as Map<String, dynamic>?;
      if (mux != null) {
        final h = <String, List<String>>{};
        final tl = <String, List<String>>{};
        (mux['headers'] as Map).forEach((k, val) => h[k] = (val as List).cast<String>());
        (mux['trailers'] as Map).forEach((k, val) => tl[k] = (val as List).cast<String>());
        expect(muxTrailers(h, tl), t['result'], reason: '${t['name']} mux');
      }
    }
  });

  test('code/http map', () {
    for (final c in (v['codeNames'] as List).cast<Map<String, dynamic>>()) {
      final code = c['code'] as int;
      expect(codeToString(code), c['name'], reason: 'code $code');
      expect(codeFromString(c['name'] as String), code, reason: 'name ${c['name']}');
      if (code != 0) expect(httpStatus(code), c['http'], reason: 'http $code');
    }
  });
}

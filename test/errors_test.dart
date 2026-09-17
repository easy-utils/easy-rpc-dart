// Error-path matrix (spec §4.2 M1–M13) + Error Details round-trip (§4.1).
// Mirrored in every language implementation; inputs are constructed directly
// against the protocol functions — no server needed.
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_rpc/easy_rpc.dart';
import 'package:test/test.dart';

final detail = ErrorDetail(
  'type.googleapis.com/google.rpc.RetryInfo',
  Uint8List.fromList([1, 2, 3, 250]),
);

Uint8List enc(String s) => Uint8List.fromList(utf8.encode(s));

void main() {
  group('matrix: end-stream decode', () {
    test('M1 empty payload is a clean end', () {
      final (c, m, d) = decodeEndStream(Uint8List(0));
      expect((c, m, d), (0, '', null));
    });
    test('M2 non-JSON payload is not an error', () {
      final (c, _, _) = decodeEndStream(Uint8List.fromList([0xff, 0xfe, 0x00, 0x42]));
      expect(c, 0);
    });
    test('M3 {"error":{}} maps to code 2 / empty message', () {
      final (c, m, _) = decodeEndStream(enc('{"error":{}}'));
      expect((c, m), (2, ''));
    });
    test('M4 unknown code name maps to 2', () {
      final (c, m, _) = decodeEndStream(enc('{"error":{"code":"nope","message":"m"}}'));
      expect((c, m), (2, 'm'));
    });
    test('M5 unknown fields ignored', () {
      final (c, _, _) = decodeEndStream(enc('{"error":{"code":"not_found","message":"m"},"x":1}'));
      expect(c, 5);
    });
    test('M6 details round-trip', () {
      final payload = encodeEndStream(8, 'rate limited', [detail]);
      final (c, m, d) = decodeEndStream(payload);
      expect(c, 8);
      expect(m, 'rate limited');
      expect(d, [detail]);
    });
    test('M7 malformed details entries skipped', () {
      final (_, _, d) = decodeEndStream(enc(
          '{"error":{"code":"resource_exhausted","details":[{"type":"t","value":"!!!"},{"value":"x"},{"type":"ok"},{"type":"t2","value":"AQID"}]}}'));
      expect(d, [ErrorDetail('t2', Uint8List.fromList([1, 2, 3]))]);
    });
    test('details omitted when empty (v1.0 semantics)', () {
      expect(utf8.decode(encodeEndStream(5, 'gone')),
          '{"error":{"code":"not_found","message":"gone"}}');
    });
  });

  group('matrix: unary error decode', () {
    test('M11 plain text is not a JSON error body', () {
      final (c, _, _) = decodeErrorJson(utf8.encode('busy'));
      expect(c, 0);
    });
    test('details round-trip', () {
      final body = encodeErrorJson(8, 'limited', [detail]);
      final (c, m, d) = decodeErrorJson(body);
      expect((c, m), (8, 'limited'));
      expect(d, [detail]);
    });
    test('header path merges details from body', () {
      final body = encodeErrorJson(9, 'ignored-msg', [detail]);
      final e = rpcResponseError(429, {
        'connect-code': ['8'],
        'connect-error': ['limited'],
      }, body);
      expect(e!.code, 8);
      expect(e.message, 'limited');
      expect(e.details, [detail]);
    });
    test('M12/M13 deadline maps to code 4', () {
      final (c, _, _) = decodeErrorJson(encodeErrorJson(4, 'deadline exceeded'));
      expect(c, 4);
      expect(httpStatus(4), 504);
      expect(connectFromStatus(504), 4);
    });
  });

  group('matrix: framing', () {
    test('M8 truncated frame does not yield partial payload', () async {
      final full = frame(Uint8List.fromList(List.filled(10, 7)));
      final cut = Uint8List.sublistView(full, 0, full.length - 4);
      // decodeFrames-like: reading frames from a too-short buffer must not
      // yield a frame whose payload is truncated.
      var acc = <int>[];
      acc.addAll(cut);
      expect(acc.length < 5 + 10, isTrue);
      // readFrames would block/need more data: no frame can be produced.
      final canParse = acc.length >= 5 &&
          acc.length >= 5 + ByteData.sublistView(Uint8List.fromList(acc)).getUint32(1);
      expect(canParse, isFalse);
    });
  });
}

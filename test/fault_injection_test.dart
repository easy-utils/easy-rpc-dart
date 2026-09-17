// Fault injection (spec §4.2 M8/M10 + F2) at the protocol level: the frame
// reader MUST error on truncated/END-less/corrupt-gzip bodies, reassemble
// frames split across chunks, and treat a garbage END payload as a clean end.
import 'dart:io' as io;
import 'dart:typed_data';

import 'dart:async';

import 'package:easy_rpc/easy_rpc.dart';
import 'package:test/test.dart';

Uint8List frame(List<int> payload, {bool end = false, bool compressed = false}) {
  final flags = (end ? 0x02 : 0) | (compressed ? 0x01 : 0);
  final out = Uint8List(5 + payload.length);
  out[0] = flags;
  ByteData.sublistView(out).setUint32(1, payload.length);
  out.setRange(5, 5 + payload.length, payload);
  return out;
}

Stream<Uint8List> chunks(List<Uint8List> data, {int split = 1 << 30}) async* {
  for (final d in data) {
    if (d.length <= split) {
      yield d;
    } else {
      for (var i = 0; i < d.length; i += split) {
        yield Uint8List.sublistView(d, i, (i + split).clamp(0, d.length));
      }
    }
  }
}

Future<List<int>> readAll(Stream<Uint8List> s) async => [await for (final c in s) c[0]];

void main() {
  test('F1 mid-frame truncation errors', () async {
    final full = frame(List.filled(8, 1));
    final cut = Uint8List.sublistView(full, 0, full.length - 4);
    final out = await readAll(FrameReader()
        .frames(chunks([frame(List.filled(1, 0)), cut]))
        .handleError((_) {}, test: (e) => e is RPCError)); // swallow the expected tail error
    expect(out, [0]);
    await expectLater(
        readAll(FrameReader().frames(chunks([frame(List.filled(1, 0)), cut]))),
        throwsA(isA<RPCError>()));
  });

  test('F2 body ends without END frame => error', () async {
    await expectLater(
        FrameReader().frames(chunks([frame(List.filled(1, 0)), frame(List.filled(1, 1))])).drain<void>(),
        throwsA(isA<RPCError>()));
  });

  test('F3 garbage END payload => clean end after data frames', () async {
    final r = FrameReader()
        .frames(chunks([frame(List.filled(1, 0)), frame([0xff, 0xfe, 0x42], end: true)]));
    expect(readAll(r), completion([0]));
  });

  test('F4 corrupt gzip => RPCError, never raw bytes', () async {
    // valid gzip stream with a corrupted middle byte (Dart's decoder is
    // lenient about a missing trailer, so corrupt the deflate data itself).
    final gz = Uint8List.fromList(io.GZipCodec().encode([1, 2, 3]));
    gz[gz.length >> 1] ^= 0xff;
    final r = FrameReader().frames(chunks([
      frame(gz, compressed: true),
      frame([], end: true),
    ]));
    try {
      await r.drain<void>();
      fail('F4: expected RPCError');
    } on RPCError {
      // expected
    }
  });

  test('F5 frames split across chunk boundaries reassemble', () async {
    final body = Uint8List.fromList([
      ...frame(List.filled(1, 0)),
      ...frame(List.filled(1, 1)),
      ...frame([], end: true),
    ]);
    final r = FrameReader().frames(chunks([body], split: 3));
    expect(readAll(r), completion([0, 1]));
  });

  test('F6 valid gzip frame decodes', () async {
    final gz = Uint8List.fromList(io.GZipCodec().encode([7]));
    final r = FrameReader().frames(chunks([frame(gz, compressed: true), frame([], end: true)]));
    expect(readAll(r), completion([7]));
  });
}

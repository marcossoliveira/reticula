import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:reticula_app/src/core/document.dart';
import 'package:reticula_app/src/core/document_builder.dart';
import 'package:reticula_app/src/core/geometry.dart';
import 'package:reticula_app/src/core/grid.dart';
import 'package:reticula_app/src/core/paper.dart';
import 'package:reticula_app/src/core/placed_image.dart';
import 'package:reticula_app/src/export/pdf_exporter.dart';
import 'package:reticula_app/src/export/resolved_image.dart';

// A minimal valid 1x1 PNG, enough to exercise the full export pipeline.
const _onePxPngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  test('PDF export builds a real PDF from the document model', () async {
    final bytes = base64Decode(_onePxPngBase64);

    final doc = buildDocument(
      paper: paperA4,
      orientation: PageOrientation.landscape,
      grid: const GridSpec(2, 1),
    ).withImage(
      const PlacedImage(
        id: 'img-slot-1',
        slotId: 'slot-1',
        imagePath: 'memory',
      ),
    );

    final pdf = await PdfExporter.build(doc, {
      'img-slot-1': ResolvedImage(bytes: bytes, size: const PixelSize(1, 1)),
    });

    // Looks like a PDF and isn't trivially empty.
    expect(String.fromCharCodes(pdf.sublist(0, 5)), '%PDF-');
    expect(pdf.length, greaterThan(400));
  });
}

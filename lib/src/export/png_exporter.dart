/// Builds a raster PNG from a [ReticulaDocument] at a real DPI.
///
/// The PNG is rasterized from the *same* PDF produced by [PdfExporter], at the
/// requested [dpi]. This guarantees the PNG and PDF are pixel-for-pixel the same
/// layout, and that the output size is derived from physical dimensions — not
/// from the preview/window size.
///
/// For A4 landscape (297 x 210 mm) at 300 DPI this yields ~3508 x 2480 px.
library;

import 'dart:typed_data';

import 'package:printing/printing.dart';

import '../core/document.dart';
import 'pdf_exporter.dart';
import 'resolved_image.dart';

class PngExporter {
  static Future<Uint8List> build(
    ReticulaDocument doc,
    Map<String, ResolvedImage> imagesById, {
    double dpi = 300,
  }) async {
    final pdfBytes = await PdfExporter.build(doc, imagesById);

    await for (final page in Printing.raster(pdfBytes, dpi: dpi)) {
      return page.toPng();
    }

    throw StateError('Não foi possível rasterizar o PDF para PNG.');
  }
}

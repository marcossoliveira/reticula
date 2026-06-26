/// Builds raster (PNG/JPEG) output from a [ReticulaDocument] at a real DPI.
///
/// The raster is produced from the *same* PDF that [PdfExporter] builds, so the
/// pixels match the PDF exactly and the size is derived from physical
/// dimensions (e.g. A4 landscape @ 300 DPI ≈ 3508 × 2480 px).
library;

import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:printing/printing.dart';

import '../core/document.dart';
import 'pdf_exporter.dart';
import 'resolved_image.dart';

class RasterExporter {
  static Future<Uint8List> png(
    ReticulaDocument doc,
    Map<String, ResolvedImage> imagesById, {
    double dpi = 300,
  }) async {
    final raster = await _raster(doc, imagesById, dpi);
    return raster.toPng();
  }

  static Future<Uint8List> jpeg(
    ReticulaDocument doc,
    Map<String, ResolvedImage> imagesById, {
    double dpi = 300,
    int quality = 92,
  }) async {
    final raster = await _raster(doc, imagesById, dpi);
    final image = img.Image.fromBytes(
      width: raster.width,
      height: raster.height,
      bytes: raster.pixels.buffer,
      numChannels: 4,
      order: img.ChannelOrder.rgba,
    );
    return img.encodeJpg(image, quality: quality);
  }

  static Future<PdfRaster> _raster(
    ReticulaDocument doc,
    Map<String, ResolvedImage> imagesById,
    double dpi,
  ) async {
    final pdfBytes = await PdfExporter.build(doc, imagesById);
    await for (final page in Printing.raster(pdfBytes, dpi: dpi)) {
      return page;
    }
    throw StateError('Não foi possível rasterizar o PDF.');
  }
}

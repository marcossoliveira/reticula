// Dev tool — synthesizes two test images, runs them through the *real* Reticula
// export pipeline (PdfExporter), and writes a sample PDF. Handy for eyeballing
// the layout and checking physical page geometry without the GUI.
//
// Run from the app directory:
//   dart run tool/sample_export.dart [output_dir]
//
// Note: PNG export in the app rasterizes this same PDF at 300 DPI via the
// `printing` plugin, which needs a running Flutter engine, so it is not
// exercised here.

import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import 'package:reticula_app/src/core/geometry.dart';
import 'package:reticula_app/src/core/placed_image.dart';
import 'package:reticula_app/src/core/presets.dart';
import 'package:reticula_app/src/core/units.dart';
import 'package:reticula_app/src/export/pdf_exporter.dart';
import 'package:reticula_app/src/export/resolved_image.dart';

Uint8List _makeTestImage({
  required int width,
  required int height,
  required img.Color bg,
  required img.Color accent,
  required String label,
}) {
  final image = img.Image(width: width, height: height);
  img.fill(image, color: bg);

  // Corner markers so any cropping is obvious.
  const cm = 70;
  for (final c in [
    [0, 0],
    [width - cm, 0],
    [0, height - cm],
    [width - cm, height - cm],
  ]) {
    img.fillRect(image,
        x1: c[0], y1: c[1], x2: c[0] + cm, y2: c[1] + cm, color: accent);
  }

  // Outer border + centre circle to gauge framing.
  img.drawRect(image,
      x1: 6, y1: 6, x2: width - 7, y2: height - 7, color: accent, thickness: 10);
  img.fillCircle(image,
      x: width ~/ 2,
      y: height ~/ 2,
      radius: (width < height ? width : height) ~/ 4,
      color: accent);

  img.drawString(image, label,
      font: img.arial48, x: 26, y: 26, color: img.ColorRgb8(255, 255, 255));
  return img.encodePng(image);
}

Future<void> main(List<String> args) async {
  final outDir = args.isNotEmpty ? args.first : Directory.systemTemp.path;

  // Different aspect ratios to exercise the cover-crop math in each slot.
  final img1 = _makeTestImage(
    width: 1800,
    height: 1200,
    bg: img.ColorRgb8(0x2E, 0x5C, 0xFF),
    accent: img.ColorRgb8(0xFF, 0xD6, 0x00),
    label: 'FOTO 1 - 1800x1200 paisagem',
  );
  final img2 = _makeTestImage(
    width: 1200,
    height: 1800,
    bg: img.ColorRgb8(0x18, 0x9E, 0x5C),
    accent: img.ColorRgb8(0xFF, 0x3D, 0x71),
    label: 'FOTO 2 - 1200x1800 retrato',
  );

  final doc = presetA4TwoA5Landscape
      .build()
      .withImage(const PlacedImage(
          id: 'img-slot-1', slotId: 'slot-1', imagePath: 'memory-1'))
      .withImage(const PlacedImage(
          id: 'img-slot-2', slotId: 'slot-2', imagePath: 'memory-2'));

  final images = {
    'img-slot-1':
        ResolvedImage(bytes: img1, size: const PixelSize(1800, 1200)),
    'img-slot-2':
        ResolvedImage(bytes: img2, size: const PixelSize(1200, 1800)),
  };

  final pdf = await PdfExporter.build(doc, images);
  final path = '$outDir/reticula_sample.pdf';
  await File(path).writeAsBytes(pdf);

  stdout.writeln('Page: ${doc.page.widthMm} x ${doc.page.heightMm} mm  ->  '
      '${mmToPt(doc.page.widthMm).toStringAsFixed(2)} x '
      '${mmToPt(doc.page.heightMm).toStringAsFixed(2)} pt');
  stdout.writeln('PNG @300DPI would be '
      '${mmToPx(doc.page.widthMm, 300).round()} x '
      '${mmToPx(doc.page.heightMm, 300).round()} px');
  stdout.writeln('PDF bytes: ${pdf.length}');
  stdout.writeln('Wrote: $path');
}

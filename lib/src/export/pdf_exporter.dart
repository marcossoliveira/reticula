/// Builds a print-ready PDF from a [ReticulaDocument].
///
/// The page is sized to the document's physical dimensions with zero margin,
/// and each image is positioned using the shared [LayoutEngine] — so the PDF is
/// computed from the model, never captured from the screen.
library;

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../core/document.dart';
import '../core/layout_engine.dart';
import '../core/units.dart';
import 'resolved_image.dart';

class PdfExporter {
  /// Builds the PDF bytes. [imagesById] maps each [PlacedImage.id] to its
  /// resolved bytes + intrinsic size.
  static Future<Uint8List> build(
    ReticulaDocument doc,
    Map<String, ResolvedImage> imagesById,
  ) async {
    final pageFormat = PdfPageFormat(
      mmToPt(doc.page.widthMm),
      mmToPt(doc.page.heightMm),
    );

    // Decode each image once, up front.
    final providers = <String, pw.MemoryImage>{
      for (final entry in imagesById.entries)
        entry.key: pw.MemoryImage(entry.value.bytes),
    };

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        margin: pw.EdgeInsets.zero,
        build: (context) {
          final children = <pw.Widget>[
            // Page-sized white background (non-positioned, so the Stack sizes to
            // the full page). Empty slots / transparency then print white.
            pw.Container(
              width: pageFormat.width,
              height: pageFormat.height,
              color: PdfColors.white,
            ),
          ];

          for (final placed in doc.images) {
            final slot = doc.slotById(placed.slotId);
            final resolved = imagesById[placed.id];
            final provider = providers[placed.id];
            if (slot == null || resolved == null || provider == null) continue;

            final geom = LayoutEngine.placement(
              slot: slot.rect,
              image: resolved.size,
              placement: placed,
            );
            final clip = geom.clip;
            final dest = geom.dest;

            children.add(
              pw.Positioned(
                left: mmToPt(clip.x),
                top: mmToPt(clip.y),
                child: pw.SizedBox(
                  width: mmToPt(clip.width),
                  height: mmToPt(clip.height),
                  // The slot acts as a mask: draw the full image, clip to slot.
                  child: pw.ClipRect(
                    child: pw.Stack(
                      children: [
                        pw.Positioned(
                          left: mmToPt(dest.x - clip.x),
                          top: mmToPt(dest.y - clip.y),
                          child: pw.SizedBox(
                            width: mmToPt(dest.width),
                            height: mmToPt(dest.height),
                            child: pw.Image(provider, fit: pw.BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return pw.Stack(children: children);
        },
      ),
    );

    return pdf.save();
  }
}

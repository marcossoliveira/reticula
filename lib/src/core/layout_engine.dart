/// The crop/framing math — shared by the preview and every exporter.
///
/// Everything here works in millimetres (page space). A renderer computes the
/// placement once, then scales the resulting rectangles into its own unit
/// (pt for PDF, px for PNG, screen-px for the preview). This is what guarantees
/// the preview and the printed output frame each image identically.
library;

import 'geometry.dart';
import 'placed_image.dart';

/// The geometry needed to draw one placed image: draw the whole image into
/// [dest], but clip it to [clip] (the slot).
class ImagePlacementGeometry {
  /// The slot rectangle the image is clipped to (page space, mm).
  final RectMm clip;

  /// The rectangle the *entire* image is drawn into (page space, mm). May
  /// extend beyond [clip]; the renderer must clip to [clip].
  final RectMm dest;

  const ImagePlacementGeometry({required this.clip, required this.dest});
}

class LayoutEngine {
  /// The display size (mm) of [image] in [slot] for the given [mode], at
  /// scale 1.0 (before the user's zoom is applied).
  static SizeMm baseFitSize(SizeMm slot, PixelSize image, CropMode mode) {
    final slotAspect = slot.aspect;
    final imageAspect = image.aspect;

    switch (mode) {
      case CropMode.stretch:
        return SizeMm(slot.width, slot.height);

      case CropMode.cover:
        // Smallest size that still covers the slot.
        if (imageAspect >= slotAspect) {
          // Image relatively wider: match height, overflow width.
          return SizeMm(slot.height * imageAspect, slot.height);
        } else {
          // Image relatively taller: match width, overflow height.
          return SizeMm(slot.width, slot.width / imageAspect);
        }

      case CropMode.contain:
        // Largest size that still fits inside the slot.
        if (imageAspect >= slotAspect) {
          return SizeMm(slot.width, slot.width / imageAspect);
        } else {
          return SizeMm(slot.height * imageAspect, slot.height);
        }
    }
  }

  /// Computes where to draw [placement] (which references the image whose
  /// intrinsic pixel size is [image]) inside [slot].
  static ImagePlacementGeometry placement({
    required RectMm slot,
    required PixelSize image,
    required PlacedImage placement,
  }) {
    final base = baseFitSize(slot.size, image, placement.cropMode);
    final displayWidth = base.width * placement.scale;
    final displayHeight = base.height * placement.scale;

    // Centre in the slot, then apply the user's pan (mm).
    final destX = slot.x + (slot.width - displayWidth) / 2 + placement.offsetX;
    final destY = slot.y + (slot.height - displayHeight) / 2 + placement.offsetY;

    return ImagePlacementGeometry(
      clip: slot,
      dest: RectMm(
        x: destX,
        y: destY,
        width: displayWidth,
        height: displayHeight,
      ),
    );
  }

  /// Clamps a `cover` placement so the image always fully covers the slot:
  /// scale never drops below 1.0, and the pan can't expose an empty edge.
  ///
  /// This enforces the "fill the area, no margins, don't let the image leak
  /// past the quadrant" requirement. Non-cover modes are returned unchanged.
  static PlacedImage clampToCover({
    required RectMm slot,
    required PixelSize image,
    required PlacedImage placement,
  }) {
    if (placement.cropMode != CropMode.cover) return placement;

    final scale = placement.scale < 1.0 ? 1.0 : placement.scale;
    final base = baseFitSize(slot.size, image, CropMode.cover);
    final displayWidth = base.width * scale;
    final displayHeight = base.height * scale;

    // How far the centre may move before an empty edge would show.
    final maxOffsetX = (displayWidth - slot.width) / 2;
    final maxOffsetY = (displayHeight - slot.height) / 2;

    final offsetX = placement.offsetX.clamp(-maxOffsetX, maxOffsetX).toDouble();
    final offsetY = placement.offsetY.clamp(-maxOffsetY, maxOffsetY).toDouble();

    return placement.copyWith(
      scale: scale,
      offsetX: offsetX,
      offsetY: offsetY,
    );
  }
}

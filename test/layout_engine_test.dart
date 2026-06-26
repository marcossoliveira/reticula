import 'package:flutter_test/flutter_test.dart';

import 'package:reticula_app/src/core/geometry.dart';
import 'package:reticula_app/src/core/layout_engine.dart';
import 'package:reticula_app/src/core/placed_image.dart';

void main() {
  // A5-portrait slot (the right-hand slot of the A4/2×A5 preset).
  const slot = RectMm(x: 148.5, y: 0, width: 148.5, height: 210);

  bool covers(RectMm dest, RectMm s) =>
      dest.left <= s.left + 1e-9 &&
      dest.top <= s.top + 1e-9 &&
      dest.right >= s.right - 1e-9 &&
      dest.bottom >= s.bottom - 1e-9;

  test('cover fit of a square image matches the slot height', () {
    const img = PixelSize(1000, 1000); // aspect 1.0 >= slot aspect (~0.707)
    final size = LayoutEngine.baseFitSize(slot.size, img, CropMode.cover);
    expect(size.height, closeTo(210, 1e-9));
    expect(size.width, closeTo(210, 1e-9));
  });

  test('default placement (scale 1, no offset) fully covers the slot', () {
    const img = PixelSize(1000, 1500); // portrait-ish
    const placed = PlacedImage(id: 'i', slotId: 'slot-2', imagePath: 'x');
    final geom =
        LayoutEngine.placement(slot: slot, image: img, placement: placed);
    expect(covers(geom.dest, slot), isTrue);
  });

  test('clampToCover forbids zoom < 1 and panning past the edges', () {
    const img = PixelSize(1000, 1000);
    const placed = PlacedImage(
      id: 'i',
      slotId: 'slot-2',
      imagePath: 'x',
      scale: 0.4,
      offsetX: 9999,
      offsetY: 9999,
    );
    final clamped =
        LayoutEngine.clampToCover(slot: slot, image: img, placement: placed);

    expect(clamped.scale, 1.0);
    final geom =
        LayoutEngine.placement(slot: slot, image: img, placement: clamped);
    // Even after extreme pan, the image must still cover the slot.
    expect(covers(geom.dest, slot), isTrue);
  });

  test('contain fit stays within the slot', () {
    const img = PixelSize(3000, 1000); // wide
    final size = LayoutEngine.baseFitSize(slot.size, img, CropMode.contain);
    expect(size.width, lessThanOrEqualTo(slot.width + 1e-9));
    expect(size.height, lessThanOrEqualTo(slot.height + 1e-9));
  });
}

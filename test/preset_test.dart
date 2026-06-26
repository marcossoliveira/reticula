import 'package:flutter_test/flutter_test.dart';

import 'package:reticula_app/src/core/document.dart';
import 'package:reticula_app/src/core/presets.dart';

void main() {
  test('A4 / 2 fotos A5 landscape preset geometry', () {
    final doc = presetA4TwoA5Landscape.build();

    expect(doc.page.widthMm, 297);
    expect(doc.page.heightMm, 210);
    expect(doc.page.orientation, PageOrientation.landscape);

    expect(doc.slots.length, 2);
    final s1 = doc.slotById('slot-1')!;
    final s2 = doc.slotById('slot-2')!;

    expect(s1.rect.x, 0);
    expect(s1.rect.width, 148.5);
    expect(s1.rect.height, 210);
    expect(s2.rect.x, 148.5);

    // Slots tile the page edge-to-edge with no gap or overlap.
    expect(s1.rect.right, closeTo(s2.rect.left, 1e-9));
    expect(s2.rect.right, closeTo(297, 1e-9));
  });

  test('A4 / 2 fotos A5 portrait preset geometry', () {
    final doc = presetA4TwoA5Portrait.build();

    expect(doc.page.widthMm, 210);
    expect(doc.page.heightMm, 297);
    expect(doc.page.orientation, PageOrientation.portrait);

    expect(doc.slots.length, 2);
    final s1 = doc.slotById('slot-1')!;
    final s2 = doc.slotById('slot-2')!;

    // A5-landscape areas stacked, tiling the page top-to-bottom.
    expect(s1.rect.width, 210);
    expect(s1.rect.height, 148.5);
    expect(s1.rect.y, 0);
    expect(s2.rect.y, 148.5);
    expect(s1.rect.bottom, closeTo(s2.rect.top, 1e-9));
    expect(s2.rect.bottom, closeTo(297, 1e-9));
  });

  test('document JSON round-trips', () {
    final doc = presetA4TwoA5Landscape.build();
    final restored = ReticulaDocument.fromJson(doc.toJson());
    expect(restored.slots.length, doc.slots.length);
    expect(restored.page.widthMm, doc.page.widthMm);
    expect(restored.slots.first.rect.width, doc.slots.first.rect.width);
  });
}

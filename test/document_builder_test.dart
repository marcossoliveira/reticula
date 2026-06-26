import 'package:flutter_test/flutter_test.dart';

import 'package:reticula_app/src/core/document.dart';
import 'package:reticula_app/src/core/document_builder.dart';
import 'package:reticula_app/src/core/grid.dart';
import 'package:reticula_app/src/core/paper.dart';

void main() {
  test('A4 landscape 2×1 = two A5-portrait slots side by side', () {
    final doc = buildDocument(
      paper: paperA4,
      orientation: PageOrientation.landscape,
      grid: const GridSpec(2, 1),
    );

    expect(doc.page.widthMm, 297);
    expect(doc.page.heightMm, 210);
    expect(doc.slots.length, 2);

    final s1 = doc.slotById('slot-1')!;
    final s2 = doc.slotById('slot-2')!;
    expect(s1.rect.width, closeTo(148.5, 1e-9));
    expect(s1.rect.height, 210);
    expect(s2.rect.x, closeTo(148.5, 1e-9));
    expect(s2.rect.right, closeTo(297, 1e-9));
  });

  test('A4 portrait 1×2 = two A5-landscape slots stacked', () {
    final doc = buildDocument(
      paper: paperA4,
      orientation: PageOrientation.portrait,
      grid: const GridSpec(1, 2),
    );

    expect(doc.page.widthMm, 210);
    expect(doc.page.heightMm, 297);

    final s1 = doc.slotById('slot-1')!;
    final s2 = doc.slotById('slot-2')!;
    expect(s1.rect.width, 210);
    expect(s1.rect.height, closeTo(148.5, 1e-9));
    expect(s2.rect.y, closeTo(148.5, 1e-9));
    expect(s2.rect.bottom, closeTo(297, 1e-9));
  });

  test('a grid tiles the page edge-to-edge with no gaps (3×4 on A4 portrait)',
      () {
    final doc = buildDocument(
      paper: paperA4,
      orientation: PageOrientation.portrait,
      grid: const GridSpec(3, 4),
    );

    expect(doc.slots.length, 12);

    final pageArea = doc.page.widthMm * doc.page.heightMm;
    final slotArea = doc.slots
        .fold<double>(0, (a, s) => a + s.rect.width * s.rect.height);
    expect(slotArea, closeTo(pageArea, 1e-6));

    final last = doc.slots.last;
    expect(last.rect.right, closeTo(doc.page.widthMm, 1e-9));
    expect(last.rect.bottom, closeTo(doc.page.heightMm, 1e-9));
  });

  test('document JSON round-trips', () {
    final doc = buildDocument(
      paper: paperA4,
      orientation: PageOrientation.landscape,
      grid: const GridSpec(2, 1),
    );
    final restored = ReticulaDocument.fromJson(doc.toJson());
    expect(restored.slots.length, doc.slots.length);
    expect(restored.page.widthMm, doc.page.widthMm);
  });
}

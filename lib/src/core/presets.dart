/// Layout presets. Adding a new sheet layout is just adding another entry to
/// [reticulaPresets]; nothing in the UI or exporters is preset-specific.
library;

import 'document.dart';
import 'geometry.dart';
import 'slot.dart';

/// A named factory that builds a fresh [ReticulaDocument].
class ReticulaPreset {
  final String id;
  final String name;
  final String description;
  final ReticulaDocument Function() build;

  const ReticulaPreset({
    required this.id,
    required this.name,
    required this.description,
    required this.build,
  });
}

// --- A4 / 2 fotos A5 / sem margem (landscape) --------------------------------
//
// Page : 297 x 210 mm (A4 landscape)
// Slot1: x=0      y=0  w=148.5 h=210   (A5 portrait)
// Slot2: x=148.5  y=0  w=148.5 h=210   (A5 portrait)

const double _a4LongMm = 297.0;
const double _a4ShortMm = 210.0;
const double _a5HalfMm = _a4LongMm / 2; // 148.5

ReticulaDocument buildA4TwoA5Landscape() {
  return const ReticulaDocument(
    id: 'a4-2xa5-landscape',
    page: PageSpec(
      widthMm: _a4LongMm,
      heightMm: _a4ShortMm,
      orientation: PageOrientation.landscape,
    ),
    slots: [
      PhotoSlot(
        id: 'slot-1',
        rect: RectMm(x: 0, y: 0, width: _a5HalfMm, height: _a4ShortMm),
      ),
      PhotoSlot(
        id: 'slot-2',
        rect: RectMm(x: _a5HalfMm, y: 0, width: _a5HalfMm, height: _a4ShortMm),
      ),
    ],
    images: [],
  );
}

/// The primary MVP preset.
final ReticulaPreset presetA4TwoA5Landscape = ReticulaPreset(
  id: 'a4-2xa5-landscape',
  name: 'A4 paisagem / 2 fotos A5',
  description:
      'Folha A4 em paisagem com duas áreas A5 retrato, lado a lado, sem margem.',
  build: buildA4TwoA5Landscape,
);

// --- A4 / 2 fotos A5 / sem margem (portrait) ---------------------------------
//
// Page : 210 x 297 mm (A4 portrait)
// Slot1: x=0 y=0      w=210 h=148.5  (A5 landscape, em cima)
// Slot2: x=0 y=148.5  w=210 h=148.5  (A5 landscape, embaixo)

ReticulaDocument buildA4TwoA5Portrait() {
  return const ReticulaDocument(
    id: 'a4-2xa5-portrait',
    page: PageSpec(
      widthMm: _a4ShortMm,
      heightMm: _a4LongMm,
      orientation: PageOrientation.portrait,
    ),
    slots: [
      PhotoSlot(
        id: 'slot-1',
        rect: RectMm(x: 0, y: 0, width: _a4ShortMm, height: _a5HalfMm),
      ),
      PhotoSlot(
        id: 'slot-2',
        rect: RectMm(x: 0, y: _a5HalfMm, width: _a4ShortMm, height: _a5HalfMm),
      ),
    ],
    images: [],
  );
}

/// A4 portrait variant: two A5-landscape areas stacked.
final ReticulaPreset presetA4TwoA5Portrait = ReticulaPreset(
  id: 'a4-2xa5-portrait',
  name: 'A4 retrato / 2 fotos A5',
  description:
      'Folha A4 em retrato com duas áreas A5 paisagem, empilhadas, sem margem.',
  build: buildA4TwoA5Portrait,
);

/// All presets available in the app. New layouts (4×10×15, contact sheet, etc.)
/// are added here.
final List<ReticulaPreset> reticulaPresets = <ReticulaPreset>[
  presetA4TwoA5Landscape,
  presetA4TwoA5Portrait,
];

/// Builds a [ReticulaDocument] from a paper size, orientation and grid.
///
/// Slots tile the page edge-to-edge with no margin or gutter (the MVP "no
/// margin" rule). This replaces the old hard-coded presets: any paper × grid ×
/// orientation combination is generated here.
library;

import 'document.dart';
import 'geometry.dart';
import 'grid.dart';
import 'paper.dart';
import 'slot.dart';

/// The default layout the app opens on: A4 landscape, two A5-portrait slots.
const PaperSize kDefaultPaper = paperA4;
const PageOrientation kDefaultOrientation = PageOrientation.landscape;
const GridSpec kDefaultGrid = GridSpec(2, 1);

List<PhotoSlot> buildSlots(double pageW, double pageH, GridSpec grid) {
  final cellW = pageW / grid.columns;
  final cellH = pageH / grid.rows;
  final slots = <PhotoSlot>[];
  var index = 1;
  for (var r = 0; r < grid.rows; r++) {
    for (var c = 0; c < grid.columns; c++) {
      slots.add(PhotoSlot(
        id: 'slot-$index',
        rect: RectMm(
          x: c * cellW,
          y: r * cellH,
          width: cellW,
          height: cellH,
        ),
      ));
      index++;
    }
  }
  return slots;
}

ReticulaDocument buildDocument({
  required PaperSize paper,
  required PageOrientation orientation,
  required GridSpec grid,
}) {
  final portrait = orientation == PageOrientation.portrait;
  final pageW = portrait ? paper.widthMm : paper.heightMm;
  final pageH = portrait ? paper.heightMm : paper.widthMm;

  return ReticulaDocument(
    id: '${paper.id}-${orientation.name}-${grid.columns}x${grid.rows}',
    page: PageSpec(
      widthMm: pageW,
      heightMm: pageH,
      orientation: orientation,
    ),
    slots: buildSlots(pageW, pageH, grid),
    images: const [],
  );
}

/// Grid options: how many equal cells (slots) tile the page.
///
/// A grid is `columns × rows`; the count is `columns * rows`. Combined with the
/// page orientation this reproduces every basic layout (e.g. A4 landscape +
/// 2×1 = two A5-portrait slots side by side; A4 portrait + 1×2 = two A5
/// landscape slots stacked).
library;

class GridSpec {
  final int columns;
  final int rows;

  const GridSpec(this.columns, this.rows);

  int get count => columns * rows;

  /// Language-neutral label, e.g. "2 × 2".
  String get label => '$columns × $rows';

  bool sameAs(GridSpec other) =>
      other.columns == columns && other.rows == rows;

  Map<String, dynamic> toJson() => {'columns': columns, 'rows': rows};

  factory GridSpec.fromJson(Map<String, dynamic> json) => GridSpec(
        (json['columns'] as num).toInt(),
        (json['rows'] as num).toInt(),
      );
}

/// Grid options offered in the UI, from a single photo up to 12.
const List<GridSpec> gridOptions = [
  GridSpec(1, 1), // 1
  GridSpec(2, 1), // 2 side by side
  GridSpec(1, 2), // 2 stacked
  GridSpec(2, 2), // 4
  GridSpec(2, 3), // 6
  GridSpec(3, 3), // 9 (contact-sheet-ish)
  GridSpec(2, 4), // 8
  GridSpec(3, 4), // 12 (e.g. ID photos)
];

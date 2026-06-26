/// Small geometry value types used by the document model.
///
/// These are intentionally plain Dart (no Flutter / dart:ui dependency) so the
/// core can be unit-tested and later extracted into a standalone package.
library;

/// A size in millimetres.
class SizeMm {
  final double width;
  final double height;

  const SizeMm(this.width, this.height);

  /// width / height. Undefined for a zero height.
  double get aspect => width / height;

  Map<String, dynamic> toJson() => {'width': width, 'height': height};

  factory SizeMm.fromJson(Map<String, dynamic> json) => SizeMm(
        (json['width'] as num).toDouble(),
        (json['height'] as num).toDouble(),
      );

  @override
  String toString() => 'SizeMm(${width}mm x ${height}mm)';
}

/// An axis-aligned rectangle in millimetres, using a top-left origin with the
/// y-axis pointing down (same convention as the screen). Renderers that use a
/// bottom-left origin (e.g. raw PDF) are responsible for flipping the y-axis.
class RectMm {
  final double x;
  final double y;
  final double width;
  final double height;

  const RectMm({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  const RectMm.fromLTWH(this.x, this.y, this.width, this.height);

  double get left => x;
  double get top => y;
  double get right => x + width;
  double get bottom => y + height;
  double get centerX => x + width / 2;
  double get centerY => y + height / 2;

  SizeMm get size => SizeMm(width, height);

  /// Returns this rectangle multiplied by [factor] (e.g. mm -> pt or mm -> px).
  RectMm scaled(double factor) => RectMm(
        x: x * factor,
        y: y * factor,
        width: width * factor,
        height: height * factor,
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'width': width,
        'height': height,
      };

  factory RectMm.fromJson(Map<String, dynamic> json) => RectMm(
        x: (json['x'] as num).toDouble(),
        y: (json['y'] as num).toDouble(),
        width: (json['width'] as num).toDouble(),
        height: (json['height'] as num).toDouble(),
      );

  @override
  String toString() =>
      'RectMm(x: $x, y: $y, w: $width, h: $height)';
}

/// Intrinsic pixel dimensions of a raster image. Used by the layout engine to
/// reason about aspect ratio without depending on any image library.
class PixelSize {
  final int width;
  final int height;

  const PixelSize(this.width, this.height);

  /// width / height. Undefined for a zero height.
  double get aspect => width / height;

  Map<String, dynamic> toJson() => {'width': width, 'height': height};

  factory PixelSize.fromJson(Map<String, dynamic> json) => PixelSize(
        (json['width'] as num).toInt(),
        (json['height'] as num).toInt(),
      );

  @override
  String toString() => 'PixelSize(${width}px x ${height}px)';
}

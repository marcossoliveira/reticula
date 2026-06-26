/// An image placed into a slot, together with its framing parameters.
library;

/// How an image is fitted into its slot before the user adjusts it.
enum CropMode {
  /// Fill the slot completely, cropping overflow (default).
  cover,

  /// Fit entirely inside the slot, possibly leaving empty space.
  contain,

  /// Stretch to the slot, ignoring the image aspect ratio.
  stretch;

  String toJson() => name;

  static CropMode fromJson(String value) =>
      CropMode.values.firstWhere((m) => m.name == value, orElse: () => CropMode.cover);
}

/// A reference to a source image positioned inside a [PhotoSlot].
///
/// Framing is expressed relative to the slot, in physical units, so it is
/// independent of the preview resolution:
///
/// * [scale]   – multiplier on top of the base [CropMode] fit. `1.0` means the
///               image exactly satisfies the crop mode (for `cover`, it exactly
///               fills the slot). Values > 1 zoom in.
/// * [offsetX] – horizontal pan of the image centre relative to the slot
///               centre, in **millimetres**.
/// * [offsetY] – vertical pan, in **millimetres**.
/// * [rotation]– rotation in degrees. Stored for forward-compatibility; the MVP
///               renderers treat it as 0.
class PlacedImage {
  final String id;
  final String slotId;
  final String imagePath;

  final double offsetX;
  final double offsetY;
  final double scale;
  final double rotation;

  final CropMode cropMode;

  const PlacedImage({
    required this.id,
    required this.slotId,
    required this.imagePath,
    this.offsetX = 0,
    this.offsetY = 0,
    this.scale = 1.0,
    this.rotation = 0,
    this.cropMode = CropMode.cover,
  });

  PlacedImage copyWith({
    String? id,
    String? slotId,
    String? imagePath,
    double? offsetX,
    double? offsetY,
    double? scale,
    double? rotation,
    CropMode? cropMode,
  }) {
    return PlacedImage(
      id: id ?? this.id,
      slotId: slotId ?? this.slotId,
      imagePath: imagePath ?? this.imagePath,
      offsetX: offsetX ?? this.offsetX,
      offsetY: offsetY ?? this.offsetY,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      cropMode: cropMode ?? this.cropMode,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'slotId': slotId,
        'imagePath': imagePath,
        'offsetX': offsetX,
        'offsetY': offsetY,
        'scale': scale,
        'rotation': rotation,
        'cropMode': cropMode.toJson(),
      };

  factory PlacedImage.fromJson(Map<String, dynamic> json) => PlacedImage(
        id: json['id'] as String,
        slotId: json['slotId'] as String,
        imagePath: json['imagePath'] as String,
        offsetX: (json['offsetX'] as num?)?.toDouble() ?? 0,
        offsetY: (json['offsetY'] as num?)?.toDouble() ?? 0,
        scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
        rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
        cropMode: CropMode.fromJson(json['cropMode'] as String? ?? 'cover'),
      );
}

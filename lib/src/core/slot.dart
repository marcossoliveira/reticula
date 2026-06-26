/// A rectangular area on the page into which a single image is framed.
library;

import 'geometry.dart';

/// A photo slot: a fixed physical rectangle (in mm) on the page that acts as a
/// window/mask. The image placed in it may be larger than the slot; only the
/// part inside the slot is shown or printed.
class PhotoSlot {
  final String id;
  final RectMm rect;

  const PhotoSlot({
    required this.id,
    required this.rect,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'rect': rect.toJson(),
      };

  factory PhotoSlot.fromJson(Map<String, dynamic> json) => PhotoSlot(
        id: json['id'] as String,
        rect: RectMm.fromJson(json['rect'] as Map<String, dynamic>),
      );
}

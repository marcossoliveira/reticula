/// The Reticula document model: the single source of truth for what gets
/// printed. The UI is only a view over this model; exports are computed from it.
library;

import 'placed_image.dart';
import 'slot.dart';

enum PageOrientation {
  portrait,
  landscape;

  String toJson() => name;

  static PageOrientation fromJson(String value) => PageOrientation.values
      .firstWhere((o) => o.name == value, orElse: () => PageOrientation.portrait);
}

/// The physical page: its size in mm and orientation.
class PageSpec {
  final double widthMm;
  final double heightMm;
  final PageOrientation orientation;

  const PageSpec({
    required this.widthMm,
    required this.heightMm,
    required this.orientation,
  });

  Map<String, dynamic> toJson() => {
        'widthMm': widthMm,
        'heightMm': heightMm,
        'orientation': orientation.toJson(),
      };

  factory PageSpec.fromJson(Map<String, dynamic> json) => PageSpec(
        widthMm: (json['widthMm'] as num).toDouble(),
        heightMm: (json['heightMm'] as num).toDouble(),
        orientation:
            PageOrientation.fromJson(json['orientation'] as String? ?? 'portrait'),
      );
}

/// A complete layout: one page, a set of slots, and the images placed in them.
///
/// Immutable by design — edits produce a new document via [copyWith] /
/// [withImage] so the model is easy to diff, undo, and serialize later.
class ReticulaDocument {
  /// Schema version, to keep future `.reticula` files forward/backward aware.
  final int schemaVersion;
  final String id;
  final PageSpec page;
  final List<PhotoSlot> slots;
  final List<PlacedImage> images;

  const ReticulaDocument({
    required this.id,
    required this.page,
    required this.slots,
    required this.images,
    this.schemaVersion = 1,
  });

  PhotoSlot? slotById(String slotId) {
    for (final slot in slots) {
      if (slot.id == slotId) return slot;
    }
    return null;
  }

  PlacedImage? imageForSlot(String slotId) {
    for (final image in images) {
      if (image.slotId == slotId) return image;
    }
    return null;
  }

  PlacedImage? imageById(String imageId) {
    for (final image in images) {
      if (image.id == imageId) return image;
    }
    return null;
  }

  ReticulaDocument copyWith({
    String? id,
    PageSpec? page,
    List<PhotoSlot>? slots,
    List<PlacedImage>? images,
  }) {
    return ReticulaDocument(
      schemaVersion: schemaVersion,
      id: id ?? this.id,
      page: page ?? this.page,
      slots: slots ?? this.slots,
      images: images ?? this.images,
    );
  }

  /// Returns a copy with [image] added, replacing any existing image that
  /// occupies the same slot (the MVP allows one image per slot).
  ReticulaDocument withImage(PlacedImage image) {
    final next = images.where((i) => i.slotId != image.slotId).toList()
      ..add(image);
    return copyWith(images: next);
  }

  /// Returns a copy with the image identified by [imageId] replaced.
  ReticulaDocument withUpdatedImage(PlacedImage image) {
    final next = [
      for (final i in images) i.id == image.id ? image : i,
    ];
    return copyWith(images: next);
  }

  /// Returns a copy with any image in [slotId] removed.
  ReticulaDocument withoutSlotImage(String slotId) {
    return copyWith(images: images.where((i) => i.slotId != slotId).toList());
  }

  Map<String, dynamic> toJson() => {
        'schemaVersion': schemaVersion,
        'id': id,
        'page': page.toJson(),
        'slots': slots.map((s) => s.toJson()).toList(),
        'images': images.map((i) => i.toJson()).toList(),
      };

  factory ReticulaDocument.fromJson(Map<String, dynamic> json) =>
      ReticulaDocument(
        schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
        id: json['id'] as String,
        page: PageSpec.fromJson(json['page'] as Map<String, dynamic>),
        slots: (json['slots'] as List)
            .map((s) => PhotoSlot.fromJson(s as Map<String, dynamic>))
            .toList(),
        images: (json['images'] as List)
            .map((i) => PlacedImage.fromJson(i as Map<String, dynamic>))
            .toList(),
      );
}

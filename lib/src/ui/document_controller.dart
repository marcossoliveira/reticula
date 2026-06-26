/// Editor state. A thin [ChangeNotifier] over the immutable [ReticulaDocument]:
/// the UI mutates framing through these methods, the model stays the source of
/// truth, and every framing change is re-clamped through the [LayoutEngine].
library;

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show decodeImageFromList;

import '../core/document.dart';
import '../core/geometry.dart';
import '../core/layout_engine.dart';
import '../core/placed_image.dart';
import '../core/presets.dart';
import '../export/resolved_image.dart';

/// An image loaded into memory for preview + export.
class LoadedAsset {
  final String path;
  final Uint8List bytes;
  final PixelSize size;

  const LoadedAsset({
    required this.path,
    required this.bytes,
    required this.size,
  });

  ResolvedImage toResolved() => ResolvedImage(bytes: bytes, size: size);
}

class DocumentController extends ChangeNotifier {
  ReticulaDocument _document;

  /// Loaded image bytes, keyed by [PlacedImage.id].
  final Map<String, LoadedAsset> _assets = {};

  DocumentController(this._document);

  factory DocumentController.fromPreset(ReticulaPreset preset) =>
      DocumentController(preset.build());

  ReticulaDocument get document => _document;

  bool get hasAnyImage => _document.images.isNotEmpty;

  LoadedAsset? assetForSlot(String slotId) {
    final image = _document.imageForSlot(slotId);
    return image == null ? null : _assets[image.id];
  }

  /// The map exporters expect: [PlacedImage.id] -> resolved bytes + size.
  Map<String, ResolvedImage> resolvedImages() => {
        for (final entry in _assets.entries) entry.key: entry.value.toResolved(),
      };

  /// Replaces the current preset/document, dropping all loaded images.
  void loadPreset(ReticulaPreset preset) {
    _document = preset.build();
    _assets.clear();
    notifyListeners();
  }

  /// Switches to [preset]. By default keeps any imported photos, re-placing each
  /// into the slot with the same id and resetting its framing to the default
  /// cover fit (the new slot usually has a very different aspect ratio).
  void applyPreset(ReticulaPreset preset, {bool keepImages = true}) {
    final next = preset.build();
    if (!keepImages) {
      _document = next;
      _assets.clear();
      notifyListeners();
      return;
    }

    var doc = next;
    final retained = <String, LoadedAsset>{};
    for (final slot in next.slots) {
      final asset = _assets['img-${slot.id}'];
      if (asset == null) continue;
      doc = doc.withImage(PlacedImage(
        id: 'img-${slot.id}',
        slotId: slot.id,
        imagePath: asset.path,
      ));
      retained['img-${slot.id}'] = asset;
    }

    _document = doc;
    _assets
      ..clear()
      ..addAll(retained);
    notifyListeners();
  }

  /// Places [bytes] (read from [path]) into [slotId], replacing anything there.
  Future<void> setSlotImage({
    required String slotId,
    required String path,
    required Uint8List bytes,
  }) async {
    final ui.Image decoded = await decodeImageFromList(bytes);
    final size = PixelSize(decoded.width, decoded.height);
    decoded.dispose();

    final existing = _document.imageForSlot(slotId);
    if (existing != null) _assets.remove(existing.id);

    final id = 'img-$slotId';
    final placed = PlacedImage(id: id, slotId: slotId, imagePath: path);
    _assets[id] = LoadedAsset(path: path, bytes: bytes, size: size);
    _document = _document.withImage(placed);
    notifyListeners();
  }

  void removeSlotImage(String slotId) {
    final existing = _document.imageForSlot(slotId);
    if (existing == null) return;
    _assets.remove(existing.id);
    _document = _document.withoutSlotImage(slotId);
    notifyListeners();
  }

  /// Pan the image inside [slotId] by a delta in millimetres.
  void panSlotImageByMm(String slotId, double dxMm, double dyMm) {
    _mutateSlotImage(
      slotId,
      (placed) => placed.copyWith(
        offsetX: placed.offsetX + dxMm,
        offsetY: placed.offsetY + dyMm,
      ),
    );
  }

  /// Multiply the current zoom of the image in [slotId].
  void zoomSlotImage(String slotId, double factor) {
    _mutateSlotImage(
      slotId,
      (placed) => placed.copyWith(scale: placed.scale * factor),
    );
  }

  /// Set the absolute zoom of the image in [slotId].
  void setSlotImageScale(String slotId, double scale) {
    _mutateSlotImage(slotId, (placed) => placed.copyWith(scale: scale));
  }

  /// Reset framing to the default cover fit.
  void resetSlotImage(String slotId) {
    _mutateSlotImage(
      slotId,
      (placed) => placed.copyWith(scale: 1.0, offsetX: 0, offsetY: 0),
    );
  }

  void _mutateSlotImage(
    String slotId,
    PlacedImage Function(PlacedImage placed) transform,
  ) {
    final placed = _document.imageForSlot(slotId);
    final slot = _document.slotById(slotId);
    final asset = placed == null ? null : _assets[placed.id];
    if (placed == null || slot == null || asset == null) return;

    final next = LayoutEngine.clampToCover(
      slot: slot.rect,
      image: asset.size,
      placement: transform(placed),
    );
    _document = _document.withUpdatedImage(next);
    notifyListeners();
  }
}

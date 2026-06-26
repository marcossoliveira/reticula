/// The bytes + intrinsic size an exporter needs for one placed image.
library;

import 'dart:typed_data';

import '../core/geometry.dart';

/// An image resolved to memory: its encoded bytes (JPEG/PNG) and its intrinsic
/// pixel dimensions. The export layer is given these so it never has to touch
/// the filesystem or Flutter image loading directly.
class ResolvedImage {
  final Uint8List bytes;
  final PixelSize size;

  const ResolvedImage({required this.bytes, required this.size});
}

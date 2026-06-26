/// Desktop/mobile implementation: native save dialog + file write.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';

/// Saves [bytes] to a user-chosen location. Returns the path, or null if the
/// user cancels.
Future<String?> saveExport({
  required Uint8List bytes,
  required String suggestedName,
  required String fileExtension,
}) async {
  final location = await getSaveLocation(
    acceptedTypeGroups: [
      XTypeGroup(
        label: fileExtension.toUpperCase(),
        extensions: [fileExtension],
      ),
    ],
    suggestedName: suggestedName,
  );
  if (location == null) return null;
  await File(location.path).writeAsBytes(bytes);
  return location.path;
}

/// Web implementation: download the bytes via an anchor element.
library;

// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:typed_data';

/// Triggers a browser download of [bytes]. Returns the file name (web has no
/// filesystem path).
Future<String?> saveExport({
  required Uint8List bytes,
  required String suggestedName,
  required String fileExtension,
}) async {
  final blob = html.Blob(<Object>[bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..download = suggestedName
    ..style.display = 'none';
  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
  html.Url.revokeObjectUrl(url);
  return suggestedName;
}

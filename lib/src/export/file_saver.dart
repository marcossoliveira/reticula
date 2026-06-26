/// Cross-platform "save the exported bytes" entry point.
///
/// On desktop/mobile a native save dialog writes the file and the chosen path
/// is returned. On the web the bytes are downloaded by the browser and the
/// suggested file name is returned. Returns null if the user cancels.
///
/// The right implementation is picked at compile time via conditional import.
library;

export 'file_saver_io.dart' if (dart.library.html) 'file_saver_web.dart';

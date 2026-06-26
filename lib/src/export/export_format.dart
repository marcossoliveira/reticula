/// The output formats Reticula can export to.
library;

enum ExportFormat {
  pdf(fileExtension: 'pdf', defaultName: 'reticula.pdf'),
  png(fileExtension: 'png', defaultName: 'reticula_300dpi.png'),
  jpeg(fileExtension: 'jpg', defaultName: 'reticula_300dpi.jpg');

  final String fileExtension;
  final String defaultName;

  const ExportFormat({required this.fileExtension, required this.defaultName});

  /// True for raster formats derived from the rendered PDF.
  bool get isRaster => this == ExportFormat.png || this == ExportFormat.jpeg;
}

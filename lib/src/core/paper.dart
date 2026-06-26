/// Catalog of paper sizes. Dimensions are the **portrait** (short × long) size
/// in millimetres; orientation is applied by the document builder.
library;

class PaperSize {
  final String id;

  /// Short, mostly language-neutral display name (e.g. "A4", "10 × 15 cm").
  final String name;

  /// Portrait width (short side), mm.
  final double widthMm;

  /// Portrait height (long side), mm.
  final double heightMm;

  const PaperSize({
    required this.id,
    required this.name,
    required this.widthMm,
    required this.heightMm,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'widthMm': widthMm,
        'heightMm': heightMm,
      };

  factory PaperSize.fromJson(Map<String, dynamic> json) => PaperSize(
        id: json['id'] as String,
        name: json['name'] as String,
        widthMm: (json['widthMm'] as num).toDouble(),
        heightMm: (json['heightMm'] as num).toDouble(),
      );
}

// ISO 216 A-series (portrait).
const paperA3 = PaperSize(id: 'a3', name: 'A3', widthMm: 297, heightMm: 420);
const paperA4 = PaperSize(id: 'a4', name: 'A4', widthMm: 210, heightMm: 297);
const paperA5 = PaperSize(id: 'a5', name: 'A5', widthMm: 148, heightMm: 210);
const paperA6 = PaperSize(id: 'a6', name: 'A6', widthMm: 105, heightMm: 148);

// North American.
const paperLetter =
    PaperSize(id: 'letter', name: 'Letter', widthMm: 215.9, heightMm: 279.4);
const paperLegal =
    PaperSize(id: 'legal', name: 'Legal', widthMm: 215.9, heightMm: 355.6);

// Common photo paper.
const paper10x15 =
    PaperSize(id: 'photo-10x15', name: '10 × 15 cm', widthMm: 100, heightMm: 150);
const paper13x18 =
    PaperSize(id: 'photo-13x18', name: '13 × 18 cm', widthMm: 130, heightMm: 180);

/// All paper sizes offered in the UI.
const List<PaperSize> paperSizes = [
  paperA3,
  paperA4,
  paperA5,
  paperA6,
  paperLetter,
  paperLegal,
  paper10x15,
  paper13x18,
];

PaperSize paperById(String id) =>
    paperSizes.firstWhere((p) => p.id == id, orElse: () => paperA4);

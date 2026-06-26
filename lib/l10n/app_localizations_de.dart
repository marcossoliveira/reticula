// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get chooseTool => 'Werkzeug wählen';

  @override
  String get comingSoon => 'Demnächst';

  @override
  String get open => 'Öffnen';

  @override
  String get language => 'Sprache';

  @override
  String get openSource => 'Open Source';

  @override
  String get viewSource => 'Quellcode auf GitHub';

  @override
  String madeBy(String author) {
    return 'Erstellt von $author';
  }

  @override
  String get suiteSubtitle => 'Open-Source-Fototools';

  @override
  String get toolPrintLayoutTitle => 'Druck-Layout';

  @override
  String get toolPrintLayoutDesc =>
      'Fotos für präzisen Druck auf echten Bögen anordnen.';

  @override
  String get toolSocialCollageTitle => 'Social-Media-Collage';

  @override
  String get toolSocialCollageDesc =>
      'Collagen in den Maßen sozialer Netzwerke erstellen.';

  @override
  String get toolCardsTitle => 'Karten & Einladungen';

  @override
  String get toolCardsDesc => 'Karten und Einladungen zum Drucken gestalten.';

  @override
  String get toolCalendarTitle => 'Fotokalender';

  @override
  String get toolCalendarDesc => 'Aus deinen Fotos druckbare Kalender machen.';

  @override
  String get toolPhotobookTitle => 'Fotobuch';

  @override
  String get toolPhotobookDesc =>
      'Ein Album zum Drucken oder Bestellen gestalten.';

  @override
  String get toolLabelsTitle => 'Etiketten & Aufkleber';

  @override
  String get toolLabelsDesc => 'Etikettenbögen mit Bildern oder Text füllen.';

  @override
  String get allTools => 'Alle Werkzeuge';

  @override
  String get paper => 'Papier';

  @override
  String get grid => 'Raster';

  @override
  String get orientationPortrait => 'Hochformat';

  @override
  String get orientationLandscape => 'Querformat';

  @override
  String get export => 'Exportieren';

  @override
  String get exportAs => 'Exportieren als…';

  @override
  String get formatPdf => 'PDF-Dokument';

  @override
  String get formatPng => 'PNG-Bild · 300 DPI';

  @override
  String get formatJpeg => 'JPEG-Bild · 300 DPI';

  @override
  String importPhoto(int number) {
    return 'Foto $number importieren';
  }

  @override
  String get clickToChoose => 'Zum Auswählen klicken';

  @override
  String get swapPhoto => 'Foto austauschen';

  @override
  String get resetFraming => 'Bildausschnitt zurücksetzen';

  @override
  String get printHint =>
      'Mit 100 % Skalierung drucken, ohne „An Seite anpassen“ und randlos, falls dein Drucker das unterstützt.';

  @override
  String savedTo(String format, String path) {
    return '$format gespeichert unter $path';
  }

  @override
  String exportFailed(String format, String error) {
    return '$format konnte nicht exportiert werden: $error';
  }

  @override
  String importFailed(String error) {
    return 'Bild konnte nicht importiert werden: $error';
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get chooseTool => 'Scegli uno strumento';

  @override
  String get comingSoon => 'In arrivo';

  @override
  String get open => 'Apri';

  @override
  String get language => 'Lingua';

  @override
  String get openSource => 'Open source';

  @override
  String get viewSource => 'Codice su GitHub';

  @override
  String madeBy(String author) {
    return 'Creato da $author';
  }

  @override
  String get suiteSubtitle => 'Strumenti per foto open source';

  @override
  String get toolPrintLayoutTitle => 'Layout di Stampa';

  @override
  String get toolPrintLayoutDesc =>
      'Disponi le foto su fogli reali per una stampa precisa.';

  @override
  String get toolSocialCollageTitle => 'Collage per i Social';

  @override
  String get toolSocialCollageDesc =>
      'Crea collage nelle dimensioni dei social network.';

  @override
  String get toolCardsTitle => 'Biglietti e Inviti';

  @override
  String get toolCardsDesc => 'Crea biglietti e inviti da stampare.';

  @override
  String get toolCalendarTitle => 'Calendario Fotografico';

  @override
  String get toolCalendarDesc =>
      'Trasforma le tue foto in calendari da stampare.';

  @override
  String get toolPhotobookTitle => 'Fotolibro';

  @override
  String get toolPhotobookDesc => 'Componi un album da stampare o ordinare.';

  @override
  String get toolLabelsTitle => 'Etichette e Adesivi';

  @override
  String get toolLabelsDesc =>
      'Riempi fogli di etichette con immagini o testo.';

  @override
  String get allTools => 'Tutti gli strumenti';

  @override
  String get paper => 'Carta';

  @override
  String get grid => 'Griglia';

  @override
  String get orientationPortrait => 'Verticale';

  @override
  String get orientationLandscape => 'Orizzontale';

  @override
  String get export => 'Esporta';

  @override
  String get exportAs => 'Esporta come…';

  @override
  String get formatPdf => 'Documento PDF';

  @override
  String get formatPng => 'Immagine PNG · 300 DPI';

  @override
  String get formatJpeg => 'Immagine JPEG · 300 DPI';

  @override
  String importPhoto(int number) {
    return 'Importa Foto $number';
  }

  @override
  String get clickToChoose => 'Clicca per scegliere';

  @override
  String get swapPhoto => 'Cambia foto';

  @override
  String get resetFraming => 'Reimposta inquadratura';

  @override
  String get printHint =>
      'Stampa al 100% di scala, senza “adatta alla pagina” e senza bordi se la stampante lo supporta.';

  @override
  String savedTo(String format, String path) {
    return '$format salvato in $path';
  }

  @override
  String exportFailed(String format, String error) {
    return 'Impossibile esportare $format: $error';
  }

  @override
  String importFailed(String error) {
    return 'Impossibile importare l’immagine: $error';
  }
}

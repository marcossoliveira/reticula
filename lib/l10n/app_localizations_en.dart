// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get chooseTool => 'Choose a tool';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get open => 'Open';

  @override
  String get language => 'Language';

  @override
  String get openSource => 'Open source';

  @override
  String get viewSource => 'Source on GitHub';

  @override
  String madeBy(String author) {
    return 'Made by $author';
  }

  @override
  String get suiteSubtitle => 'Open-source photo tools';

  @override
  String get toolPrintLayoutTitle => 'Print Layout';

  @override
  String get toolPrintLayoutDesc =>
      'Arrange photos on real sheets for precise printing.';

  @override
  String get toolSocialCollageTitle => 'Social Collage';

  @override
  String get toolSocialCollageDesc =>
      'Build collages sized for social networks.';

  @override
  String get toolCardsTitle => 'Cards & Invitations';

  @override
  String get toolCardsDesc => 'Design printable cards and invitations.';

  @override
  String get toolCalendarTitle => 'Photo Calendar';

  @override
  String get toolCalendarDesc => 'Turn your photos into printable calendars.';

  @override
  String get toolPhotobookTitle => 'Photo Book';

  @override
  String get toolPhotobookDesc => 'Lay out an album to print or order.';

  @override
  String get toolLabelsTitle => 'Labels & Stickers';

  @override
  String get toolLabelsDesc => 'Fill label sheets with images or text.';

  @override
  String get allTools => 'All tools';

  @override
  String get paper => 'Paper';

  @override
  String get grid => 'Grid';

  @override
  String get orientationPortrait => 'Portrait';

  @override
  String get orientationLandscape => 'Landscape';

  @override
  String get export => 'Export';

  @override
  String get exportAs => 'Export as…';

  @override
  String get formatPdf => 'PDF document';

  @override
  String get formatPng => 'PNG image · 300 DPI';

  @override
  String get formatJpeg => 'JPEG image · 300 DPI';

  @override
  String importPhoto(int number) {
    return 'Import Photo $number';
  }

  @override
  String get clickToChoose => 'Click to choose';

  @override
  String get swapPhoto => 'Swap photo';

  @override
  String get resetFraming => 'Reset framing';

  @override
  String get printHint =>
      'Print at 100% scale, with “fit to page” off and borderless printing if your printer supports it.';

  @override
  String savedTo(String format, String path) {
    return '$format saved to $path';
  }

  @override
  String exportFailed(String format, String error) {
    return 'Couldn’t export $format: $error';
  }

  @override
  String importFailed(String error) {
    return 'Couldn’t import image: $error';
  }
}

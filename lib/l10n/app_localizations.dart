import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// No description provided for @chooseTool.
  ///
  /// In en, this message translates to:
  /// **'Choose a tool'**
  String get chooseTool;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @openSource.
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get openSource;

  /// No description provided for @viewSource.
  ///
  /// In en, this message translates to:
  /// **'Source on GitHub'**
  String get viewSource;

  /// No description provided for @madeBy.
  ///
  /// In en, this message translates to:
  /// **'Made by {author}'**
  String madeBy(String author);

  /// No description provided for @suiteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open-source photo tools'**
  String get suiteSubtitle;

  /// No description provided for @toolPrintLayoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Print Layout'**
  String get toolPrintLayoutTitle;

  /// No description provided for @toolPrintLayoutDesc.
  ///
  /// In en, this message translates to:
  /// **'Arrange photos on real sheets for precise printing.'**
  String get toolPrintLayoutDesc;

  /// No description provided for @toolSocialCollageTitle.
  ///
  /// In en, this message translates to:
  /// **'Social Collage'**
  String get toolSocialCollageTitle;

  /// No description provided for @toolSocialCollageDesc.
  ///
  /// In en, this message translates to:
  /// **'Build collages sized for social networks.'**
  String get toolSocialCollageDesc;

  /// No description provided for @toolCardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cards & Invitations'**
  String get toolCardsTitle;

  /// No description provided for @toolCardsDesc.
  ///
  /// In en, this message translates to:
  /// **'Design printable cards and invitations.'**
  String get toolCardsDesc;

  /// No description provided for @toolCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Photo Calendar'**
  String get toolCalendarTitle;

  /// No description provided for @toolCalendarDesc.
  ///
  /// In en, this message translates to:
  /// **'Turn your photos into printable calendars.'**
  String get toolCalendarDesc;

  /// No description provided for @toolPhotobookTitle.
  ///
  /// In en, this message translates to:
  /// **'Photo Book'**
  String get toolPhotobookTitle;

  /// No description provided for @toolPhotobookDesc.
  ///
  /// In en, this message translates to:
  /// **'Lay out an album to print or order.'**
  String get toolPhotobookDesc;

  /// No description provided for @toolLabelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Labels & Stickers'**
  String get toolLabelsTitle;

  /// No description provided for @toolLabelsDesc.
  ///
  /// In en, this message translates to:
  /// **'Fill label sheets with images or text.'**
  String get toolLabelsDesc;

  /// No description provided for @allTools.
  ///
  /// In en, this message translates to:
  /// **'All tools'**
  String get allTools;

  /// No description provided for @paper.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get paper;

  /// No description provided for @grid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get grid;

  /// No description provided for @orientationPortrait.
  ///
  /// In en, this message translates to:
  /// **'Portrait'**
  String get orientationPortrait;

  /// No description provided for @orientationLandscape.
  ///
  /// In en, this message translates to:
  /// **'Landscape'**
  String get orientationLandscape;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportAs.
  ///
  /// In en, this message translates to:
  /// **'Export as…'**
  String get exportAs;

  /// No description provided for @formatPdf.
  ///
  /// In en, this message translates to:
  /// **'PDF document'**
  String get formatPdf;

  /// No description provided for @formatPng.
  ///
  /// In en, this message translates to:
  /// **'PNG image · 300 DPI'**
  String get formatPng;

  /// No description provided for @formatJpeg.
  ///
  /// In en, this message translates to:
  /// **'JPEG image · 300 DPI'**
  String get formatJpeg;

  /// No description provided for @importPhoto.
  ///
  /// In en, this message translates to:
  /// **'Import Photo {number}'**
  String importPhoto(int number);

  /// No description provided for @clickToChoose.
  ///
  /// In en, this message translates to:
  /// **'Click to choose'**
  String get clickToChoose;

  /// No description provided for @swapPhoto.
  ///
  /// In en, this message translates to:
  /// **'Swap photo'**
  String get swapPhoto;

  /// No description provided for @resetFraming.
  ///
  /// In en, this message translates to:
  /// **'Reset framing'**
  String get resetFraming;

  /// No description provided for @printHint.
  ///
  /// In en, this message translates to:
  /// **'Print at 100% scale, with “fit to page” off and borderless printing if your printer supports it.'**
  String get printHint;

  /// No description provided for @savedTo.
  ///
  /// In en, this message translates to:
  /// **'{format} saved to {path}'**
  String savedTo(String format, String path);

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t export {format}: {error}'**
  String exportFailed(String format, String error);

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t import image: {error}'**
  String importFailed(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'it',
    'ja',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

/// The Reticula application widget: theme, localization, and locale state.
///
/// Reticula is a small suite; the app opens on a tool launcher (home screen),
/// and each tool (currently only Print Layout) is pushed as its own screen.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/app_localizations.dart';
import 'ui/home_screen.dart';
import 'ui/theme.dart';

class ReticulaApp extends StatefulWidget {
  const ReticulaApp({super.key});

  @override
  State<ReticulaApp> createState() => _ReticulaAppState();
}

class _ReticulaAppState extends State<ReticulaApp> {
  /// null = follow the system locale.
  Locale? _locale;

  void _setLocale(Locale? locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => kAppName,
      debugShowCheckedModeBanner: false,
      theme: buildReticulaTheme(),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeScreen(
        locale: _locale,
        onLocaleChanged: _setLocale,
      ),
    );
  }
}

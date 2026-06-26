/// Visual design tokens and the app's ThemeData.
library;

import 'package:flutter/material.dart';

/// Product/suite name.
const String kAppName = 'Reticula';

/// Open-source project repository and author.
const String kRepoUrl = 'https://github.com/marcossoliveira/reticula';
const String kAuthorName = 'Marcos Oliveira';
const String kAuthorUrl = 'https://github.com/marcossoliveira';

/// Reticula colour palette. Light "chrome" (top bar + footer) framing a dark
/// workspace canvas, so the white sheet and the photos stand out.
class RColors {
  RColors._();

  static const accent = Color(0xFF6366F1); // indigo
  static const accentDark = Color(0xFF4F46E5);

  static const ink = Color(0xFF17181C);
  static const muted = Color(0xFF8A9099);

  static const chrome = Color(0xFFFFFFFF);
  static const chromeBorder = Color(0xFFE7E9EE);

  // Workspace canvas (radial, lighter centre → darker edges).
  static const canvasCenter = Color(0xFF2C2E35);
  static const canvasEdge = Color(0xFF191A1E);

  static const slotEmpty = Color(0xFFF3F4F6);
  static const slotEmptyHover = Color(0xFFEDEEFE);
  static const slotDash = Color(0xFFC7CBD4);
}

ThemeData buildReticulaTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: RColors.accent,
    brightness: Brightness.light,
  );

  final base = ThemeData(useMaterial3: true, colorScheme: scheme);

  RoundedRectangleBorder shape() =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  const buttonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 14);
  const buttonText = TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5);

  return base.copyWith(
    scaffoldBackgroundColor: RColors.chrome,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: shape(),
        padding: buttonPadding,
        textStyle: buttonText,
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: shape(),
        padding: buttonPadding,
        textStyle: buttonText,
        foregroundColor: RColors.ink,
        side: const BorderSide(color: RColors.chromeBorder),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(shape()),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        side: const WidgetStatePropertyAll(
          BorderSide(color: RColors.chromeBorder),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    ),
    tooltipTheme: const TooltipThemeData(
      waitDuration: Duration(milliseconds: 400),
    ),
  );
}

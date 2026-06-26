/// The Reticula application widget: theme + the single editor screen.
library;

import 'package:flutter/material.dart';

import 'core/presets.dart';
import 'ui/document_controller.dart';
import 'ui/editor_page.dart';
import 'ui/theme.dart';

class ReticulaApp extends StatefulWidget {
  const ReticulaApp({super.key});

  @override
  State<ReticulaApp> createState() => _ReticulaAppState();
}

class _ReticulaAppState extends State<ReticulaApp> {
  // The MVP opens directly on the primary preset.
  late final DocumentController _controller =
      DocumentController.fromPreset(presetA4TwoA5Landscape);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reticula',
      debugShowCheckedModeBanner: false,
      theme: buildReticulaTheme(),
      home: EditorPage(controller: _controller),
    );
  }
}

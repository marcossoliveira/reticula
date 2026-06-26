/// The main editor screen: a light top bar, a dark workspace canvas with the
/// sheet preview, and a slim print-hint footer.
library;

import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../core/document.dart';
import '../core/presets.dart';
import '../export/pdf_exporter.dart';
import '../export/png_exporter.dart';
import 'document_controller.dart';
import 'theme.dart';
import 'widgets/sheet_preview.dart';

class EditorPage extends StatefulWidget {
  final DocumentController controller;

  const EditorPage({super.key, required this.controller});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  bool _busy = false;

  DocumentController get controller => widget.controller;

  static const _imageTypes = XTypeGroup(
    label: 'Imagens',
    extensions: ['jpg', 'jpeg', 'png', 'heic', 'heif', 'webp', 'bmp', 'gif'],
  );

  Future<void> _importToSlot(String slotId) async {
    try {
      final file = await openFile(acceptedTypeGroups: const [_imageTypes]);
      if (file == null) return;
      final bytes = await file.readAsBytes();
      await controller.setSlotImage(
          slotId: slotId, path: file.path, bytes: bytes);
    } catch (e) {
      _snack('Falha ao importar imagem: $e');
    }
  }

  Future<void> _exportPdf() async {
    await _runExport(
      suggestedName: 'reticula_a4.pdf',
      typeGroup: const XTypeGroup(label: 'PDF', extensions: ['pdf']),
      build: () =>
          PdfExporter.build(controller.document, controller.resolvedImages()),
      successLabel: 'PDF',
    );
  }

  Future<void> _exportPng() async {
    await _runExport(
      suggestedName: 'reticula_a4_300dpi.png',
      typeGroup: const XTypeGroup(label: 'PNG', extensions: ['png']),
      build: () => PngExporter.build(
          controller.document, controller.resolvedImages(),
          dpi: 300),
      successLabel: 'PNG (300 DPI)',
    );
  }

  Future<void> _runExport({
    required String suggestedName,
    required XTypeGroup typeGroup,
    required Future<List<int>> Function() build,
    required String successLabel,
  }) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final bytes = await build();
      final location = await getSaveLocation(
        acceptedTypeGroups: [typeGroup],
        suggestedName: suggestedName,
      );
      if (location == null) return;
      await File(location.path).writeAsBytes(bytes);
      _snack('$successLabel salvo em ${location.path}');
    } catch (e) {
      _snack('Falha ao exportar $successLabel: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _setOrientation(PageOrientation orientation) {
    if (orientation == controller.document.page.orientation) return;
    controller.applyPreset(
      orientation == PageOrientation.landscape
          ? presetA4TwoA5Landscape
          : presetA4TwoA5Portrait,
    );
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return Column(
            children: [
              _TopBar(
                busy: _busy,
                orientation: controller.document.page.orientation,
                onOrientation: _setOrientation,
                onExportPdf: _exportPdf,
                onExportPng: _exportPng,
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, -0.25),
                      radius: 1.2,
                      colors: [RColors.canvasCenter, RColors.canvasEdge],
                    ),
                  ),
                  child: SheetPreview(
                    controller: controller,
                    onImportSlot: _importToSlot,
                  ),
                ),
              ),
              const _FooterHint(),
            ],
          );
        },
      ),
    );
  }
}

// --- Top bar -----------------------------------------------------------------

class _TopBar extends StatelessWidget {
  final bool busy;
  final PageOrientation orientation;
  final void Function(PageOrientation orientation) onOrientation;
  final VoidCallback onExportPdf;
  final VoidCallback onExportPng;

  const _TopBar({
    required this.busy,
    required this.orientation,
    required this.onOrientation,
    required this.onExportPdf,
    required this.onExportPng,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: RColors.chrome,
        border: Border(bottom: BorderSide(color: RColors.chromeBorder)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 10,
        children: [
          const _Brand(),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _OrientationSelector(
                orientation: orientation,
                busy: busy,
                onChanged: onOrientation,
              ),
              if (busy)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              FilledButton.icon(
                onPressed: busy ? null : onExportPdf,
                icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                label: const Text('Exportar PDF'),
              ),
              Tooltip(
                message: 'Exportar PNG em 300 DPI',
                child: OutlinedButton.icon(
                  onPressed: busy ? null : onExportPng,
                  icon: const Icon(Icons.image_outlined, size: 18),
                  label: const Text('PNG 300 DPI'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [RColors.accent, RColors.accentDark],
            ),
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color: RColors.accent.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reticula',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: RColors.ink,
                height: 1.05,
              ),
            ),
            Text(
              'layouts de impressão',
              style: TextStyle(fontSize: 11, color: RColors.muted, height: 1.1),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrientationSelector extends StatelessWidget {
  final PageOrientation orientation;
  final bool busy;
  final void Function(PageOrientation orientation) onChanged;

  const _OrientationSelector({
    required this.orientation,
    required this.busy,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PageOrientation>(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
          value: PageOrientation.landscape,
          icon: Icon(Icons.crop_landscape_outlined, size: 18),
          label: Text('Paisagem'),
        ),
        ButtonSegment(
          value: PageOrientation.portrait,
          icon: Icon(Icons.crop_portrait_outlined, size: 18),
          label: Text('Retrato'),
        ),
      ],
      selected: {orientation},
      onSelectionChanged:
          busy ? null : (selection) => onChanged(selection.first),
    );
  }
}

// --- Footer ------------------------------------------------------------------

class _FooterHint extends StatelessWidget {
  const _FooterHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: RColors.chrome,
        border: Border(top: BorderSide(color: RColors.chromeBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.print_outlined, size: 14, color: RColors.muted),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              'Imprima em escala 100%, sem "ajustar à página" e com impressão sem borda se a impressora suportar.',
              style: TextStyle(fontSize: 12, color: RColors.muted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

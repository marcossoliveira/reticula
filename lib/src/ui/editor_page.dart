/// The Print Layout editor: a top bar (back, paper/orientation/grid, export),
/// a dark workspace canvas with the sheet preview, and a print-hint footer.
library;

import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../core/document.dart';
import '../core/grid.dart';
import '../core/paper.dart';
import '../export/export_format.dart';
import '../export/file_saver.dart';
import '../export/pdf_exporter.dart';
import '../export/raster_exporter.dart';
import 'document_controller.dart';
import 'theme.dart';
import 'widgets/sheet_preview.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late final DocumentController controller = DocumentController();
  bool _busy = false;

  static const _imageTypes = XTypeGroup(
    label: 'Images',
    extensions: ['jpg', 'jpeg', 'png', 'heic', 'heif', 'webp', 'bmp', 'gif'],
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _importToSlot(String slotId) async {
    final l10n = AppLocalizations.of(context);
    try {
      final file = await openFile(acceptedTypeGroups: const [_imageTypes]);
      if (file == null) return;
      final bytes = await file.readAsBytes();
      await controller.setSlotImage(
          slotId: slotId, path: file.path, bytes: bytes);
    } catch (e) {
      _snack(l10n.importFailed('$e'));
    }
  }

  Future<void> _export(ExportFormat format) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    final formatName = format.fileExtension.toUpperCase();
    setState(() => _busy = true);
    try {
      final doc = controller.document;
      final images = controller.resolvedImages();
      final Uint8List bytes;
      switch (format) {
        case ExportFormat.pdf:
          bytes = await PdfExporter.build(doc, images);
        case ExportFormat.png:
          bytes = await RasterExporter.png(doc, images, dpi: 300);
        case ExportFormat.jpeg:
          bytes = await RasterExporter.jpeg(doc, images, dpi: 300);
      }
      final savedTo = await saveExport(
        bytes: bytes,
        suggestedName: format.defaultName,
        fileExtension: format.fileExtension,
      );
      if (savedTo == null) return;
      _snack(l10n.savedTo(formatName, savedTo));
    } catch (e) {
      _snack(l10n.exportFailed(formatName, '$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
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
              _EditorBar(
                controller: controller,
                busy: _busy,
                onBack: () => Navigator.of(context).maybePop(),
                onExport: _export,
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
              const _PrintHint(),
            ],
          );
        },
      ),
    );
  }
}

// --- Top bar -----------------------------------------------------------------

class _EditorBar extends StatelessWidget {
  final DocumentController controller;
  final bool busy;
  final VoidCallback onBack;
  final void Function(ExportFormat format) onExport;

  const _EditorBar({
    required this.controller,
    required this.busy,
    required this.onBack,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: RColors.chrome,
        border: Border(bottom: BorderSide(color: RColors.chromeBorder)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 10,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onBack,
                tooltip: l10n.allTools,
                icon: const Icon(Icons.arrow_back_rounded, color: RColors.ink),
              ),
              const SizedBox(width: 4),
              Text(
                l10n.toolPrintLayoutTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: RColors.ink,
                ),
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _PaperMenu(controller: controller),
              _OrientationSelector(controller: controller),
              _GridMenu(controller: controller),
              if (busy)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              _ExportMenu(label: l10n.export, onExport: onExport),
            ],
          ),
        ],
      ),
    );
  }
}

/// An outlined, menu-opening control showing "Label  Value ⌄".
class _ControlChip extends StatelessWidget {
  final String label;
  final String value;

  const _ControlChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(color: RColors.chromeBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: RColors.muted)),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: RColors.ink,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.expand_more_rounded, size: 18, color: RColors.muted),
        ],
      ),
    );
  }
}

class _PaperMenu extends StatelessWidget {
  final DocumentController controller;

  const _PaperMenu({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<PaperSize>(
      tooltip: l10n.paper,
      onSelected: controller.setPaper,
      itemBuilder: (context) => [
        for (final p in paperSizes)
          PopupMenuItem(
            value: p,
            child: Text(
              '${p.name}   ·   ${p.widthMm.toStringAsFixed(0)} × ${p.heightMm.toStringAsFixed(0)} mm',
            ),
          ),
      ],
      child: _ControlChip(label: l10n.paper, value: controller.paper.name),
    );
  }
}

class _GridMenu extends StatelessWidget {
  final DocumentController controller;

  const _GridMenu({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<GridSpec>(
      tooltip: l10n.grid,
      onSelected: controller.setGrid,
      itemBuilder: (context) => [
        for (final g in gridOptions)
          PopupMenuItem(
            value: g,
            child: Text('${g.label}   ·   ${g.count}'),
          ),
      ],
      child: _ControlChip(label: l10n.grid, value: controller.grid.label),
    );
  }
}

class _OrientationSelector extends StatelessWidget {
  final DocumentController controller;

  const _OrientationSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SegmentedButton<PageOrientation>(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(
          value: PageOrientation.landscape,
          icon: const Icon(Icons.crop_landscape_outlined, size: 18),
          label: Text(l10n.orientationLandscape),
        ),
        ButtonSegment(
          value: PageOrientation.portrait,
          icon: const Icon(Icons.crop_portrait_outlined, size: 18),
          label: Text(l10n.orientationPortrait),
        ),
      ],
      selected: {controller.orientation},
      onSelectionChanged: (selection) =>
          controller.setOrientation(selection.first),
    );
  }
}

class _ExportMenu extends StatelessWidget {
  final String label;
  final void Function(ExportFormat format) onExport;

  const _ExportMenu({required this.label, required this.onExport});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<ExportFormat>(
      tooltip: l10n.exportAs,
      onSelected: onExport,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ExportFormat.pdf,
          child: _formatRow(Icons.picture_as_pdf_outlined, l10n.formatPdf),
        ),
        PopupMenuItem(
          value: ExportFormat.png,
          child: _formatRow(Icons.image_outlined, l10n.formatPng),
        ),
        PopupMenuItem(
          value: ExportFormat.jpeg,
          child: _formatRow(Icons.photo_outlined, l10n.formatJpeg),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.ios_share_rounded, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.expand_more_rounded, size: 18, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _formatRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: RColors.ink),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}

class _PrintHint extends StatelessWidget {
  const _PrintHint();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: RColors.chrome,
        border: Border(top: BorderSide(color: RColors.chromeBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.print_outlined, size: 14, color: RColors.muted),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              l10n.printHint,
              style: const TextStyle(fontSize: 12, color: RColors.muted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

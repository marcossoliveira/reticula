/// Renders the page (the "sheet") and its slots, scaled to fit the available
/// space, floating on the dark workspace canvas. Pure view: it reads the
/// document and converts mm -> screen px.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:reticula_app/l10n/app_localizations.dart';

import '../../core/document.dart';
import '../document_controller.dart';
import 'slot_view.dart';

class SheetPreview extends StatelessWidget {
  final DocumentController controller;

  /// Called when an empty slot's "import" affordance is tapped.
  final void Function(String slotId) onImportSlot;

  const SheetPreview({
    super.key,
    required this.controller,
    required this.onImportSlot,
  });

  @override
  Widget build(BuildContext context) {
    final doc = controller.document;
    final pageW = doc.page.widthMm;
    final pageH = doc.page.heightMm;

    return LayoutBuilder(
      builder: (context, constraints) {
        const padding = 40.0;
        const labelBlock = 34.0; // room for the dimension label above the sheet
        final availW = math.max(1.0, constraints.maxWidth - padding * 2);
        final availH =
            math.max(1.0, constraints.maxHeight - padding * 2 - labelBlock);

        final pxPerMm = math.min(availW / pageW, availH / pageH);
        final sheetW = pageW * pxPerMm;
        final sheetH = pageH * pxPerMm;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SheetLabel(paperName: controller.paper.name, page: doc.page),
              const SizedBox(height: 12),
              Container(
                width: sheetW,
                height: sheetH,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.45),
                      blurRadius: 44,
                      spreadRadius: 2,
                      offset: const Offset(0, 20),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.22),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    for (var i = 0; i < doc.slots.length; i++)
                      Positioned(
                        left: doc.slots[i].rect.x * pxPerMm,
                        top: doc.slots[i].rect.y * pxPerMm,
                        width: doc.slots[i].rect.width * pxPerMm,
                        height: doc.slots[i].rect.height * pxPerMm,
                        child: SlotFrame(
                          controller: controller,
                          slot: doc.slots[i],
                          pxPerMm: pxPerMm,
                          index: i + 1,
                          onImport: () => onImportSlot(doc.slots[i].id),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SheetLabel extends StatelessWidget {
  final String paperName;
  final PageSpec page;

  const _SheetLabel({required this.paperName, required this.page});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final orient = (page.orientation == PageOrientation.landscape
            ? l10n.orientationLandscape
            : l10n.orientationPortrait)
        .toUpperCase();
    final w = page.widthMm.toStringAsFixed(0);
    final h = page.heightMm.toStringAsFixed(0);

    return Text(
      '$paperName  ·  $orient  ·  $w × $h mm',
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.72),
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
    );
  }
}

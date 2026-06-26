/// Renders a single slot in the preview: either an empty "drop zone" style
/// placeholder or the framed image, clipped to the slot like a window/mask.
///
/// The image is positioned using the exact same [LayoutEngine] math the
/// exporters use, scaled from mm to screen-px by [pxPerMm] — so what you see is
/// what prints.
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/layout_engine.dart';
import '../../core/slot.dart';
import '../document_controller.dart';
import '../theme.dart';

/// The framed slot: content, a thin separator border, and hover controls.
class SlotFrame extends StatefulWidget {
  final DocumentController controller;
  final PhotoSlot slot;
  final double pxPerMm;
  final int index;
  final VoidCallback onImport;

  const SlotFrame({
    super.key,
    required this.controller,
    required this.slot,
    required this.pxPerMm,
    required this.index,
    required this.onImport,
  });

  @override
  State<SlotFrame> createState() => _SlotFrameState();
}

class _SlotFrameState extends State<SlotFrame> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.controller.assetForSlot(widget.slot.id) != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasImage)
            SlotImageView(
              controller: widget.controller,
              slot: widget.slot,
              pxPerMm: widget.pxPerMm,
            )
          else
            _SlotPlaceholder(
              index: widget.index,
              hover: _hover,
              onTap: widget.onImport,
            ),

          // Thin separator/cut guide between slots (faint; print has no line).
          if (hasImage)
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.12),
                    width: 0.5,
                  ),
                ),
              ),
            ),

          // Hover controls for a filled slot.
          if (hasImage)
            Positioned(
              top: 8,
              right: 8,
              child: AnimatedOpacity(
                opacity: _hover ? 1 : 0,
                duration: const Duration(milliseconds: 140),
                child: IgnorePointer(
                  ignoring: !_hover,
                  child: _SlotControls(
                    onSwap: widget.onImport,
                    onReset: () =>
                        widget.controller.resetSlotImage(widget.slot.id),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SlotPlaceholder extends StatelessWidget {
  final int index;
  final bool hover;
  final VoidCallback onTap;

  const _SlotPlaceholder({
    required this.index,
    required this.hover,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = hover;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: accent ? RColors.accent : RColors.slotDash,
            strokeWidth: accent ? 2 : 1.4,
          ),
          child: Container(
            color: accent ? RColors.slotEmptyHover : RColors.slotEmpty,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: accent
                        ? RColors.accent.withValues(alpha: 0.14)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accent
                          ? RColors.accent.withValues(alpha: 0.0)
                          : RColors.chromeBorder,
                    ),
                  ),
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 26,
                    color: accent ? RColors.accent : RColors.muted,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Importar Foto $index',
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: RColors.ink,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Clique para escolher',
                  style: TextStyle(fontSize: 11.5, color: RColors.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Floating control pill shown over a filled slot on hover.
class _SlotControls extends StatelessWidget {
  final VoidCallback onSwap;
  final VoidCallback onReset;

  const _SlotControls({required this.onSwap, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconAction(
            icon: Icons.swap_horiz_rounded,
            tooltip: 'Trocar foto',
            onTap: onSwap,
          ),
          Container(width: 1, height: 20, color: Colors.white24),
          _IconAction(
            icon: Icons.restart_alt_rounded,
            tooltip: 'Redefinir enquadramento',
            onTap: onReset,
          ),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconAction({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  static const double _dash = 7;
  static const double _gap = 5;

  _DashedBorderPainter({required this.color, this.strokeWidth = 1.4});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final inset = strokeWidth / 2 + 5;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );
    final source = Path()..addRect(rect);

    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + _dash;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}

/// The interactive, clipped image inside a slot.
class SlotImageView extends StatefulWidget {
  final DocumentController controller;
  final PhotoSlot slot;
  final double pxPerMm;

  const SlotImageView({
    super.key,
    required this.controller,
    required this.slot,
    required this.pxPerMm,
  });

  @override
  State<SlotImageView> createState() => _SlotImageViewState();
}

class _SlotImageViewState extends State<SlotImageView> {
  double _scaleAtGestureStart = 1.0;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final slot = widget.slot;
    final ppm = widget.pxPerMm;

    final placed = controller.document.imageForSlot(slot.id);
    final asset = controller.assetForSlot(slot.id);
    if (placed == null || asset == null) {
      return const SizedBox.shrink();
    }

    final geom = LayoutEngine.placement(
      slot: slot.rect,
      image: asset.size,
      placement: placed,
    );
    final dest = geom.dest;

    // Image rect in slot-local screen px.
    final left = (dest.x - slot.rect.x) * ppm;
    final top = (dest.y - slot.rect.y) * ppm;
    final width = dest.width * ppm;
    final height = dest.height * ppm;

    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            final factor = event.scrollDelta.dy < 0 ? 1.04 : 1 / 1.04;
            controller.zoomSlotImage(slot.id, factor);
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTap: () => controller.resetSlotImage(slot.id),
          onScaleStart: (_) => _scaleAtGestureStart = placed.scale,
          onScaleUpdate: (details) {
            if (details.scale != 1.0) {
              controller.setSlotImageScale(
                  slot.id, _scaleAtGestureStart * details.scale);
            }
            final delta = details.focalPointDelta;
            if (delta != Offset.zero) {
              controller.panSlotImageByMm(
                  slot.id, delta.dx / ppm, delta.dy / ppm);
            }
          },
          child: ClipRect(
            child: Stack(
              children: [
                Positioned(
                  left: left,
                  top: top,
                  width: width,
                  height: height,
                  child: Image.memory(
                    asset.bytes,
                    fit: BoxFit.fill,
                    gaplessPlayback: true,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

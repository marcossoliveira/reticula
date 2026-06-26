/// The suite launcher: a grid of tool cards, a language switcher, and the
/// open-source / author credits. Only "Print Layout" is available today; the
/// rest are shown as "coming soon".
library;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import 'editor_page.dart';
import 'theme.dart';

/// Languages offered in the switcher, each shown in its own name (endonym).
const List<(Locale, String)> kLanguages = [
  (Locale('en'), 'English'),
  (Locale('pt'), 'Português (Brasil)'),
  (Locale('es'), 'Español'),
  (Locale('it'), 'Italiano'),
  (Locale('de'), 'Deutsch'),
  (Locale('ja'), '日本語'),
  (Locale('zh'), '中文'),
];

class _Tool {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final bool available;

  const _Tool({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.available,
  });
}

class HomeScreen extends StatelessWidget {
  final Locale? locale;
  final ValueChanged<Locale?> onLocaleChanged;

  const HomeScreen({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });

  void _openPrintLayout(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EditorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final tools = <_Tool>[
      _Tool(
        icon: Icons.grid_view_rounded,
        color: RColors.accent,
        title: l10n.toolPrintLayoutTitle,
        description: l10n.toolPrintLayoutDesc,
        available: true,
      ),
      _Tool(
        icon: Icons.auto_awesome_mosaic_outlined,
        color: const Color(0xFFEC4899),
        title: l10n.toolSocialCollageTitle,
        description: l10n.toolSocialCollageDesc,
        available: false,
      ),
      _Tool(
        icon: Icons.card_giftcard_outlined,
        color: const Color(0xFFF59E0B),
        title: l10n.toolCardsTitle,
        description: l10n.toolCardsDesc,
        available: false,
      ),
      _Tool(
        icon: Icons.calendar_month_outlined,
        color: const Color(0xFF10B981),
        title: l10n.toolCalendarTitle,
        description: l10n.toolCalendarDesc,
        available: false,
      ),
      _Tool(
        icon: Icons.photo_album_outlined,
        color: const Color(0xFF06B6D4),
        title: l10n.toolPhotobookTitle,
        description: l10n.toolPhotobookDesc,
        available: false,
      ),
      _Tool(
        icon: Icons.sell_outlined,
        color: const Color(0xFF8B5CF6),
        title: l10n.toolLabelsTitle,
        description: l10n.toolLabelsDesc,
        available: false,
      ),
    ];

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFBFBFE), Color(0xFFEFF0F8)],
          ),
        ),
        child: Column(
          children: [
            _HomeBar(
              locale: locale,
              onLocaleChanged: onLocaleChanged,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1040),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.chooseTool,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: RColors.ink,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Wrap(
                          spacing: 18,
                          runSpacing: 18,
                          children: [
                            for (final tool in tools)
                              _ToolCard(
                                tool: tool,
                                comingSoonLabel: l10n.comingSoon,
                                openLabel: l10n.open,
                                onOpen: tool.available
                                    ? () => _openPrintLayout(context)
                                    : null,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const _CreditsFooter(),
          ],
        ),
      ),
    );
  }
}

class _HomeBar extends StatelessWidget {
  final Locale? locale;
  final ValueChanged<Locale?> onLocaleChanged;

  const _HomeBar({required this.locale, required this.onLocaleChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final active = Localizations.localeOf(context).languageCode;

    return Container(
      decoration: const BoxDecoration(
        color: RColors.chrome,
        border: Border(bottom: BorderSide(color: RColors.chromeBorder)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
      child: Row(
        children: [
          const BrandMark(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                l10n.suiteSubtitle,
                style: const TextStyle(fontSize: 12, color: RColors.muted),
              ),
            ),
          ),
          PopupMenuButton<Locale>(
            tooltip: l10n.language,
            icon: const Icon(Icons.language, color: RColors.ink),
            onSelected: onLocaleChanged,
            itemBuilder: (context) => [
              for (final (loc, name) in kLanguages)
                PopupMenuItem(
                  value: loc,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22,
                        child: active == loc.languageCode
                            ? const Icon(Icons.check, size: 16, color: RColors.accent)
                            : null,
                      ),
                      Text(name),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The brand logo + wordmark, reused on the home bar and editor bar.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

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
        const Text(
          kAppName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: RColors.ink,
          ),
        ),
      ],
    );
  }
}

class _ToolCard extends StatefulWidget {
  final _Tool tool;
  final String comingSoonLabel;
  final String openLabel;
  final VoidCallback? onOpen;

  const _ToolCard({
    required this.tool,
    required this.comingSoonLabel,
    required this.openLabel,
    required this.onOpen,
  });

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final tool = widget.tool;
    final enabled = tool.available;

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onOpen,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          width: 314,
          transform: Matrix4.translationValues(0, _hover && enabled ? -3 : 0, 0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hover && enabled
                  ? tool.color.withValues(alpha: 0.5)
                  : RColors.chromeBorder,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hover && enabled ? 0.10 : 0.04),
                blurRadius: _hover && enabled ? 22 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Opacity(
            opacity: enabled ? 1 : 0.62,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: tool.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(tool.icon, color: tool.color, size: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  tool.title,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    color: RColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tool.description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: RColors.muted,
                  ),
                ),
                const SizedBox(height: 16),
                if (enabled)
                  Row(
                    children: [
                      Text(
                        widget.openLabel,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: tool.color,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded, size: 16, color: tool.color),
                    ],
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F3F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.comingSoonLabel,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: RColors.muted,
                      ),
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

class _CreditsFooter extends StatelessWidget {
  const _CreditsFooter();

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: RColors.chrome,
        border: Border(top: BorderSide(color: RColors.chromeBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          const Icon(Icons.lock_open_outlined, size: 14, color: RColors.muted),
          Text(
            l10n.openSource,
            style: const TextStyle(fontSize: 12, color: RColors.muted),
          ),
          const _Dot(),
          _LinkText(label: l10n.viewSource, onTap: () => _open(kRepoUrl)),
          const _Dot(),
          _LinkText(
            label: l10n.madeBy(kAuthorName),
            onTap: () => _open(kAuthorUrl),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();
  @override
  Widget build(BuildContext context) => const Text(
        '·',
        style: TextStyle(fontSize: 12, color: RColors.muted),
      );
}

class _LinkText extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _LinkText({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: RColors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

# Reticula

**Reticula** is a free and open source app for creating photo layouts on real
print sheets. It is built with Flutter/Dart.

> ⚠️ **Status: early alpha.** Reticula is usable but young. Expect missing
> features, rough edges, and changes between versions.

[![build](https://github.com/marcossoliveira/reticula/actions/workflows/build.yml/badge.svg)](https://github.com/marcossoliveira/reticula/actions/workflows/build.yml)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

Made by [Marcos Oliveira](https://github.com/marcossoliveira) ·
Repository: <https://github.com/marcossoliveira/reticula>

## What is Reticula?

Reticula helps you arrange photos on real paper formats (like A4) and export a
print-ready file at the correct physical size. The page is the source of truth:
everything is measured in millimetres, so what you export matches what you print.

### The problem it solves

Printing photos at a precise size, with no margins and controlled framing, is
fiddly with generic tools — office suites resize unpredictably, and photo apps
rarely think in real paper dimensions. Reticula keeps the layout physically
accurate from screen to paper.

## Project status

Reticula is in **early alpha**. The desktop app runs and exports correctly, but
it is still small and evolving. It is the first tool of a planned small suite of
photo utilities; only **Print Layout** exists today.

## Current MVP — Print Layout

Arrange photos on a sheet, frame each one, and export a print-ready file.

### Implemented features

- **Paper sizes:** A3, A4, A5, A6, Letter, Legal, 10 × 15 cm, 13 × 18 cm.
- **Orientation:** portrait or landscape.
- **Grids:** 1, 2 (side-by-side or stacked), 4, 6, 8, 9, 12 equal cells that tile
  the sheet edge-to-edge with no margin.
- **Framing:** each cell is a window/mask — drag to reposition, scroll/pinch to
  zoom, double-click to reset. The image fills its cell (cover) and is clipped to
  it, so nothing leaks past the cell.
- **Export:** PDF, PNG (300 DPI) and JPEG (300 DPI), computed from the model
  (not a screenshot). PNG/JPEG are rasterized from the same PDF.
- **Localization:** English, Português (Brasil), Español, Italiano, Deutsch,
  日本語, 中文 — follows the system language, with an in-app switcher.

Example: A4 landscape + a 2×1 grid = two A5-portrait photos side by side, no
margin (A4 landscape @ 300 DPI ≈ 3508 × 2480 px).

### Planned / not yet implemented

These are **planned** and not available yet:

- Save / open projects (`.reticula` files) — *planned*
- Drag-and-drop image import — *planned*
- System print dialog — *planned*
- Margins, gutters and cut guides — *planned*
- The other suite tools (Social Collage, Cards, Calendar, Photo Book, Labels)
  shown as "coming soon" in the app — *planned*
- Android and iOS builds — *planned*

See [ROADMAP.md](ROADMAP.md) for the bigger picture and
[CHANGELOG.md](CHANGELOG.md) for what changed.

## Screenshots

Screenshots will be added soon.

## Tech stack

- Flutter / Dart
- [`pdf`](https://pub.dev/packages/pdf) — physical-size PDF generation
- [`printing`](https://pub.dev/packages/printing) — rasterize the PDF to PNG/JPEG at real DPI
- [`image`](https://pub.dev/packages/image) — JPEG encoding
- [`file_selector`](https://pub.dev/packages/file_selector) — native open/save dialogs
- [`url_launcher`](https://pub.dev/packages/url_launcher) — open repository / author links
- `flutter_localizations` + `intl` — localization
- State management: `ChangeNotifier`

The core (document model + layout math) is pure Dart with no Flutter dependency,
so it is testable and reusable.

## Platforms

| Platform | Status |
|----------|--------|
| macOS    | Runs; primary development target |
| Windows  | Builds in CI — **experimental**, not extensively tested |
| Linux    | Builds in CI — **experimental**, not extensively tested |
| Android  | Planned — not built yet |
| iOS      | Planned — not built yet |

## Running locally

Prerequisites: [Flutter](https://docs.flutter.dev/get-started/install)
(stable channel). Check your setup with `flutter doctor`.

```bash
git clone https://github.com/marcossoliveira/reticula.git
cd reticula
flutter pub get
flutter run -d macos      # or: -d windows, -d linux
```

### Tests & analysis

```bash
flutter test
flutter analyze
```

### Render a sample PDF without the GUI

```bash
dart run tool/sample_export.dart /output/dir
```

## Building

```bash
flutter build macos       # or: windows, linux
```

Continuous integration ([`.github/workflows/build.yml`](.github/workflows/build.yml))
builds macOS, Windows and Linux on every push and pull request, uploading each as
an artifact. Pushing a tag like `v0.1.0-alpha` additionally publishes a GitHub
Release with the three builds attached. To regenerate app icons:
`dart run flutter_launcher_icons`.

## Printing tip

Reticula produces borderless files, but true borderless printing also depends on
your printer and driver. When printing, use:

- Scale: **100%**
- Fit to page: **off**
- Borderless: **on**, if your printer supports it

## Contributing

Contributions are very welcome — code, design, docs, translations, bug reports,
and especially **real-world print testing**. See [CONTRIBUTING.md](CONTRIBUTING.md)
to get started, and please follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## License

Reticula is licensed under the GNU General Public License v3.0.

See the [LICENSE](LICENSE) file for the full text.

Copyright © 2026 Marcos Oliveira.

## Roadmap

A short roadmap lives in [ROADMAP.md](ROADMAP.md). It describes direction only —
no dates are promised.

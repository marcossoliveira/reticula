# Reticula

**Reticula** is an open-source suite of photo tools. The first (and currently
only) tool is **Print Layout**: arrange photos on real-size sheets for precise,
physically accurate printing.

> Reticula helps people organize photos onto A4, A5 and other sheets with exact
> control over size, margins and framing, producing print-ready files.

Made by [Marcos Oliveira](https://github.com/marcossoliveira) ·
Repository: <https://github.com/marcossoliveira/reticula>

[![build](https://github.com/marcossoliveira/reticula/actions/workflows/build.yml/badge.svg)](https://github.com/marcossoliveira/reticula/actions/workflows/build.yml)

## Tools

| Tool | Status |
|------|--------|
| **Print Layout** — arrange photos on real sheets for precise printing | ✅ Available |
| Social Collage — collages sized for social networks | 🔜 Coming soon |
| Cards & Invitations | 🔜 Coming soon |
| Photo Calendar | 🔜 Coming soon |
| Photo Book | 🔜 Coming soon |
| Labels & Stickers | 🔜 Coming soon |

The app opens on a launcher screen with a card per tool; only Print Layout is
active today.

## Print Layout

Arrange photos on a sheet, frame each one (pan / zoom / crop), and export to a
print-ready file at real physical size.

- **Paper sizes:** A3, A4, A5, A6, Letter, Legal, 10 × 15 cm, 13 × 18 cm.
- **Orientation:** portrait or landscape.
- **Grids:** 1, 2 (side-by-side or stacked), 4, 6, 8, 9, 12 equal cells that
  tile the sheet edge-to-edge with no margin.
- **Framing:** each cell is a window/mask; drag to reposition, scroll/pinch to
  zoom, double-click to reset. The image always fills its cell (cover), never
  leaking past it.
- **Export:** PDF, PNG (300 DPI) and JPEG (300 DPI).

Example: A4 landscape + a 2×1 grid = two A5-portrait photos side by side, no
margin (A4 landscape @ 300 DPI ≈ 3508 × 2480 px).

## Languages

The UI is fully localized and follows the system language, with an in-app
switcher: **English, Português (Brasil), Español, Italiano, Deutsch, 日本語,
中文**.

## Principle

The UI is never the source of truth. The source of truth is a **document model**
in physical units (millimetres). The screen is only a preview/editor; exports are
computed from the model, never captured from the screen.

A single layout engine (in mm) is shared by three renderers, each converting
mm into its own unit:

| Renderer | Unit | Conversion |
|----------|------|-----------|
| Preview  | screen pixels      | mm × px/mm      |
| PDF      | points (pt)        | mm × 72 / 25.4  |
| PNG/JPEG | pixels at real DPI | mm / 25.4 × DPI |

PNG and JPEG are rasterized from the *same* PDF, so all outputs share one layout
and the size is derived from physical dimensions, not the window size.

## Stack

- Flutter / Dart
- [`pdf`](https://pub.dev/packages/pdf) — physical-size PDF generation
- [`printing`](https://pub.dev/packages/printing) — rasterize the PDF to PNG/JPEG at real DPI
- [`image`](https://pub.dev/packages/image) — JPEG encoding
- [`file_selector`](https://pub.dev/packages/file_selector) — native open/save dialogs
- [`url_launcher`](https://pub.dev/packages/url_launcher) — open repository / author links
- `flutter_localizations` + `intl` — localization
- State: `ChangeNotifier`

## Platforms

| Platform | Status |
|----------|--------|
| macOS | ✅ built & tested |
| Windows | ✅ built in CI |
| Linux | ✅ built in CI |
| Android / iOS | planned |

## Project structure

```txt
reticula/                    # repository root = the Flutter app
  .github/workflows/build.yml # CI: build macOS / Windows / Linux
  l10n.yaml
  assets/icon/                # app icon source
  lib/
    main.dart
    l10n/                     # ARB files (7 languages) + generated localizations
    src/
      core/                   # pure Dart, no Flutter — the source of truth
        units.dart            # mm / pt / px conversions
        geometry.dart         # RectMm, SizeMm, PixelSize
        document.dart         # ReticulaDocument, PageSpec, orientation
        slot.dart             # PhotoSlot
        placed_image.dart     # PlacedImage, CropMode
        layout_engine.dart    # crop/framing math (cover/contain/clamp)
        paper.dart            # paper-size catalog
        grid.dart             # grid options
        document_builder.dart # build a document from paper × orientation × grid
      export/                 # depends only on core
        resolved_image.dart
        export_format.dart    # PDF / PNG / JPEG
        pdf_exporter.dart
        raster_exporter.dart  # PNG/JPEG from the rendered PDF
      ui/                     # editor + launcher (depends on core + export)
        theme.dart
        home_screen.dart      # tool launcher, language switcher, credits
        document_controller.dart
        editor_page.dart
        widgets/
          sheet_preview.dart
          slot_view.dart
  tool/
    sample_export.dart        # dev tool: render a sample PDF from the model
  test/                       # unit + widget tests
  macos/ windows/ linux/ android/ ios/ web/
```

`core/` and `export/` are pure Dart / UI-free, ready to be extracted as
standalone packages.

## Running on macOS

Prerequisites: [Flutter](https://docs.flutter.dev/get-started/install/macos)
(stable channel) and Xcode command-line tools. Check with `flutter doctor`.

```bash
flutter pub get
flutter run -d macos
```

Build a release (`macos`, `windows` or `linux`):

```bash
flutter build macos
```

### Tests & analysis

```bash
flutter test
flutter analyze
```

### Regenerate app icons

```bash
dart run flutter_launcher_icons
```

### Render a sample PDF (no GUI)

```bash
dart run tool/sample_export.dart /output/dir
```

## Continuous integration

[`.github/workflows/build.yml`](.github/workflows/build.yml) runs on every push
and pull request:

- **test** — `flutter analyze` + `flutter test`
- **macos / windows / linux** — `flutter build` per platform, uploading the app
  as a build artifact (`.zip`, `Release/` folder and `.tar.gz` respectively).

Flutter is pinned to a fixed version for reproducible builds.

## Printing tip

Reticula produces borderless files, but true borderless printing also depends on
your printer and driver. When printing, use:

- Scale: **100%**
- Fit to page: **off**
- Borderless: **on**, if your printer supports it

## Roadmap

- [x] Suite launcher with tool cards
- [x] Print Layout: paper sizes, orientation, grids
- [x] Framing (pan / zoom / crop) with cover clamping
- [x] Export PDF / PNG / JPEG at 300 DPI
- [x] Localization (7 languages)
- [x] App icon & branding
- [x] CI builds for macOS / Windows / Linux
- [ ] Save / open a project (`.reticula`)
- [ ] Drag-and-drop image import
- [ ] System print dialog
- [ ] More tools (Social Collage, etc.)

## License

To be defined (open source). Candidates under consideration: GPL-3.0, AGPL-3.0,
MPL-2.0, Apache-2.0, MIT.

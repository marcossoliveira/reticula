# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Reticula is in early alpha; it will aim to follow
[Semantic Versioning](https://semver.org/) once it reaches a stable release.

## [Unreleased]

## [0.1.0-alpha]

First public alpha.

### Added

- **Print Layout** tool: arrange photos on real-size print sheets.
- Paper sizes: A3, A4, A5, A6, Letter, Legal, 10 × 15 cm and 13 × 18 cm.
- Portrait / landscape orientation.
- Configurable grids (1, 2, 4, 6, 8, 9, 12 cells) that tile the sheet with no
  margin.
- Manual framing per cell: pan, zoom and crop (cover fit, clipped to the cell).
- Export to PDF, PNG (300 DPI) and JPEG (300 DPI), computed from the document
  model.
- Localization in 7 languages (English, Português, Español, Italiano, Deutsch,
  日本語, 中文) with an in-app switcher.
- Tool launcher home screen, with other planned tools marked "coming soon".
- App icon and branding.

### Project / repository

- Continuous integration building macOS, Windows and Linux, with a release job
  that attaches the builds to a tagged GitHub Release.
- Open source documentation: README, license (GPL-3.0), contributing guide, code
  of conduct, security policy, roadmap, and issue/PR templates.

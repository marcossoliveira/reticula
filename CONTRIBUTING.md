# Contributing to Reticula

Thanks for your interest in Reticula! It is an early-alpha, free and open source
project, and contributions of all kinds are welcome — you do not need to be a
Flutter expert to help.

Please be kind and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## Ways to contribute

- **Flutter/Dart development** — features, fixes, refactors
- **UI/UX improvements** — design, usability, polish
- **Documentation** — README, guides, code comments
- **Bug reports** — tell us what broke (use the issue templates)
- **Feature suggestions** — ideas and use cases
- **Print testing** — print real sheets and tell us how the sizes turned out
- **Platform testing** — try the app on macOS, Windows, Linux, Android and iOS
- **Translations** — add or improve a language (see below)

## Local setup

You need [Flutter](https://docs.flutter.dev/get-started/install) (stable channel).
Check your setup with `flutter doctor`.

```bash
git clone https://github.com/marcossoliveira/reticula.git
cd reticula
flutter pub get
flutter run -d macos      # or -d windows, -d linux
```

Useful commands:

```bash
flutter analyze                  # static analysis
flutter test                     # run tests
dart run flutter_launcher_icons  # regenerate app icons
```

## Translations

UI strings live in `lib/l10n/*.arb` — one file per language, with `app_en.arb`
as the template. To add or update a language, edit the matching `.arb` file and
regenerate the localizations:

```bash
flutter gen-l10n
```

## Branches and pull requests

1. Fork the repository and create a branch from `master` (e.g. `fix/slot-clipping`).
2. Make your change in small, focused commits.
3. Run `flutter analyze` and `flutter test` — both should pass.
4. Open a pull request and fill in the template.

### Pull request checklist

- [ ] `flutter analyze` passes with no new issues
- [ ] `flutter test` passes
- [ ] The change is focused and clearly described
- [ ] UI changes include a screenshot
- [ ] Docs / translations updated if relevant

## Code style

Follow the existing style and the rules in `analysis_options.yaml`. Please keep
the `lib/src/core` layer free of Flutter imports — it is intentionally pure Dart
(the document model and layout math), so it stays testable and reusable.

## Questions

Open an issue or a discussion — we are happy to help newcomers.

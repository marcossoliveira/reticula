# Security Policy

Reticula is a desktop app that works with **local files and your own images**, so
privacy and filesystem safety matter to us.

## Supported versions

Reticula is in early alpha. Security fixes target the latest version on the
default branch (`master`) and the most recent release.

## Reporting a vulnerability

Please report security issues **privately**, before any public disclosure, so we
can fix them first.

- Preferred: open a private report through GitHub's
  [security advisories](https://github.com/marcossoliveira/reticula/security/advisories/new)
  (the repository's **Security → Report a vulnerability**).
- Alternatively, contact the maintainer privately:
  [@marcossoliveira](https://github.com/marcossoliveira).

Please do **not** open a public issue for a serious vulnerability.

When reporting, please include:

- A description of the issue and its impact
- Steps to reproduce, if possible
- The affected platform and version

We will acknowledge your report, investigate, and keep you informed. Thank you
for helping keep Reticula and its users safe.

## Scope notes

Because Reticula reads images and writes export files chosen by the user, relevant
issues include, for example: reading or writing files outside what the user
selected, mishandling untrusted or malformed image files, or unexpectedly leaking
local file paths or image data.

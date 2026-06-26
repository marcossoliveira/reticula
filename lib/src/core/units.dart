/// Physical-unit conversions for Reticula.
///
/// The document model is the source of truth and is expressed in
/// **millimetres (mm)**. Each renderer converts mm into its own working unit:
///
/// * PDF      -> points (pt), where 1 inch = 72 pt
/// * PNG/JPEG -> pixels at a target DPI
/// * Preview  -> screen pixels at a "px per mm" scale chosen to fit the window
///
/// Keeping a single physical unit (mm) means nothing is ever measured in
/// screen pixels, so exports stay physically accurate regardless of the
/// window size.
library;

/// Millimetres per inch.
const double mmPerInch = 25.4;

/// PDF points per inch.
const double ptPerInch = 72.0;

/// Convert millimetres to PDF points.
double mmToPt(double mm) => mm * ptPerInch / mmPerInch;

/// Convert PDF points to millimetres.
double ptToMm(double pt) => pt * mmPerInch / ptPerInch;

/// Convert millimetres to pixels at a given [dpi].
double mmToPx(double mm, double dpi) => mm / mmPerInch * dpi;

/// Convert pixels at a given [dpi] to millimetres.
double pxToMm(double px, double dpi) => px * mmPerInch / dpi;

/// Convert inches to millimetres.
double inToMm(double inches) => inches * mmPerInch;

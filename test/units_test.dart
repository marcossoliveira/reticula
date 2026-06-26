import 'package:flutter_test/flutter_test.dart';

import 'package:reticula_app/src/core/units.dart';

void main() {
  test('millimetres <-> points', () {
    expect(mmToPt(25.4), closeTo(72.0, 1e-9));
    expect(mmToPt(297), closeTo(841.8897637795275, 1e-6)); // A4 long edge
    expect(mmToPt(210), closeTo(595.2755905511812, 1e-6)); // A4 short edge
    expect(ptToMm(72), closeTo(25.4, 1e-9));
  });

  test('millimetres -> pixels at 300 DPI (A4)', () {
    // A4 landscape at 300 DPI should be ~3508 x 2480 px.
    expect(mmToPx(297, 300).round(), 3508);
    expect(mmToPx(210, 300).round(), 2480);
  });
}

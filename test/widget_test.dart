import 'package:flutter_test/flutter_test.dart';

import 'package:reticula_app/src/app.dart';

void main() {
  testWidgets('Home lists tools and opens the Print Layout editor',
      (tester) async {
    await tester.pumpWidget(const ReticulaApp());
    await tester.pumpAndSettle();

    // Home screen (default locale: English).
    expect(find.text('Reticula'), findsOneWidget);
    expect(find.text('Choose a tool'), findsOneWidget);
    expect(find.text('Print Layout'), findsWidgets);

    // Open the only available tool.
    await tester.tap(find.text('Print Layout').first);
    await tester.pumpAndSettle();

    // Editor is shown with its controls.
    expect(find.text('Paper'), findsOneWidget);
    expect(find.text('Export'), findsOneWidget);
    expect(find.text('Import Photo 1'), findsOneWidget);
  });
}

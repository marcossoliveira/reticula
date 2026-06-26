import 'package:flutter_test/flutter_test.dart';

import 'package:reticula_app/src/app.dart';

void main() {
  testWidgets('Editor shows the Reticula header and import buttons',
      (tester) async {
    await tester.pumpWidget(const ReticulaApp());

    expect(find.text('Reticula'), findsOneWidget);
    expect(find.text('Exportar PDF'), findsOneWidget);
    expect(find.text('PNG 300 DPI'), findsOneWidget);
    // Import is now driven from the empty-slot placeholders (one per slot).
    expect(find.text('Importar Foto 1'), findsOneWidget);
    expect(find.text('Importar Foto 2'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart'; // import relativo para que funcione

void main() {
  testWidgets('Botones principales aparecen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp()); // sin const

    // Verifica que los botones "Trabajadores" y "Asignación" estén en pantalla
    expect(find.text('Trabajadores'), findsOneWidget);
    expect(find.text('Asignación'), findsOneWidget);
  });
}

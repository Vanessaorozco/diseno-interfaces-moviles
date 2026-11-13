import 'package:flutter_test/flutter_test.dart';

import 'package:diseno_interfaces_moviles/main.dart';

void main() {
  testWidgets('La pantalla inicial muestra las tres demos', (tester) async {
    await tester.pumpWidget(const DisenoApp());

    expect(find.text('Material Design'), findsOneWidget);
    expect(find.text('Human Interface Guidelines'), findsOneWidget);
    expect(find.text('Widgets adaptativos'), findsOneWidget);
  });
}

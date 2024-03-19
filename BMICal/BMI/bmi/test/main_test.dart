import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi/main.dart';

void main() {
  group('BMICalculatorScreen Widget Test', () {
    testWidgets('Initial UI should contain two text fields and a button',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BMICalculatorScreen()));

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Calculate button should be disabled initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BMICalculatorScreen()));

      expect(
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
          isFalse);
    });

    testWidgets('Calculate button should be enabled when weight and height are entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BMICalculatorScreen()));

      await tester.enterText(find.byType(TextField).first, '70'); // Enter weight
      await tester.enterText(find.byType(TextField).last, '170'); // Enter height

      expect(
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
          isTrue);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/widgets/price_summary.dart';

void main() {
  Widget buildTestWidget(PriceSummary widget) {
    return MaterialApp(home: Scaffold(body: widget));
  }

  group('PriceSummary', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const PriceSummary(title: 'Order Summary', rows: []),
      ));
      expect(find.text('Order Summary'), findsOneWidget);
    });

    testWidgets('renders all price rows', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const PriceSummary(
          title: 'Summary',
          rows: [
            PriceRow(label: 'Subtotal', value: '100 Kč'),
            PriceRow(label: 'Shipping', value: '50 Kč'),
            PriceRow(label: 'Total', value: '150 Kč', isBold: true),
          ],
        ),
      ));
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('100 Kč'), findsOneWidget);
      expect(find.text('Shipping'), findsOneWidget);
      expect(find.text('50 Kč'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('150 Kč'), findsOneWidget);
    });

    testWidgets('bold row uses heavier font weight', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const PriceSummary(
          title: 'Summary',
          rows: [
            PriceRow(label: 'Normal', value: '10'),
            PriceRow(label: 'Bold', value: '20', isBold: true),
          ],
        ),
      ));

      final normalText = tester.widget<Text>(find.text('Normal'));
      final boldText = tester.widget<Text>(find.text('Bold'));

      expect(normalText.style!.fontWeight, FontWeight.w400);
      expect(boldText.style!.fontWeight, FontWeight.w600);
    });

    testWidgets('respects titleOpacity', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const PriceSummary(
          title: 'Faded Title',
          rows: [],
          titleOpacity: 0.5,
        ),
      ));

      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, 0.5);
    });

    test('PriceRow defaults isBold to false', () {
      const row = PriceRow(label: 'Test', value: '0');
      expect(row.isBold, isFalse);
    });
  });
}

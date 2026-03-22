import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/widgets/sheet_button.dart';

void main() {
  Widget buildTestWidget(SheetButton button) {
    return MaterialApp(home: Scaffold(body: button));
  }

  group('SheetButton', () {
    testWidgets('renders icon and label', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SheetButton(
          icon: Icons.share,
          label: 'Share',
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          onPressed: () {},
        ),
      ));
      expect(find.text('Share'), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(buildTestWidget(
        SheetButton(
          icon: Icons.edit,
          label: 'Edit',
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          onPressed: () => pressed = true,
        ),
      ));
      await tester.tap(find.text('Edit'));
      expect(pressed, isTrue);
    });

    testWidgets('has full width', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SheetButton(
          icon: Icons.delete,
          label: 'Delete',
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: () {},
        ),
      ));

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, double.infinity);
    });

    testWidgets('has correct height of 56', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SheetButton(
          icon: Icons.save,
          label: 'Save',
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {},
        ),
      ));

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.height, 56);
    });

    testWidgets('uses foreground color for icon', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SheetButton(
          icon: Icons.add,
          label: 'Add',
          backgroundColor: Colors.purple,
          foregroundColor: Colors.red,
          onPressed: () {},
        ),
      ));

      final icon = tester.widget<Icon>(find.byIcon(Icons.add));
      expect(icon.color, Colors.red);
    });
  });
}

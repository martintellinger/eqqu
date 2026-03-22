import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eqqu/main.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const EqquApp());
    expect(find.byType(MaterialApp), findsOneWidget);
    // Dispose pending timers from splash screen animations
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}

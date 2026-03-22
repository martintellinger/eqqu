import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/widgets/seller_card.dart';

void main() {
  Widget buildTestWidget(SellerCard card) {
    return MaterialApp(home: Scaffold(body: card));
  }

  group('SellerCard', () {
    testWidgets('renders seller name', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const SellerCard(
          name: 'Emma Novak',
          avatarAsset: 'assets/images/avatar_1.png',
        ),
      ));
      expect(find.text('Emma Novak'), findsOneWidget);
    });

    testWidgets('renders correct number of filled stars', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const SellerCard(
          name: 'Test',
          avatarAsset: 'assets/images/avatar_1.png',
          filledStars: 3,
        ),
      ));

      final filledStars = find.byIcon(Icons.star);
      final emptyStars = find.byIcon(Icons.star_border);
      expect(filledStars, findsNWidgets(3));
      expect(emptyStars, findsNWidgets(2));
    });

    testWidgets('renders rating text', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const SellerCard(
          name: 'Test',
          avatarAsset: 'assets/images/avatar_1.png',
          ratingText: '3.5',
        ),
      ));
      expect(find.text('3.5'), findsOneWidget);
    });

    testWidgets('shows message CTA when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SellerCard(
          name: 'Test',
          avatarAsset: 'assets/images/avatar_1.png',
          messageCta: 'Send message',
          onMessageTap: () {},
        ),
      ));
      expect(find.text('Send message'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    });

    testWidgets('hides message CTA when not provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const SellerCard(
          name: 'Test',
          avatarAsset: 'assets/images/avatar_1.png',
        ),
      ));
      expect(find.byIcon(Icons.chat_bubble_outline), findsNothing);
    });

    testWidgets('onTap callback fires', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(buildTestWidget(
        SellerCard(
          name: 'Test',
          avatarAsset: 'assets/images/avatar_1.png',
          onTap: () => tapped = true,
        ),
      ));
      await tester.tap(find.byType(GestureDetector).first);
      expect(tapped, isTrue);
    });

    testWidgets('message CTA tap callback fires', (tester) async {
      bool messageTapped = false;
      await tester.pumpWidget(buildTestWidget(
        SellerCard(
          name: 'Test',
          avatarAsset: 'assets/images/avatar_1.png',
          messageCta: 'Message',
          onMessageTap: () => messageTapped = true,
        ),
      ));
      await tester.tap(find.text('Message'));
      expect(messageTapped, isTrue);
    });

    test('defaults filledStars to 4 and ratingText to 4.2', () {
      const card = SellerCard(
        name: 'Test',
        avatarAsset: 'assets/images/avatar_1.png',
      );
      expect(card.filledStars, 4);
      expect(card.ratingText, '4.2');
    });
  });
}

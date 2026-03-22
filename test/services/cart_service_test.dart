import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/services/cart_service.dart';

void main() {
  group('CartService.totalProductPrice', () {
    test('returns 0 for empty list', () {
      expect(CartService.totalProductPrice([]), 0);
    });

    test('sums prices correctly', () {
      final items = [
        {'priceNum': '100'},
        {'priceNum': '200'},
      ];
      expect(CartService.totalProductPrice(items), 300);
    });

    test('handles missing priceNum', () {
      final items = [
        {'name': 'test'},
      ];
      expect(CartService.totalProductPrice(items), 0);
    });

    test('handles invalid priceNum', () {
      final items = [
        {'priceNum': 'abc'},
      ];
      expect(CartService.totalProductPrice(items), 0);
    });
  });

  group('CartService.deliveryPrice', () {
    test('returns 0 for pickup', () {
      expect(CartService.deliveryPrice('pickup'), 0);
    });

    test('returns 2 for delivery', () {
      expect(CartService.deliveryPrice('delivery'), 2);
    });
  });

  group('CartService.buyerProtectionFee', () {
    test('returns 0 for empty cart', () {
      expect(CartService.buyerProtectionFee([]), 0);
    });

    test('returns 2 for non-empty cart', () {
      expect(CartService.buyerProtectionFee([{'priceNum': '10'}]), 2);
    });
  });

  group('CartService.totalPrice', () {
    test('calculates total with delivery', () {
      final items = [{'priceNum': '100'}];
      // 100 + 2 (delivery) + 2 (protection) = 104
      expect(CartService.totalPrice(items, 'delivery'), 104);
    });

    test('calculates total with pickup', () {
      final items = [{'priceNum': '100'}];
      // 100 + 0 (pickup) + 2 (protection) = 102
      expect(CartService.totalPrice(items, 'pickup'), 102);
    });

    test('returns delivery fee for empty cart', () {
      // 0 products + 2 delivery + 0 protection = 2
      expect(CartService.totalPrice([], 'delivery'), 2);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/enums.dart';
import 'package:eqqu/services/cart_service.dart';

void main() {
  group('CartService.totalProductPrice', () {
    test('returns 0 for empty list', () {
      expect(CartService.totalProductPrice([]), 0);
    });

    test('sums prices correctly', () {
      const items = [
        CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: ''),
        CartItem(title: 'B', price: '200 €', priceNum: 200, imageAsset: ''),
      ];
      expect(CartService.totalProductPrice(items), 300);
    });
  });

  group('CartService.deliveryPrice', () {
    test('returns 0 for pickup', () {
      expect(CartService.deliveryPrice(DeliveryMethod.pickup), 0);
    });

    test('returns 2 for address delivery', () {
      expect(CartService.deliveryPrice(DeliveryMethod.address), 2);
    });
  });

  group('CartService.buyerProtectionFee', () {
    test('returns 0 for empty cart', () {
      expect(CartService.buyerProtectionFee([]), 0);
    });

    test('returns 2 for non-empty cart', () {
      const items = [CartItem(title: 'A', price: '10 €', priceNum: 10, imageAsset: '')];
      expect(CartService.buyerProtectionFee(items), 2);
    });
  });

  group('CartService.totalPrice', () {
    test('calculates total with delivery', () {
      const items = [CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: '')];
      // 100 + 2 (delivery) + 2 (protection) = 104
      expect(CartService.totalPrice(items, DeliveryMethod.address), 104);
    });

    test('calculates total with pickup', () {
      const items = [CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: '')];
      // 100 + 0 (pickup) + 2 (protection) = 102
      expect(CartService.totalPrice(items, DeliveryMethod.pickup), 102);
    });

    test('returns delivery fee for empty cart', () {
      // 0 products + 2 delivery + 0 protection = 2
      expect(CartService.totalPrice([], DeliveryMethod.address), 2);
    });
  });
}

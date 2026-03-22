import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/providers/cart_provider.dart';

void main() {
  group('CartProvider', () {
    late CartProvider provider;

    setUp(() {
      provider = CartProvider();
    });

    test('starts empty', () {
      expect(provider.items, isEmpty);
      expect(provider.totalProductPrice, 0);
    });

    test('addItem adds to list', () {
      provider.addItem({'priceNum': '100', 'name': 'Test'});
      expect(provider.items.length, 1);
    });

    test('removeItem removes from list', () {
      provider.addItem({'priceNum': '100'});
      provider.addItem({'priceNum': '200'});
      provider.removeItem(0);
      expect(provider.items.length, 1);
      expect(provider.totalProductPrice, 200);
    });

    test('totalProductPrice sums correctly', () {
      provider.addItem({'priceNum': '100'});
      provider.addItem({'priceNum': '50'});
      expect(provider.totalProductPrice, 150);
    });

    test('deliveryPrice depends on method', () {
      expect(provider.deliveryPrice, 2); // default is delivery
      provider.setDeliveryMethod('pickup');
      expect(provider.deliveryPrice, 0);
    });

    test('buyerProtectionFee is 2 when cart not empty', () {
      provider.addItem({'priceNum': '100'});
      expect(provider.buyerProtectionFee, 2);
    });

    test('totalPrice combines all', () {
      provider.addItem({'priceNum': '100'});
      // 100 + 2 (delivery) + 2 (protection) = 104
      expect(provider.totalPrice, 104);
    });

    test('setPaymentMethod updates', () {
      provider.setPaymentMethod('cash');
      expect(provider.paymentMethod, 'cash');
    });

    test('clear empties cart', () {
      provider.addItem({'priceNum': '100'});
      provider.clear();
      expect(provider.items, isEmpty);
      expect(provider.totalProductPrice, 0);
    });

    test('notifies listeners on changes', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.addItem({'priceNum': '10'});
      provider.setDeliveryMethod('pickup');
      provider.removeItem(0);
      expect(count, 3);
    });

    test('setDeliveryMethod skips notify when unchanged', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.setDeliveryMethod('delivery'); // already 'delivery'
      expect(count, 0);
    });

    test('setPaymentMethod skips notify when unchanged', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.setPaymentMethod('card'); // already 'card'
      expect(count, 0);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/enums.dart';
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
      provider.addItem(const CartItem(title: 'Test', price: '100 €', priceNum: 100, imageAsset: ''));
      expect(provider.items.length, 1);
    });

    test('removeItem removes from list', () {
      provider.addItem(const CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: ''));
      provider.addItem(const CartItem(title: 'B', price: '200 €', priceNum: 200, imageAsset: ''));
      provider.removeItem(0);
      expect(provider.items.length, 1);
      expect(provider.totalProductPrice, 200);
    });

    test('totalProductPrice sums correctly', () {
      provider.addItem(const CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: ''));
      provider.addItem(const CartItem(title: 'B', price: '50 €', priceNum: 50, imageAsset: ''));
      expect(provider.totalProductPrice, 150);
    });

    test('deliveryPrice depends on method', () {
      expect(provider.deliveryPrice, 2); // default is address
      provider.setDeliveryMethod(DeliveryMethod.pickup);
      expect(provider.deliveryPrice, 0);
    });

    test('buyerProtectionFee is 2 when cart not empty', () {
      provider.addItem(const CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: ''));
      expect(provider.buyerProtectionFee, 2);
    });

    test('totalPrice combines all', () {
      provider.addItem(const CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: ''));
      // 100 + 2 (delivery) + 2 (protection) = 104
      expect(provider.totalPrice, 104);
    });

    test('setPaymentMethod updates', () {
      provider.setPaymentMethod(PaymentMethod.applePay);
      expect(provider.paymentMethod, PaymentMethod.applePay);
    });

    test('clear empties cart', () {
      provider.addItem(const CartItem(title: 'A', price: '100 €', priceNum: 100, imageAsset: ''));
      provider.clear();
      expect(provider.items, isEmpty);
      expect(provider.totalProductPrice, 0);
    });

    test('notifies listeners on changes', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.addItem(const CartItem(title: 'A', price: '10 €', priceNum: 10, imageAsset: ''));
      provider.setDeliveryMethod(DeliveryMethod.pickup);
      provider.removeItem(0);
      expect(count, 3);
    });

    test('setDeliveryMethod skips notify when unchanged', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.setDeliveryMethod(DeliveryMethod.address); // already address
      expect(count, 0);
    });

    test('setPaymentMethod skips notify when unchanged', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.setPaymentMethod(PaymentMethod.card); // already card
      expect(count, 0);
    });
  });
}

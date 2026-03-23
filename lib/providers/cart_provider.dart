import 'package:flutter/foundation.dart';
import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/enums.dart';
import 'package:eqqu/services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  DeliveryMethod _deliveryMethod = DeliveryMethod.address;
  PaymentMethod _paymentMethod = PaymentMethod.card;

  List<CartItem> get items => List.unmodifiable(_items);
  DeliveryMethod get deliveryMethod => _deliveryMethod;
  PaymentMethod get paymentMethod => _paymentMethod;

  int get totalProductPrice => CartService.totalProductPrice(_items);
  int get deliveryPrice => CartService.deliveryPrice(_deliveryMethod);
  int get buyerProtectionFee => CartService.buyerProtectionFee(_items);
  int get totalPrice => CartService.totalPrice(_items, _deliveryMethod);

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void setDeliveryMethod(DeliveryMethod method) {
    if (_deliveryMethod == method) return;
    _deliveryMethod = method;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    if (_paymentMethod == method) return;
    _paymentMethod = method;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

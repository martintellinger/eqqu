import 'package:flutter/foundation.dart';
import 'package:eqqu/services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, String>> _items = [];
  String _deliveryMethod = 'delivery';
  String _paymentMethod = 'card';

  List<Map<String, String>> get items => List.unmodifiable(_items);
  String get deliveryMethod => _deliveryMethod;
  String get paymentMethod => _paymentMethod;

  int get totalProductPrice => CartService.totalProductPrice(_items);
  int get deliveryPrice => CartService.deliveryPrice(_deliveryMethod);
  int get buyerProtectionFee => CartService.buyerProtectionFee(_items);
  int get totalPrice => CartService.totalPrice(_items, _deliveryMethod);

  void addItem(Map<String, String> item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void setDeliveryMethod(String method) {
    _deliveryMethod = method;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _paymentMethod = method;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

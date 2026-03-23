import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/enums.dart';

class CartService {
  CartService._();

  static int totalProductPrice(List<CartItem> items) {
    int total = 0;
    for (final item in items) {
      total += item.priceNum;
    }
    return total;
  }

  static int deliveryPrice(DeliveryMethod method) {
    return method == DeliveryMethod.pickup ? 0 : 2;
  }

  static int buyerProtectionFee(List<CartItem> items) {
    return items.isNotEmpty ? 2 : 0;
  }

  static int totalPrice(List<CartItem> items, DeliveryMethod deliveryMethod) {
    return totalProductPrice(items) +
        deliveryPrice(deliveryMethod) +
        buyerProtectionFee(items);
  }
}

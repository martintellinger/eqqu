class CartService {
  CartService._();

  static int totalProductPrice(List<Map<String, String>> items) {
    int total = 0;
    for (final item in items) {
      total += int.tryParse(item['priceNum'] ?? '0') ?? 0;
    }
    return total;
  }

  static int deliveryPrice(String method) {
    return method == 'pickup' ? 0 : 2;
  }

  static int buyerProtectionFee(List<Map<String, String>> items) {
    return items.isNotEmpty ? 2 : 0;
  }

  static int totalPrice(List<Map<String, String>> items, String deliveryMethod) {
    return totalProductPrice(items) +
        deliveryPrice(deliveryMethod) +
        buyerProtectionFee(items);
  }
}

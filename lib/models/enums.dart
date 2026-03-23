/// Delivery method for orders.
enum DeliveryMethod {
  address,
  pickup;

  String get label {
    switch (this) {
      case DeliveryMethod.address:
        return 'address';
      case DeliveryMethod.pickup:
        return 'pickup';
    }
  }

  static DeliveryMethod fromString(String value) {
    return DeliveryMethod.values.firstWhere(
      (e) => e.name == value,
      orElse: () => DeliveryMethod.address,
    );
  }
}

/// Payment method for orders.
enum PaymentMethod {
  card,
  applePay,
  googlePay;

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PaymentMethod.card,
    );
  }
}

/// Status for purchase orders.
enum OrderStatus {
  active,
  completed,
  cancelled;

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OrderStatus.active,
    );
  }
}

/// Status for sale orders.
enum SaleStatus {
  newOrder,
  processed,
  shipped,
  delivered,
  paidOut;

  static SaleStatus fromString(String value) {
    const map = {
      'new': SaleStatus.newOrder,
      'processed': SaleStatus.processed,
      'shipped': SaleStatus.shipped,
      'delivered': SaleStatus.delivered,
      'paid_out': SaleStatus.paidOut,
    };
    return map[value] ?? SaleStatus.newOrder;
  }

  String toJson() {
    const map = {
      SaleStatus.newOrder: 'new',
      SaleStatus.processed: 'processed',
      SaleStatus.shipped: 'shipped',
      SaleStatus.delivered: 'delivered',
      SaleStatus.paidOut: 'paid_out',
    };
    return map[this]!;
  }
}

/// Status for product listings.
enum ListingStatus {
  active,
  sold,
  shipped;

  static ListingStatus fromString(String value) {
    return ListingStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ListingStatus.active,
    );
  }
}

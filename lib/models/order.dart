import 'package:eqqu/models/enums.dart';

class PurchaseOrder {
  final String id;
  final String date;
  final OrderStatus status;
  final String price;
  final List<String> images;

  const PurchaseOrder({
    required this.id,
    required this.date,
    required this.status,
    required this.price,
    required this.images,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => PurchaseOrder(
    id: json['id'] as String? ?? '',
    date: json['date'] as String? ?? '',
    status: OrderStatus.fromString(json['status'] as String? ?? ''),
    price: json['price'] as String? ?? '',
    images: (json['images'] as List?)?.cast<String>() ?? [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'status': status.name,
    'price': price,
    'images': images,
  };
}

class SaleOrder {
  final String id;
  final String date;
  final SaleStatus status;
  final String price;
  final List<String> images;

  const SaleOrder({
    required this.id,
    required this.date,
    required this.status,
    required this.price,
    required this.images,
  });

  factory SaleOrder.fromJson(Map<String, dynamic> json) => SaleOrder(
    id: json['id'] as String? ?? '',
    date: json['date'] as String? ?? '',
    status: SaleStatus.fromString(json['status'] as String? ?? ''),
    price: json['price'] as String? ?? '',
    images: (json['images'] as List?)?.cast<String>() ?? [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'status': status.toJson(),
    'price': price,
    'images': images,
  };
}

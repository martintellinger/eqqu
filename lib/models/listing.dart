import 'package:eqqu/models/enums.dart';
import 'package:eqqu/models/product.dart';

class Listing {
  final String id;
  final Product product;
  final ListingStatus status;

  const Listing({
    required this.id,
    required this.product,
    required this.status,
  });

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
    id: json['id'] as String? ?? '',
    product: Product.fromJson(json['product'] as Map<String, dynamic>? ?? {}),
    status: ListingStatus.fromString(json['status'] as String? ?? ''),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product': product.toJson(),
    'status': status.name,
  };
}

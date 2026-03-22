import 'package:eqqu/models/product.dart';

class Listing {
  final String id;
  final Product product;
  final String status; // 'active', 'sold', 'shipped'

  const Listing({
    required this.id,
    required this.product,
    required this.status,
  });
}

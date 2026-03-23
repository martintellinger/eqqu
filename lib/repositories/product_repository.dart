import 'package:eqqu/models/product.dart';

/// Abstract contract for product data access.
///
/// When a real backend is ready, implement this interface with an
/// [ApiProductRepository] that fetches from the API. The UI layer
/// (providers, screens) depends only on this interface.
abstract class ProductRepository {
  /// Fetch the full product catalogue.
  Future<List<Product>> getAllProducts();

  /// Fetch products for a specific seller.
  Future<List<Product>> getSellerProducts(String sellerId);

  /// Fetch a single product by its ID.
  Future<Product?> getProductById(String productId);

  /// Search products by [query] with optional [brand] filter.
  Future<List<Product>> searchProducts({String query = '', String? brand});
}

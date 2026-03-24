import 'package:eqqu/models/product.dart';
import 'package:eqqu/models/result.dart';

/// Abstract contract for product data access.
///
/// When a real backend is ready, implement this interface with an
/// [ApiProductRepository] that fetches from the API. The UI layer
/// (providers, screens) depends only on this interface.
abstract class ProductRepository {
  /// Fetch the full product catalogue.
  Future<Result<List<Product>>> getAllProducts();

  /// Fetch products for a specific seller.
  Future<Result<List<Product>>> getSellerProducts(String sellerId);

  /// Fetch a single product by its ID.
  Future<Result<Product?>> getProductById(String productId);

  /// Search products by [query] with optional [brand] filter.
  Future<Result<List<Product>>> searchProducts({String query = '', String? brand});
}

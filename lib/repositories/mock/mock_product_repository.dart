import 'package:eqqu/data/mock_products.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/repositories/product_repository.dart';
import 'package:eqqu/services/search_service.dart';

/// In-memory mock implementation of [ProductRepository].
///
/// Returns hardcoded data from [MockProducts]. Swap this for an
/// [ApiProductRepository] when the backend is ready.
class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getAllProducts() async {
    return MockProducts.allProducts;
  }

  @override
  Future<List<Product>> getSellerProducts(String sellerId) async {
    return MockProducts.sellerProducts;
  }

  @override
  Future<Product?> getProductById(String productId) async {
    final index = int.tryParse(productId);
    if (index == null || index < 0 || index >= MockProducts.allProducts.length) {
      return null;
    }
    return MockProducts.allProducts[index];
  }

  @override
  Future<List<Product>> searchProducts({String query = '', String? brand}) async {
    return SearchService.filterProducts(
      MockProducts.allProducts,
      brandChip: brand,
      query: query,
    );
  }
}

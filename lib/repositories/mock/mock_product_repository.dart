import 'package:eqqu/data/mock_products.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/models/result.dart';
import 'package:eqqu/repositories/product_repository.dart';
import 'package:eqqu/services/search_service.dart';

/// In-memory mock implementation of [ProductRepository].
///
/// Returns hardcoded data from [MockProducts]. Swap this for an
/// [ApiProductRepository] when the backend is ready.
class MockProductRepository implements ProductRepository {
  @override
  Future<Result<List<Product>>> getAllProducts() async {
    return const Success(MockProducts.allProducts);
  }

  @override
  Future<Result<List<Product>>> getSellerProducts(String sellerId) async {
    return const Success(MockProducts.sellerProducts);
  }

  @override
  Future<Result<Product?>> getProductById(String productId) async {
    final index = int.tryParse(productId);
    if (index == null || index < 0 || index >= MockProducts.allProducts.length) {
      return const Success(null);
    }
    return Success(MockProducts.allProducts[index]);
  }

  @override
  Future<Result<List<Product>>> searchProducts({String query = '', String? brand}) async {
    return Success(SearchService.filterProducts(
      MockProducts.allProducts,
      brandChip: brand,
      query: query,
    ));
  }
}

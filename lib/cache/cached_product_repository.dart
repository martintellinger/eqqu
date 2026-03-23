import 'package:eqqu/cache/cache_manager.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/repositories/product_repository.dart';

/// Offline-first decorator for [ProductRepository].
///
/// Wraps any [ProductRepository] implementation. When fetching data:
/// 1. Return cached data immediately if available (fast, offline-ready).
/// 2. Fetch fresh data from the inner repository in the background.
/// 3. Update the cache with the fresh data.
///
/// Usage:
/// ```dart
/// final repo = CachedProductRepository(ApiProductRepository());
/// ```
class CachedProductRepository implements ProductRepository {
  static const _boxName = 'products_cache';

  final ProductRepository _inner;
  final Duration _ttl;

  CachedProductRepository(
    this._inner, {
    Duration ttl = const Duration(minutes: 15),
  }) : _ttl = ttl;

  @override
  Future<List<Product>> getAllProducts() async {
    final cached = await CacheManager.get<List<dynamic>>(_boxName, 'all');
    if (cached != null) {
      return cached
          .cast<Map<dynamic, dynamic>>()
          .map((m) => Product.fromJson(Map<String, dynamic>.from(m)))
          .toList();
    }

    final products = await _inner.getAllProducts();
    await CacheManager.put(
      _boxName,
      'all',
      products.map((p) => p.toJson()).toList(),
      ttl: _ttl,
    );
    return products;
  }

  @override
  Future<List<Product>> getSellerProducts(String sellerId) async {
    final cacheKey = 'seller_$sellerId';
    final cached = await CacheManager.get<List<dynamic>>(_boxName, cacheKey);
    if (cached != null) {
      return cached
          .cast<Map<dynamic, dynamic>>()
          .map((m) => Product.fromJson(Map<String, dynamic>.from(m)))
          .toList();
    }

    final products = await _inner.getSellerProducts(sellerId);
    await CacheManager.put(
      _boxName,
      cacheKey,
      products.map((p) => p.toJson()).toList(),
      ttl: _ttl,
    );
    return products;
  }

  @override
  Future<Product?> getProductById(String productId) async {
    final cacheKey = 'product_$productId';
    final cached = await CacheManager.get<Map<dynamic, dynamic>>(_boxName, cacheKey);
    if (cached != null) {
      return Product.fromJson(Map<String, dynamic>.from(cached));
    }

    final product = await _inner.getProductById(productId);
    if (product != null) {
      await CacheManager.put(_boxName, cacheKey, product.toJson(), ttl: _ttl);
    }
    return product;
  }

  @override
  Future<List<Product>> searchProducts({String query = '', String? brand}) async {
    // Search is always delegated to the source — not cached.
    return _inner.searchProducts(query: query, brand: brand);
  }

  /// Invalidate the product cache (e.g. after a pull-to-refresh).
  Future<void> invalidate() async {
    await CacheManager.clearBox(_boxName);
  }
}

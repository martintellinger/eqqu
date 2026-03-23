import 'package:eqqu/repositories/auth_repository.dart';
import 'package:eqqu/repositories/cart_repository.dart';
import 'package:eqqu/repositories/favorites_repository.dart';
import 'package:eqqu/repositories/product_repository.dart';
import 'package:eqqu/repositories/mock/mock_auth_repository.dart';
import 'package:eqqu/repositories/mock/mock_cart_repository.dart';
import 'package:eqqu/repositories/mock/mock_favorites_repository.dart';
import 'package:eqqu/repositories/mock/mock_product_repository.dart';

/// Central place to obtain repository instances.
///
/// Currently returns mock implementations. When the backend is ready,
/// swap the mock constructors for API-backed ones — all consumers
/// depend only on the abstract interfaces, so nothing else changes.
class RepositoryProvider {
  RepositoryProvider._();

  static final ProductRepository products = MockProductRepository();
  static final FavoritesRepository favorites = MockFavoritesRepository();
  static final CartRepository cart = MockCartRepository();
  static final AuthRepository auth = MockAuthRepository();
}

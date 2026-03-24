import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/result.dart';

/// Abstract contract for shopping cart data access.
///
/// Replace the mock implementation with an API-backed one when the
/// backend supports server-side cart management.
abstract class CartRepository {
  /// Load saved cart items.
  Future<Result<List<CartItem>>> loadCart();

  /// Persist the current cart state.
  Future<Result<void>> saveCart(List<CartItem> items);

  /// Clear persisted cart.
  Future<Result<void>> clearCart();
}

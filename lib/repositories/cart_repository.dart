/// Abstract contract for shopping cart data access.
///
/// Replace the mock implementation with an API-backed one when the
/// backend supports server-side cart management.
abstract class CartRepository {
  /// Load saved cart items.
  Future<List<Map<String, String>>> loadCart();

  /// Persist the current cart state.
  Future<void> saveCart(List<Map<String, String>> items);

  /// Clear persisted cart.
  Future<void> clearCart();
}

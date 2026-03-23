import 'package:eqqu/repositories/cart_repository.dart';

/// In-memory mock implementation of [CartRepository].
///
/// Cart state is held in memory and lost on app restart.
class MockCartRepository implements CartRepository {
  List<Map<String, String>> _items = [];

  @override
  Future<List<Map<String, String>>> loadCart() async {
    return List.of(_items);
  }

  @override
  Future<void> saveCart(List<Map<String, String>> items) async {
    _items = List.of(items);
  }

  @override
  Future<void> clearCart() async {
    _items.clear();
  }
}

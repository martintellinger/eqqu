import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/result.dart';
import 'package:eqqu/repositories/cart_repository.dart';

/// In-memory mock implementation of [CartRepository].
///
/// Cart state is held in memory and lost on app restart.
class MockCartRepository implements CartRepository {
  List<CartItem> _items = [];

  @override
  Future<Result<List<CartItem>>> loadCart() async {
    return Success(List.of(_items));
  }

  @override
  Future<Result<void>> saveCart(List<CartItem> items) async {
    _items = List.of(items);
    return const Success(null);
  }

  @override
  Future<Result<void>> clearCart() async {
    _items.clear();
    return const Success(null);
  }
}

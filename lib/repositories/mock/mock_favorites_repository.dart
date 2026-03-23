import 'package:eqqu/repositories/favorites_repository.dart';

/// In-memory mock implementation of [FavoritesRepository].
///
/// Starts with items 0–7 pre-favorited. Nothing is persisted to disk.
class MockFavoritesRepository implements FavoritesRepository {
  Set<int> _favorites = {0, 1, 2, 3, 4, 5, 6, 7};

  @override
  Future<Set<int>> loadFavorites() async {
    return Set.of(_favorites);
  }

  @override
  Future<void> saveFavorites(Set<int> favorites) async {
    _favorites = Set.of(favorites);
  }
}

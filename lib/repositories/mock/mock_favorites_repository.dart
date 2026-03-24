import 'package:eqqu/models/result.dart';
import 'package:eqqu/repositories/favorites_repository.dart';

/// In-memory mock implementation of [FavoritesRepository].
///
/// Starts with items 0–7 pre-favorited. Nothing is persisted to disk.
class MockFavoritesRepository implements FavoritesRepository {
  Set<int> _favorites = {0, 1, 2, 3, 4, 5, 6, 7};

  @override
  Future<Result<Set<int>>> loadFavorites() async {
    return Success(Set.of(_favorites));
  }

  @override
  Future<Result<void>> saveFavorites(Set<int> favorites) async {
    _favorites = Set.of(favorites);
    return const Success(null);
  }
}

/// Abstract contract for favorites data access.
///
/// Replace the mock implementation with an API-backed one when the
/// backend supports persisting user favorites.
abstract class FavoritesRepository {
  /// Load favorite product indices for the current user.
  Future<Set<int>> loadFavorites();

  /// Persist the updated favorites set.
  Future<void> saveFavorites(Set<int> favorites);
}

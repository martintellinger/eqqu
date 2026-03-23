import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favorites = {};

  Set<int> get favorites => Set.unmodifiable(_favorites);

  bool isFavorite(int index) => _favorites.contains(index);

  void toggle(int index) {
    if (_favorites.contains(index)) {
      _favorites.remove(index);
    } else {
      _favorites.add(index);
    }
    notifyListeners();
  }

  void clear() {
    _favorites.clear();
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/services/search_service.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';
  bool _isSearching = false;
  String? _activeChip;
  Map<String, String> _activeFilters = {};

  String get query => _query;
  bool get isSearching => _isSearching;
  String? get activeChip => _activeChip;
  Map<String, String> get activeFilters => Map.unmodifiable(_activeFilters);

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  void setActiveChip(String? chip) {
    _activeChip = chip;
    notifyListeners();
  }

  void setFilters(Map<String, String> filters) {
    _activeFilters = filters;
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    _isSearching = false;
    notifyListeners();
  }

  List<Product> filteredProducts(List<Product> allProducts) {
    return SearchService.filterProducts(
      allProducts,
      brandChip: _activeChip,
      query: _query,
    );
  }

  List<Map<String, String>> filteredUsers(List<Map<String, String>> users) {
    return SearchService.filterUsers(users, _query, isSearching: _isSearching);
  }

  List<String> filteredSuggestions(List<String> suggestions) {
    return SearchService.filterSuggestions(suggestions, _query);
  }
}

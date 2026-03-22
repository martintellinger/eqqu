import 'package:eqqu/models/product.dart';

class SearchService {
  SearchService._();

  static int searchRelevance(Product product, String query) {
    final title = product.title.toLowerCase();
    final brand = product.brand.toLowerCase();
    if (title.startsWith(query) || brand.startsWith(query)) {
      return 0;
    }
    final titleWords = title.split(RegExp(r'\s+'));
    final brandWords = brand.split(RegExp(r'\s+'));
    if (titleWords.any((w) => w.startsWith(query)) ||
        brandWords.any((w) => w.startsWith(query))) {
      return 1;
    }
    if (title.contains(query) || brand.contains(query)) {
      return 2;
    }
    if (product.category.toLowerCase().contains(query)) {
      return 3;
    }
    return 4;
  }

  static List<Product> filterProducts(
    List<Product> products, {
    String? brandChip,
    String query = '',
  }) {
    var result = products;
    if (brandChip != null) {
      result = result.where((p) => p.brand == brandChip).toList();
    }
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      result = result
          .where((p) =>
              p.title.toLowerCase().contains(q) ||
              p.subtitle.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q))
          .toList();
      result.sort(
          (a, b) => searchRelevance(a, q).compareTo(searchRelevance(b, q)));
    }
    return result;
  }

  static List<Map<String, String>> filterUsers(
    List<Map<String, String>> users,
    String query, {
    bool isSearching = false,
  }) {
    if (!isSearching && query.isEmpty) return [];
    if (query.isEmpty) return users;
    final q = query.toLowerCase();
    return users
        .where((u) =>
            u['name']!.toLowerCase().contains(q) ||
            u['username']!.toLowerCase().contains(q))
        .toList();
  }

  static List<String> filterSuggestions(
    List<String> suggestions,
    String query, {
    int limit = 5,
  }) {
    if (query.isEmpty) return suggestions.take(limit).toList();
    final q = query.toLowerCase();
    return suggestions
        .where((s) => s.toLowerCase().contains(q))
        .take(limit)
        .toList();
  }
}

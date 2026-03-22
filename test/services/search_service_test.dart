import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/services/search_service.dart';

void main() {
  final products = [
    const Product(
      title: 'Black GP Saddle',
      subtitle: 'Prestige / Used / 17"',
      oldPrice: '800 €',
      newPrice: '650 €',
      brand: 'Prestige',
      category: 'Saddles',
    ),
    const Product(
      title: 'Fleece Bandages',
      subtitle: 'Kentucky / New / One size',
      oldPrice: '35 €',
      newPrice: '42 €',
      brand: 'Kentucky',
      category: 'Accessories',
    ),
    const Product(
      title: 'Prestige Bridle',
      subtitle: 'Prestige / Good / Full',
      oldPrice: '120 €',
      newPrice: '90 €',
      brand: 'Prestige',
      category: 'Bridles',
    ),
  ];

  group('SearchService.searchRelevance', () {
    test('returns 0 for title starting with query', () {
      expect(SearchService.searchRelevance(products[0], 'black'), 0);
    });

    test('returns 0 for brand starting with query', () {
      expect(SearchService.searchRelevance(products[0], 'prestige'), 0);
    });

    test('returns 1 for word starting with query', () {
      expect(SearchService.searchRelevance(products[0], 'saddle'), 1);
    });

    test('returns 1 for word starting with query', () {
      // "gp" matches word "gp" in "black gp saddle"
      expect(SearchService.searchRelevance(products[0], 'gp'), 1);
    });

    test('returns 3 for category match', () {
      expect(SearchService.searchRelevance(products[0], 'saddles'), 3);
    });

    test('returns 4 for no match', () {
      expect(SearchService.searchRelevance(products[0], 'xyz'), 4);
    });
  });

  group('SearchService.filterProducts', () {
    test('returns all products with no filters', () {
      final result = SearchService.filterProducts(products);
      expect(result.length, 3);
    });

    test('filters by brand chip', () {
      final result = SearchService.filterProducts(products, brandChip: 'Prestige');
      expect(result.length, 2);
      expect(result.every((p) => p.brand == 'Prestige'), isTrue);
    });

    test('filters by query', () {
      final result = SearchService.filterProducts(products, query: 'bandage');
      expect(result.length, 1);
      expect(result.first.title, 'Fleece Bandages');
    });

    test('filters by brand chip and query together', () {
      final result = SearchService.filterProducts(
        products,
        brandChip: 'Prestige',
        query: 'bridle',
      );
      expect(result.length, 1);
      expect(result.first.title, 'Prestige Bridle');
    });

    test('returns empty for no matches', () {
      final result = SearchService.filterProducts(products, query: 'xyz');
      expect(result, isEmpty);
    });

    test('sorts by relevance', () {
      final result = SearchService.filterProducts(products, query: 'prestige');
      // First two should be Prestige brand (relevance 0), saddle first alphabetically by title
      expect(result.length, 2);
      expect(result.every((p) => p.brand == 'Prestige'), isTrue);
    });
  });

  group('SearchService.filterUsers', () {
    final users = [
      {'name': 'Emma Novak', 'username': '@emma'},
      {'name': 'Jan Novotný', 'username': '@jan'},
    ];

    test('returns empty when not searching', () {
      expect(SearchService.filterUsers(users, ''), isEmpty);
    });

    test('returns all when searching with empty query', () {
      expect(SearchService.filterUsers(users, '', isSearching: true).length, 2);
    });

    test('filters by name', () {
      final result = SearchService.filterUsers(users, 'emma');
      expect(result.length, 1);
      expect(result.first['name'], 'Emma Novak');
    });

    test('filters by username', () {
      final result = SearchService.filterUsers(users, '@jan');
      expect(result.length, 1);
    });
  });

  group('SearchService.filterSuggestions', () {
    final suggestions = ['saddle', 'bridle', 'bandage', 'blanket', 'boots', 'bell'];

    test('returns first 5 with empty query', () {
      final result = SearchService.filterSuggestions(suggestions, '');
      expect(result.length, 5);
    });

    test('filters by query', () {
      final result = SearchService.filterSuggestions(suggestions, 'b');
      expect(result.length, 5); // bridle, bandage, blanket, boots, bell
    });

    test('respects limit', () {
      final result = SearchService.filterSuggestions(suggestions, '', limit: 3);
      expect(result.length, 3);
    });
  });
}

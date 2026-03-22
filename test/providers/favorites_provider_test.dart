import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/providers/favorites_provider.dart';

void main() {
  group('FavoritesProvider', () {
    late FavoritesProvider provider;

    setUp(() {
      provider = FavoritesProvider();
    });

    test('starts pre-populated with indices 0-7', () {
      expect(provider.favorites, {0, 1, 2, 3, 4, 5, 6, 7});
    });

    test('toggle removes pre-populated item', () {
      provider.toggle(1);
      expect(provider.isFavorite(1), isFalse);
    });

    test('toggle re-adds removed item', () {
      provider.toggle(1);
      provider.toggle(1);
      expect(provider.isFavorite(1), isTrue);
    });

    test('toggle adds new item', () {
      provider.toggle(99);
      expect(provider.isFavorite(99), isTrue);
    });

    test('isFavorite returns false for unknown', () {
      expect(provider.isFavorite(99), isFalse);
    });

    test('clear removes all', () {
      provider.clear();
      expect(provider.favorites, isEmpty);
    });

    test('notifies listeners on toggle', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.toggle(1);
      expect(count, 1);
      provider.toggle(1);
      expect(count, 2);
    });

    test('notifies listeners on clear', () {
      int count = 0;
      provider.addListener(() => count++);
      provider.toggle(1);
      provider.clear();
      expect(count, 2);
    });
  });
}

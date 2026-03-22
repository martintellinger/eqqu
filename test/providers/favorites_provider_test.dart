import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/providers/favorites_provider.dart';

void main() {
  group('FavoritesProvider', () {
    late FavoritesProvider provider;

    setUp(() {
      provider = FavoritesProvider();
    });

    test('starts empty', () {
      expect(provider.favorites, isEmpty);
    });

    test('toggle adds item', () {
      provider.toggle(1);
      expect(provider.isFavorite(1), isTrue);
    });

    test('toggle removes item', () {
      provider.toggle(1);
      provider.toggle(1);
      expect(provider.isFavorite(1), isFalse);
    });

    test('isFavorite returns false for unknown', () {
      expect(provider.isFavorite(99), isFalse);
    });

    test('clear removes all', () {
      provider.toggle(1);
      provider.toggle(2);
      provider.toggle(3);
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

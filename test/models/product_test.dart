import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/models/product.dart';

void main() {
  group('Product', () {
    const product = Product(
      title: 'Black GP Saddle',
      subtitle: 'Prestige / Used / 17"',
      oldPrice: '800 €',
      newPrice: '650 €',
      brand: 'Prestige',
      category: 'Saddles',
    );

    test('parsedBrand extracts first part of subtitle', () {
      expect(product.parsedBrand, 'Prestige');
    });

    test('parsedCondition extracts second part of subtitle', () {
      expect(product.parsedCondition, 'Used');
    });

    test('parsedCondition returns empty for single-part subtitle', () {
      const p = Product(
        title: 'Test',
        subtitle: 'NoParts',
        oldPrice: '0',
        newPrice: '0',
      );
      expect(p.parsedCondition, '');
    });

    test('toMap returns correct map', () {
      final map = product.toMap();
      expect(map['title'], 'Black GP Saddle');
      expect(map['subtitle'], 'Prestige / Used / 17"');
      expect(map['brand'], 'Prestige');
      expect(map['category'], 'Saddles');
    });

    test('toMap excludes empty optional fields', () {
      const p = Product(
        title: 'Test',
        subtitle: 'Sub',
        oldPrice: '0',
        newPrice: '0',
      );
      final map = p.toMap();
      expect(map.containsKey('image'), isFalse);
      expect(map.containsKey('brand'), isFalse);
    });
  });
}

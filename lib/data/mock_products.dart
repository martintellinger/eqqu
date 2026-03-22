import 'package:eqqu/models/product.dart';

/// Centralised mock product data used across multiple screens.
///
/// Only lists that were duplicated in two or more screen files are kept here.
/// Screen-specific lists that appear in a single file remain in place.
class MockProducts {
  MockProducts._();

  /// Products shown on seller profile pages.
  ///
  /// Used by both [BuyerViewSellerScreen] and [SellerProfileScreen].
  static const sellerProducts = [
    Product(title: 'Black GP type saddle', subtitle: 'No brand / Good / 17"', oldPrice: '140 €', newPrice: '159 €', imageAsset: 'assets/images/product_01.png'),
    Product(title: 'Blue Comfort type saddle', subtitle: 'Shires / New / Cob', oldPrice: '42 €', newPrice: '49 €', imageAsset: 'assets/images/product_02.png'),
    Product(title: 'Black GP type saddle', subtitle: 'No brand / Good / 17"', oldPrice: '140 €', newPrice: '159 €', imageAsset: 'assets/images/product_03.png'),
    Product(title: 'Blue Comfort type saddle', subtitle: 'Comfy Brand / Fair / 18"', oldPrice: '120 €', newPrice: '135 €', imageAsset: 'assets/images/product_04.png'),
  ];

  /// Full product catalogue used for the home screen grid and search.
  ///
  /// These include [brand] and [category] fields for filtering.
  static const allProducts = [
    Product(title: 'Black GP type saddle', subtitle: 'No brand / Good / 17"', oldPrice: '140 €', newPrice: '159 €', brand: 'No brand', category: 'Sedla'),
    Product(title: 'Blue Comfort type saddle', subtitle: 'Comfy Brand / Fair / 18"', oldPrice: '120 €', newPrice: '135 €', brand: 'Comfy Brand', category: 'Sedla'),
    Product(title: 'Red Racing type saddle', subtitle: 'Speedy Brand / Excellent / 15"', oldPrice: '200 €', newPrice: '230 €', brand: 'Cavalleria Toscana', category: 'Sedla'),
    Product(title: 'Green Mountain type saddle', subtitle: 'Rugged Brand / Very Good / 16"', oldPrice: '180 €', newPrice: '199 €', brand: 'Animo', category: 'Sedla'),
    Product(title: 'White Cruiser type saddle', subtitle: 'Cruiser Co. / Fair / 19"', oldPrice: '160 €', newPrice: '175 €', brand: 'Kingsland', category: 'Sedla'),
    Product(title: 'Shires Velociti bridle', subtitle: 'Shires / New / Cob', oldPrice: '42 €', newPrice: '49 €', brand: 'Shires', category: 'Uzdečky'),
    Product(title: 'Fleece bandáže Kentucky', subtitle: 'Kentucky / New / One size', oldPrice: '35 €', newPrice: '42 €', brand: 'Kingsland', category: 'Kamaše'),
    Product(title: 'Deka Eskadron Classic', subtitle: 'Eskadron / Very Good / 145cm', oldPrice: '95 €', newPrice: '110 €', brand: 'Animo', category: 'Deky'),
    Product(title: 'Třmeny Flex-On', subtitle: 'Flex-On / Excellent / Standard', oldPrice: '280 €', newPrice: '320 €', brand: 'Cavalleria Toscana', category: 'Třmeny'),
    Product(title: 'Podsedlová dečka Animo', subtitle: 'Animo / New / Drezúra', oldPrice: '55 €', newPrice: '65 €', brand: 'Animo', category: 'Sedla'),
  ];

  /// Subset of [allProducts] without brand/category, used in the favorites
  /// screen and anywhere a simple product list is needed.
  static const favoriteProducts = [
    Product(title: 'Black GP type saddle', subtitle: 'No brand / Good / 17"', oldPrice: '140 €', newPrice: '159 €'),
    Product(title: 'Blue Comfort type saddle', subtitle: 'Comfy Brand / Fair / 18"', oldPrice: '120 €', newPrice: '135 €'),
    Product(title: 'Red Racing type saddle', subtitle: 'Speedy Brand / Excellent / 15"', oldPrice: '200 €', newPrice: '230 €'),
    Product(title: 'Green Mountain type saddle', subtitle: 'Rugged Brand / Very Good / 16"', oldPrice: '180 €', newPrice: '199 €'),
    Product(title: 'White Cruiser type saddle', subtitle: 'Cruiser Co. / Fair / 19"', oldPrice: '160 €', newPrice: '175 €'),
    Product(title: 'Shires Velociti bridle', subtitle: 'Shires / New / Cob', oldPrice: '42 €', newPrice: '49 €'),
    Product(title: 'Fleece bandáže Kentucky', subtitle: 'Kentucky / New / One size', oldPrice: '35 €', newPrice: '42 €'),
    Product(title: 'Deka Eskadron Classic', subtitle: 'Eskadron / Very Good / 145cm', oldPrice: '95 €', newPrice: '110 €'),
    Product(title: 'Třmeny Flex-On', subtitle: 'Flex-On / Excellent / Standard', oldPrice: '280 €', newPrice: '320 €'),
    Product(title: 'Podsedlová dečka Animo', subtitle: 'Animo / New / Drezúra', oldPrice: '55 €', newPrice: '65 €'),
  ];
}

class Product {
  final String title;
  final String subtitle;
  final String oldPrice;
  final String newPrice;
  final String imageAsset;
  final String brand;
  final String category;

  const Product({
    required this.title,
    required this.subtitle,
    required this.oldPrice,
    required this.newPrice,
    this.imageAsset = '',
    this.brand = '',
    this.category = '',
  });

  /// Extracts brand from subtitle format "Brand / Condition / Size".
  String get parsedBrand => subtitle.split(' / ').first;

  /// Extracts condition from subtitle format "Brand / Condition / Size".
  String get parsedCondition {
    final parts = subtitle.split(' / ');
    return parts.length > 1 ? parts[1] : '';
  }

  /// Convert to Map for backward compatibility with screens not yet refactored.
  Map<String, String> toMap() => {
    'title': title,
    'subtitle': subtitle,
    'oldPrice': oldPrice,
    'newPrice': newPrice,
    if (imageAsset.isNotEmpty) 'image': imageAsset,
    if (brand.isNotEmpty) 'brand': brand,
    if (category.isNotEmpty) 'category': category,
  };
}

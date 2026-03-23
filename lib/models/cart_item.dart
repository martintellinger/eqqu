class CartItem {
  final String title;
  final String price;
  final int priceNum;
  final String imageAsset;

  const CartItem({
    required this.title,
    required this.price,
    required this.priceNum,
    required this.imageAsset,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    title: json['title'] as String? ?? '',
    price: json['price'] as String? ?? '',
    priceNum: json['priceNum'] is int
        ? json['priceNum'] as int
        : int.tryParse('${json['priceNum']}') ?? 0,
    imageAsset: json['imageAsset'] as String? ?? json['image'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'price': price,
    'priceNum': priceNum,
    'imageAsset': imageAsset,
  };

  Map<String, String> toMap() => {
    'title': title,
    'price': price,
    'priceNum': '$priceNum',
    'image': imageAsset,
  };
}

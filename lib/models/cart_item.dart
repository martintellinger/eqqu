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

  Map<String, String> toMap() => {
    'title': title,
    'price': price,
    'priceNum': '$priceNum',
    'image': imageAsset,
  };
}

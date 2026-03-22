import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/animated_heart.dart';

const _productImages = [
  'assets/images/product_01.png',
  'assets/images/product_02.png',
  'assets/images/product_03.png',
  'assets/images/product_04.png',
  'assets/images/product_05.png',
  'assets/images/product_06.png',
  'assets/images/product_07.png',
  'assets/images/product_8.png',
  'assets/images/product_9.png',
  'assets/images/product_10.png',
];

class FavoritesScreen extends StatefulWidget {
  final bool showBack;

  const FavoritesScreen({super.key, this.showBack = true});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final Set<int> _favorites = {0, 1, 2, 3, 4, 5, 6, 7};

  static const _products = [
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
    },
    {
      'title': 'Blue Comfort type saddle',
      'subtitle': 'Comfy Brand / Fair / 18"',
      'oldPrice': '120 €',
      'newPrice': '135 €',
    },
    {
      'title': 'Red Racing type saddle',
      'subtitle': 'Speedy Brand / Excellent / 15"',
      'oldPrice': '200 €',
      'newPrice': '230 €',
    },
    {
      'title': 'Green Mountain type saddle',
      'subtitle': 'Rugged Brand / Very Good / 16"',
      'oldPrice': '180 €',
      'newPrice': '199 €',
    },
    {
      'title': 'White Cruiser type saddle',
      'subtitle': 'Cruiser Co. / Fair / 19"',
      'oldPrice': '160 €',
      'newPrice': '175 €',
    },
    {
      'title': 'Shires Velociti bridle',
      'subtitle': 'Shires / New / Cob',
      'oldPrice': '42 €',
      'newPrice': '49 €',
    },
    {
      'title': 'Fleece bandáže Kentucky',
      'subtitle': 'Kentucky / New / One size',
      'oldPrice': '35 €',
      'newPrice': '42 €',
    },
    {
      'title': 'Deka Eskadron Classic',
      'subtitle': 'Eskadron / Very Good / 145cm',
      'oldPrice': '95 €',
      'newPrice': '110 €',
    },
    {
      'title': 'Třmeny Flex-On',
      'subtitle': 'Flex-On / Excellent / Standard',
      'oldPrice': '280 €',
      'newPrice': '320 €',
    },
    {
      'title': 'Podsedlová dečka Animo',
      'subtitle': 'Animo / New / Drezúra',
      'oldPrice': '55 €',
      'newPrice': '65 €',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final favProducts = _products
        .asMap()
        .entries
        .where((e) => _favorites.contains(e.key))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            const SliverToBoxAdapter(
              child: AppHeader(title: 'Oblíbené', showBack: widget.showBack),
            ),

          // Product grid
          if (favProducts.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, rowIndex) {
                    final i = rowIndex * 2;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: rowIndex < (favProducts.length / 2).ceil() - 1 ? 16 : 0,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildProductCard(
                                cs,
                                favProducts[i].key,
                                favProducts[i].value,
                                _productImages[favProducts[i].key % _productImages.length],
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (i + 1 < favProducts.length)
                              Expanded(
                                child: _buildProductCard(
                                  cs,
                                  favProducts[i + 1].key,
                                  favProducts[i + 1].value,
                                  _productImages[favProducts[i + 1].key % _productImages.length],
                                ),
                              )
                            else
                              const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: (favProducts.length / 2).ceil(),
                ),
              ),
            ),

          if (favProducts.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.favorite_border, size: 64, color: cs.tertiary),
                      const SizedBox(height: 16),
                      Text(
                        'Zatím nemáte žádné oblíbené',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: cs.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
        ),
      ),
    );
  }


  Widget _buildProductCard(
    ColorScheme cs, int index, Map<String, String> product, String imagePath,
  ) {
    final isFav = _favorites.contains(index);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              brand: product['subtitle']!.split(' / ').first,
              name: product['title']!,
              condition: 'Used',
              price: product['newPrice']!,
              oldPrice: product['oldPrice']!,
              imageAsset: imagePath,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 177 / 200,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: AnimatedHeartButton(
                    isFavorite: isFav,
                    cs: cs,
                    onToggle: () => setState(() {
                      if (isFav) {
                        _favorites.remove(index);
                      } else {
                        _favorites.add(index);
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product['title']!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: cs.secondary,
              letterSpacing: 0.15,
              height: 24 / 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product['subtitle']!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cs.tertiary,
              letterSpacing: 0.25,
              height: 20 / 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          Row(
            children: [
              Text(
                '${product['oldPrice']}  ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: cs.tertiary,
                  letterSpacing: 0.4,
                  height: 16 / 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${product['newPrice']}  ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
                  letterSpacing: 0.5,
                  height: 24 / 16,
                ),
              ),
              Text(
                'vč.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.verified_user, size: 16, color: cs.surfaceTint),
            ],
          ),
        ],
      ),
    );
  }
}

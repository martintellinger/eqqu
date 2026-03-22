import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/product_card.dart';
import 'package:eqqu/theme/app_constants.dart';

class FavoritesScreen extends StatefulWidget {
  final bool showBack;

  const FavoritesScreen({super.key, this.showBack = true});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final Set<int> _favorites = {0, 1, 2, 3, 4, 5, 6, 7};

  static const _products = [
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

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
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
            SliverToBoxAdapter(
              child: AppHeader(title: s.favorites, showBack: widget.showBack),
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
                                kProductImages[favProducts[i].key % kProductImages.length],
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (i + 1 < favProducts.length)
                              Expanded(
                                child: _buildProductCard(
                                  cs,
                                  favProducts[i + 1].key,
                                  favProducts[i + 1].value,
                                  kProductImages[favProducts[i + 1].key % kProductImages.length],
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
                        s.noFavoritesYet,
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
    ColorScheme cs, int index, Product product, String imagePath,
  ) {
    final isFav = _favorites.contains(index);
    final heroTag = 'favorites_${imagePath}_$index';
    return ProductCard(
      product: product,
      imageAsset: imagePath,
      isFavorite: isFav,
      heroTag: heroTag,
      onFavoriteToggle: () => setState(() {
        if (isFav) {
          _favorites.remove(index);
        } else {
          _favorites.add(index);
        }
      }),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => ProductDetailScreen(
              brand: product.parsedBrand,
              name: product.title,
              condition: 'Used',
              price: product.newPrice,
              oldPrice: product.oldPrice,
              imageAsset: imagePath,
              heroTag: heroTag,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.5, 1.0),
                ),
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/product_card.dart';
import 'package:eqqu/theme/app_constants.dart';
import 'package:eqqu/data/mock_products.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:eqqu/providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  final bool showBack;

  static const _products = MockProducts.favoriteProducts;

  const FavoritesScreen({super.key, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;
    final favProvider = context.watch<FavoritesProvider>();
    final favProducts = _products
        .asMap()
        .entries
        .where((e) => favProvider.isFavorite(e.key))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AppHeader(title: s.favorites, showBack: showBack),
            ),

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
                                context,
                                cs,
                                favProducts[i].key,
                                favProducts[i].value,
                                kProductImages[favProducts[i].key % kProductImages.length],
                                favProvider.isFavorite(favProducts[i].key),
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (i + 1 < favProducts.length)
                              Expanded(
                                child: _buildProductCard(
                                  context,
                                  cs,
                                  favProducts[i + 1].key,
                                  favProducts[i + 1].value,
                                  kProductImages[favProducts[i + 1].key % kProductImages.length],
                                  favProvider.isFavorite(favProducts[i + 1].key),
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
                        style: AppTextStyles.bodyLarge(cs.tertiary),
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
    BuildContext context, ColorScheme cs, int index, Product product,
    String imagePath, bool isFav,
  ) {
    final heroTag = 'favorites_${imagePath}_$index';
    return ProductCard(
      product: product,
      imageAsset: imagePath,
      isFavorite: isFav,
      heroTag: heroTag,
      onFavoriteToggle: () => context.read<FavoritesProvider>().toggle(index),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => ProductDetailScreen(
              brand: product.parsedBrand,
              name: product.title,
              condition: AppStrings.of(context).used,
              price: product.newPrice,
              oldPrice: product.oldPrice,
              imageAsset: imagePath,
              heroTag: heroTag,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
    );
  }
}

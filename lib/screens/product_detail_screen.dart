import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';
import 'package:eqqu/screens/cart_screen.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/animated_heart.dart';
import 'package:eqqu/widgets/product_card.dart';
import 'package:eqqu/widgets/image_carousel.dart';
import 'package:eqqu/widgets/specs_grid.dart';
import 'package:eqqu/widgets/featured_banner.dart';
import 'package:eqqu/widgets/sheet_button.dart';
import 'package:eqqu/widgets/seller_card.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';
import 'package:eqqu/utils/fade_route.dart';
import 'package:eqqu/utils/report_flow.dart';

class ProductDetailScreen extends StatefulWidget {
  final String brand;
  final String name;
  final String condition;
  final String price;
  final String oldPrice;
  final String imageAsset;
  final String heroTag;

  const ProductDetailScreen({
    super.key,
    required this.brand,
    required this.name,
    required this.condition,
    required this.price,
    required this.oldPrice,
    this.imageAsset = '',
    this.heroTag = '',
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  final Set<int> _moreFavorites = {};
  final int _totalImages = 3;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomScrollView(
              slivers: [
                // Image header
                SliverToBoxAdapter(child: _buildImageHeader(cs)),

                // Product info
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductInfo(cs),
                        const SizedBox(height: 8),
                        _buildPriceRow(cs),
                        const SizedBox(height: 16),
                        _buildDescription(cs),
                        const SizedBox(height: 16),
                        _buildSpecsGrid(cs),
                        const SizedBox(height: 16),
                        _buildSellerCard(cs),
                        const SizedBox(height: 16),
                        _buildFeaturedBanner(cs),
                        const SizedBox(height: 24),
                        _buildMoreFromSeller(cs),
                        const SizedBox(height: 16),
                        _buildMoreProducts(cs),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),

                // Floating top buttons
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Semantics(
                            label: AppStrings.of(context).back,
                            button: true,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: cs.secondaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.arrow_back, size: 24, color: cs.onSecondaryContainer),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Semantics(
                            label: AppStrings.of(context).more,
                            button: true,
                            child: GestureDetector(
                              onTap: () => _showMoreSheet(),
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: cs.secondaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.more_vert, size: 24, color: cs.onSecondaryContainer),
                                ),
                              ),
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Buy button
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              border: Border(
                top: BorderSide(color: cs.outline, width: 1),
              ),
            ),
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  s.buy,
                  style: AppTextStyles.productTitle(cs.onPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(ColorScheme cs) {
    return ImageCarousel(
      imageAsset: widget.imageAsset,
      totalImages: _totalImages,
      currentIndex: _currentImageIndex,
      onPageChanged: (i) => setState(() => _currentImageIndex = i),
      heroTag: widget.heroTag,
      colorScheme: cs,
    );
  }

  Widget _buildProductInfo(ColorScheme cs) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.brand,
                style: AppTextStyles.labelMedium(cs.tertiary),
              ),
              Text(
                widget.name,
                style: AppTextStyles.outfit(fontSize: 28, fontWeight: FontWeight.w600, color: cs.onSurface, height: 36 / 28),
              ),
              if (widget.oldPrice.isNotEmpty)
                Text(
                  '${widget.oldPrice}  ',
                  style: AppTextStyles.labelMedium(cs.tertiary),
                ),
            ],
          ),
        ),
        AnimatedHeartButton(
          isFavorite: _isFavorite,
          cs: cs,
          iconSize: 24,
          circleSize: 0,
          onToggle: () => setState(() => _isFavorite = !_isFavorite),
        ),
      ],
    );
  }

  Widget _buildPriceRow(ColorScheme cs) {
    final s = AppStrings.of(context);
    return Row(
      children: [
        Text(
          '${widget.price}  ',
          style: AppTextStyles.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: cs.surfaceTint, height: 32 / 24),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 16, 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_user, size: 18, color: cs.surfaceTint),
                const SizedBox(width: 8),
                Text(
                  s.buyerProtection,
                  style: AppTextStyles.chip(cs.onSurface),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(ColorScheme cs) {
    return Opacity(
      opacity: 0.8,
      child: Text(
        'Kentucky bandages for sale never used, 4 pieces. Unisex size. The 280 g/m2 Polar Fleece Bandages feature a strong Velcro fastening and are designed with a high quality fleece to avoid pilling. These bandages measure 325 x 12 cm.',
        style: AppTextStyles.bodyMedium(cs.secondary),
      ),
    );
  }

  Widget _buildSpecsGrid(ColorScheme cs) {
    final s = AppStrings.of(context);
    return SpecsGrid(
      specs: [
        SpecItem(svgPath: 'assets/icons/Tag.svg', label: s.condition, value: widget.condition),
        SpecItem(svgPath: 'assets/icons/Measuring_tape.svg', label: s.size, value: 'One size'),
        SpecItem(svgPath: 'assets/icons/Color.svg', label: s.color, value: s.gray),
        SpecItem(svgPath: 'assets/icons/Fabric.svg', label: s.material, value: s.cotton),
      ],
    );
  }

  Widget _buildSellerCard(ColorScheme cs) {
    final s = AppStrings.of(context);
    return SellerCard(
      name: 'Emma Novak',
      avatarAsset: 'assets/images/avatar_1.png',
      messageCta: s.messageSeller,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BuyerViewSellerScreen()),
        );
      },
      onMessageTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ChatDetailScreen(
              name: 'Emma Novak',
              initials: 'EN',
              avatarImage: 'assets/images/avatar_1.png',
              productImage: 'assets/images/product_01.png',
              productName: 'Black GP type saddle',
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedBanner(ColorScheme cs) {
    return const FeaturedBanner(
      imageAsset: 'assets/images/product_03.png',
      title: 'Lorem ipsum dolor sit amet, elit adipiscin',
      subtitle: 'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
    );
  }

  Widget _buildMoreFromSeller(ColorScheme cs) {
    final s = AppStrings.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            s.moreFromSeller,
            style: AppTextStyles.sectionTitle(cs.onSurface),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BuyerViewSellerScreen()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chevron_right, size: 20, color: cs.surfaceTint),
              const SizedBox(width: 4),
              Text(
                s.showAll,
                style: AppTextStyles.actionLink(cs.surfaceTint),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMoreSheet() {
    final s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;
    showBlurBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              buildDragHandle(cs),
              // Share button
              SheetButton(
                icon: Icons.share,
                label: s.shareProduct,
                backgroundColor: cs.secondaryContainer,
                foregroundColor: cs.onSecondaryContainer,
                onPressed: () {
                  Navigator.pop(context);
                  AppSnackBar.show(context, message: s.linkCopied);
                },
              ),
              const SizedBox(height: 16),
              // Report button
              SheetButton(
                icon: Icons.flag_outlined,
                label: s.reportProduct,
                backgroundColor: cs.error,
                foregroundColor: cs.onError,
                onPressed: () {
                  Navigator.pop(context);
                  showReportSelectionSheet(context);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoreProducts(ColorScheme cs) {
    const products = [
      Product(title: 'Fleece bandáže Kentucky', subtitle: 'Kentucky / New / One size', oldPrice: '35 €', newPrice: '42 €', imageAsset: 'assets/images/product_07.png'),
      Product(title: 'Deka Eskadron Classic', subtitle: 'Eskadron / Very Good / 145cm', oldPrice: '95 €', newPrice: '110 €', imageAsset: 'assets/images/product_8.png'),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: products.asMap().entries.expand((entry) {
        final i = entry.key;
        final p = entry.value;
        final isFav = _moreFavorites.contains(i);
        final heroTag = 'more_seller_${p.imageAsset}_$i';
        return [
          if (i > 0) const SizedBox(width: 16),
          Expanded(
            child: ProductCard(
              product: p,
              imageAsset: p.imageAsset,
              isFavorite: isFav,
              heroTag: heroTag,
              onFavoriteToggle: () => setState(() {
                if (isFav) {
                  _moreFavorites.remove(i);
                } else {
                  _moreFavorites.add(i);
                }
              }),
              onTap: () {
                Navigator.push(
                  context,
                  fadeRoute(ProductDetailScreen(
                    brand: p.parsedBrand,
                    name: p.title,
                    condition: p.parsedCondition,
                    price: p.newPrice,
                    oldPrice: p.oldPrice,
                    imageAsset: p.imageAsset,
                    heroTag: heroTag,
                  )),
                );
              },
            ),
          ),
        ];
      }).toList(),
    );
  }
}

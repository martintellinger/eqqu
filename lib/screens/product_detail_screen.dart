import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/theme/app_constants.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';
import 'package:eqqu/screens/cart_screen.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/animated_heart.dart';
import 'package:eqqu/widgets/product_card.dart';

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
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: cs.secondaryContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.arrow_back, size: 24, color: cs.onSecondaryContainer),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
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
                  style: AppTextStyles.productTitle(Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(ColorScheme cs) {
    Widget imageArea = SizedBox(
      height: 391,
      child: Stack(
        children: [
          // Image carousel
          PageView.builder(
            itemCount: _totalImages,
            onPageChanged: (i) => setState(() => _currentImageIndex = i),
            itemBuilder: (_, index) {
              if (widget.imageAsset.isNotEmpty) {
                return Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }
              return Container(
                color: cs.surfaceContainerLow,
                child: Icon(Icons.image_outlined, size: 64, color: cs.tertiary.withValues(alpha: 0.3)),
              );
            },
          ),

          // Top gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 116,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.35, 1.0],
                  colors: [
                    Color(0x80000000),
                    Color(0x404E4E4E),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Bottom gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.12, 0.28, 1.0],
                  colors: [
                    Color(0x80000000),
                    Color(0x40000000),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Animated page indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalImages, (i) {
                final isActive = i == _currentImageIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: isActive ? 32 : 8,
                  height: 8,
                  margin: EdgeInsets.only(left: i > 0 ? 8 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.5),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );

    // Wrap entire image area with Hero for smooth grid→detail transition
    if (widget.heroTag.isNotEmpty) {
      imageArea = Hero(
        tag: widget.heroTag,
        flightShuttleBuilder: (_, animation, direction, fromContext, toContext) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final borderRadius = BorderRadius.lerp(
                BorderRadius.circular(4),
                BorderRadius.zero,
                animation.value,
              )!;
              return ClipRRect(
                borderRadius: borderRadius,
                child: widget.imageAsset.isNotEmpty
                    ? Image.asset(
                        widget.imageAsset,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(color: cs.surfaceContainerLow),
              );
            },
          );
        },
        child: Material(
          type: MaterialType.transparency,
          child: imageArea,
        ),
      );
    }

    return imageArea;
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _specItem(cs, 'assets/icons/Tag.svg', 'Condition', widget.condition)),
            const SizedBox(width: 12),
            Expanded(child: _specItem(cs, 'assets/icons/Measuring_tape.svg', 'Size', 'One size')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _specItem(cs, 'assets/icons/Color.svg', 'Color', 'Gray')),
            const SizedBox(width: 12),
            Expanded(child: _specItem(cs, 'assets/icons/Fabric.svg', 'Material', 'Cotton')),
          ],
        ),
      ],
    );
  }

  Widget _specItem(ColorScheme cs, String svgPath, String label, String value) {
    return Row(
      children: [
        SvgPicture.asset(svgPath, width: 24, height: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodyMedium(cs.tertiary)),
              Text(value, style: AppTextStyles.bodyLarge(cs.secondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSellerCard(ColorScheme cs) {
    final s = AppStrings.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BuyerViewSellerScreen()),
        );
      },
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          ClipOval(
            child: Image.asset(
              'assets/images/avatar_1.png',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + stars
                Row(
                  children: [
                    Text('Emma Novak', style: AppTextStyles.labelMedium(cs.secondary)),
                    const SizedBox(width: 12),
                    ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: AppConstants.starColor)),
                    Icon(Icons.star_border, size: 20, color: cs.tertiary),
                    const SizedBox(width: 8),
                    Text('4.2', style: AppTextStyles.labelMedium(cs.tertiary)),
                  ],
                ),
                // Message seller
                GestureDetector(
                  onTap: () {
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 20, color: cs.surfaceTint),
                        const SizedBox(width: 4),
                        Text(s.messageSeller, style: AppTextStyles.actionLink(cs.surfaceTint)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildFeaturedBanner(ColorScheme cs) {
    return AspectRatio(
      aspectRatio: 370 / 240,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/product_03.png',
              fit: BoxFit.cover,
            ),
            // Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.5, -0.3),
                  end: Alignment(-0.5, 1.0),
                  colors: [Colors.transparent, Color(0x80000000)],
                ),
              ),
            ),
            // EQQU logo top-left
            Positioned(
              left: 16,
              top: 16,
              child: Text(
                'EQQU',
                style: AppTextStyles.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            // Content bottom-left
            Positioned(
              left: 16,
              right: 64,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, elit adipiscin',
                    style: AppTextStyles.sectionTitle(Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
                    style: AppTextStyles.bodyMedium(Colors.white),
                  ),
                ],
              ),
            ),
            // Arrow button bottom-right
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: cs.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward, size: 24, color: cs.onSecondaryContainer),
              ),
            ),
          ],
        ),
      ),
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
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chevron_right, size: 20, color: cs.surfaceTint),
              const SizedBox(width: 4),
              Text(
                'Show all',
                style: AppTextStyles.actionLink(cs.surfaceTint),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMoreSheet() {
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
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outline,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              // Share button
              _buildSheetButton(
                cs,
                Icons.share,
                'Sdílet produkt',
                cs.secondaryContainer,
                cs.onSecondaryContainer,
                () {
                  Navigator.pop(context);
                  AppSnackBar.show(context, message: 'Odkaz byl zkopírován do schránky');
                },
              ),
              const SizedBox(height: 16),
              // Report button
              _buildSheetButton(
                cs,
                Icons.flag_outlined,
                'Nahlásit produkt',
                cs.error,
                Colors.white,
                () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetButton(
    ColorScheme cs,
    IconData icon,
    String label,
    Color bgColor,
    Color fgColor,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: fgColor),
        label: Text(label, style: AppTextStyles.labelMedium(fgColor)),
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
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
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 350),
                    reverseTransitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => ProductDetailScreen(
                      brand: p.parsedBrand,
                      name: p.title,
                      condition: p.parsedCondition,
                      price: p.newPrice,
                      oldPrice: p.oldPrice,
                      imageAsset: p.imageAsset,
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
            ),
          ),
        ];
      }).toList(),
    );
  }
}

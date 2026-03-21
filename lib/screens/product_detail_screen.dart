import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';
import 'package:eqqu/screens/cart_screen.dart';
import 'package:eqqu/utils/blur_overlay.dart';

class ProductDetailScreen extends StatefulWidget {
  final String brand;
  final String name;
  final String condition;
  final String price;
  final String oldPrice;
  final String imageAsset;

  const ProductDetailScreen({
    super.key,
    required this.brand,
    required this.name,
    required this.condition,
    required this.price,
    required this.oldPrice,
    this.imageAsset = '',
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
                        const SizedBox(height: 16),
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
                child: const Text(
                  'Buy',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.15,
                    height: 24 / 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(ColorScheme cs) {
    return SizedBox(
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

          // Page indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalImages, (i) {
                final isActive = i == _currentImageIndex;
                return Container(
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
  }

  Widget _buildProductInfo(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Text(
                      widget.brand,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: cs.tertiary,
                        letterSpacing: 0.15,
                        height: 24 / 16,
                      ),
                    ),
                    // Name
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                        height: 36 / 28,
                      ),
                    ),
                    // Old price
                    if (widget.oldPrice.isNotEmpty)
                      Text(
                        '${widget.oldPrice}  ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: cs.tertiary,
                          letterSpacing: 0.15,
                          height: 24 / 16,
                        ),
                      ),
                  ],
                ),
              ),
              // Heart button
              GestureDetector(
                onTap: () => setState(() => _isFavorite = !_isFavorite),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: SvgPicture.asset(
                      _isFavorite ? 'assets/icons/Heart.svg' : 'assets/icons/HeartEmpty.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _isFavorite ? cs.error : cs.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${widget.price}  ',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: cs.surfaceTint,
              height: 32 / 24,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
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
                    'Včetně ochrany kupujícího',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface,
                      letterSpacing: 0.1,
                      height: 20 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Opacity(
        opacity: 0.8,
        child: Text(
          'Kentucky bandages for sale never used, 4 pieces. Unisex size. The 280 g/m2 Polar Fleece Bandages feature a strong Velcro fastening and are designed with a high quality fleece to avoid pilling. These bandages measure 325 x 12 cm.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.secondary,
            letterSpacing: 0.25,
            height: 20 / 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSpecsGrid(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _specItem(cs, 'assets/icons/Tag.svg', 'Condition', widget.condition)),
              const SizedBox(width: 12),
              Expanded(child: _specItem(cs, 'assets/icons/Measuring_tape.svg', 'Size', 'One size')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _specItem(cs, 'assets/icons/Color.svg', 'Color', 'Gray')),
              const SizedBox(width: 12),
              Expanded(child: _specItem(cs, 'assets/icons/Fabric.svg', 'Material', 'Cotton')),
            ],
          ),
        ],
      ),
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
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: cs.tertiary,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: cs.secondary,
                  letterSpacing: 0.5,
                  height: 24 / 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSellerCard(ColorScheme cs) {
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
        color: cs.surfaceContainerHigh,
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
                    Text(
                      'Emma Novak',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: cs.secondary,
                        letterSpacing: 0.15,
                        height: 24 / 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: Color(0xFFFFD700))),
                    Icon(Icons.star_border, size: 20, color: cs.tertiary),
                    const SizedBox(width: 8),
                    Text(
                      '4.2',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: cs.tertiary,
                        letterSpacing: 0.15,
                        height: 24 / 16,
                      ),
                    ),
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
                        Text(
                          'Message seller',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: cs.surfaceTint,
                            letterSpacing: 0.1,
                            height: 20 / 14,
                          ),
                        ),
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
            const Positioned(
              left: 16,
              top: 16,
              child: Text(
                'EQQU',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
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
                children: const [
                  Text(
                    'Lorem ipsum dolor sit amet, elit adipiscin',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 28 / 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 0.25,
                      height: 20 / 14,
                    ),
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
    return Row(
      children: [
        Expanded(
          child: Text(
            'More from this seller',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
              height: 28 / 20,
            ),
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
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
                  letterSpacing: 0.1,
                  height: 20 / 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMoreSheet() {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      barrierColor: kBlurBarrierColor,
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Odkaz byl zkopírován do schránky')),
                  );
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
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: fgColor,
            letterSpacing: 0.15,
            height: 24 / 16,
          ),
        ),
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
    final products = [
      {
        'title': 'Fleece bandáže Kentucky',
        'subtitle': 'Kentucky / New / One size',
        'oldPrice': '35 €',
        'newPrice': '42 €',
        'image': 'assets/images/product_07.png',
      },
      {
        'title': 'Deka Eskadron Classic',
        'subtitle': 'Eskadron / Very Good / 145cm',
        'oldPrice': '95 €',
        'newPrice': '110 €',
        'image': 'assets/images/product_8.png',
      },
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: products.asMap().entries.map((entry) {
        final i = entry.key;
        final p = entry.value;
        final isFav = _moreFavorites.contains(i);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: i > 0 ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 177 / 200,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          p['image']!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => setState(() {
                            if (isFav) {
                              _moreFavorites.remove(i);
                            } else {
                              _moreFavorites.add(i);
                            }
                          }),
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: cs.secondaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    isFav ? 'assets/icons/Heart.svg' : 'assets/icons/HeartEmpty.svg',
                                    width: 16,
                                    height: 16,
                                    colorFilter: ColorFilter.mode(
                                      isFav ? cs.error : cs.onSecondaryContainer,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  p['title']!,
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
                  p['subtitle']!,
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
                      '${p['oldPrice']}  ',
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
                      '${p['newPrice']}  ',
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
          ),
        );
      }).toList(),
    );
  }
}

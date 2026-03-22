import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/theme/app_constants.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/product_card.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/utils/blur_overlay.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  final Set<int> _favorites = {};

  static const _products = [
    Product(title: 'Black GP type saddle', subtitle: 'No brand / Good / 17"', oldPrice: '140 €', newPrice: '159 €', imageAsset: 'assets/images/product_01.png'),
    Product(title: 'Blue Comfort type saddle', subtitle: 'Shires / New / Cob', oldPrice: '42 €', newPrice: '49 €', imageAsset: 'assets/images/product_02.png'),
    Product(title: 'Black GP type saddle', subtitle: 'No brand / Good / 17"', oldPrice: '140 €', newPrice: '159 €', imageAsset: 'assets/images/product_03.png'),
    Product(title: 'Blue Comfort type saddle', subtitle: 'Comfy Brand / Fair / 18"', oldPrice: '120 €', newPrice: '135 €', imageAsset: 'assets/images/product_04.png'),
  ];

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
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Odkaz byl zkopírován do schránky')),
                    );
                  },
                  icon: Icon(Icons.share, color: cs.onSecondaryContainer),
                  label: Text(
                    'Sdílet profil',
                    style: AppTextStyles.labelMedium(cs.onSecondaryContainer),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Edit profile button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.edit, color: cs.onSecondaryContainer),
                  label: Text(
                    'Editovat profil',
                    style: AppTextStyles.labelMedium(cs.onSecondaryContainer),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(
              title: 'Profil prodejce',
              showBack: true,
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: cs.onSurface),
                onPressed: _showMoreSheet,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile card
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildProfileCard(cs),
                  ),

                  // Info section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildInfoSection(cs),
                  ),

                  // "Inzeráty" section title
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Text(
                      'Inzeráty',
                      style: AppTextStyles.sectionTitle(cs.onSurface),
                    ),
                  ),

                  // Product grid
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildProductGrid(cs),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(ColorScheme cs) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Avatar + name + stars row
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar_1.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emma Novak',
                    style: AppTextStyles.sectionTitle(cs.secondary),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: AppConstants.starColor)),
                      Icon(Icons.star_border, size: 20, color: cs.tertiary),
                      const SizedBox(width: 8),
                      Text(
                        '4.2',
                        style: AppTextStyles.labelMedium(cs.tertiary),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              Expanded(
                child: _buildStatColumn(cs, '35', 'sledujících'),
              ),
              Expanded(
                child: _buildStatColumn(cs, '18', 'sleduje'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(ColorScheme cs, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.sectionTitle(cs.secondary),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall(cs.tertiary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoSection(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque eu mauris nec quam malesuada scelerisque ac luctus purus. Suspendisse placerat tristique orci, id volutpat nulla molestie non.',
          style: AppTextStyles.bodyMedium(cs.secondary),
        ),
        const SizedBox(height: 12),
        // Location
        _buildInfoRow(cs, 'assets/icons/MapPinArea.svg', 'Česká republika'),
        const SizedBox(height: 12),
        // Last login
        _buildInfoRow(
          cs,
          'assets/icons/ClockUser.svg',
          'Poslední přihlášení: ',
          trailingBold: '23.06.2024',
        ),
        const SizedBox(height: 12),
        // Verified
        _buildInfoRow(cs, 'assets/icons/shield-check.svg', 'Ověřeno e-mailem'),
      ],
    );
  }

  Widget _buildInfoRow(ColorScheme cs, String svgPath, String text, {String? trailingBold}) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(cs.secondary, BlendMode.srcIn),
        ),
        const SizedBox(width: 12),
        if (trailingBold != null)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: AppTextStyles.bodyMedium(cs.secondary),
                ),
                TextSpan(
                  text: trailingBold,
                  style: AppTextStyles.actionLink(cs.secondary),
                ),
              ],
            ),
          )
        else
          Text(
            text,
            style: AppTextStyles.bodyMedium(cs.secondary),
          ),
      ],
    );
  }

  Widget _buildProductGrid(ColorScheme cs) {
    final rows = <Widget>[];
    for (var i = 0; i < _products.length; i += 2) {
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + 2 < _products.length ? 16 : 0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildProductCard(cs, i, _products[i])),
                const SizedBox(width: 16),
                if (i + 1 < _products.length)
                  Expanded(child: _buildProductCard(cs, i + 1, _products[i + 1]))
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildProductCard(ColorScheme cs, int index, Product product) {
    final isFav = _favorites.contains(index);
    final heroTag = 'seller_profile_${product.imageAsset}_$index';
    return ProductCard(
      product: product,
      imageAsset: product.imageAsset,
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
              imageAsset: product.imageAsset,
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

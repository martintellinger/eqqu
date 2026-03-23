import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/theme/app_constants.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/product_card.dart';
import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/screens/reviews_screen.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/screens/build_set_screen.dart';
import 'package:eqqu/screens/cart_screen.dart';
import 'package:eqqu/data/mock_products.dart';
import 'package:eqqu/widgets/sheet_button.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';
import 'package:eqqu/utils/report_flow.dart';
import 'package:provider/provider.dart';
import 'package:eqqu/providers/favorites_provider.dart';
import 'package:eqqu/utils/fade_route.dart';

class BuyerViewSellerScreen extends StatefulWidget {
  const BuyerViewSellerScreen({super.key});

  @override
  State<BuyerViewSellerScreen> createState() => _BuyerViewSellerScreenState();
}

class _BuyerViewSellerScreenState extends State<BuyerViewSellerScreen> {
  bool _isFollowing = false;
  bool _isBlocked = false;
  List<Product> _setItems = [];

  static const _products = MockProducts.sellerProducts;

  void _showMoreSheet() {
    final s = AppStrings.of(context);
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
              buildDragHandle(cs),
              // Share button
              SheetButton(
                icon: Icons.share,
                label: s.shareProfile,
                backgroundColor: cs.secondaryContainer,
                foregroundColor: cs.onSecondaryContainer,
                onPressed: () {
                  Navigator.pop(context);
                  AppSnackBar.show(context, message: s.linkCopied);
                },
              ),
              const SizedBox(height: 16),
              // Block button
              SheetButton(
                icon: _isBlocked ? Icons.check_circle_outline : Icons.block,
                label: _isBlocked ? s.unblockSeller : s.blockSeller,
                backgroundColor: cs.secondaryContainer,
                foregroundColor: cs.onSecondaryContainer,
                onPressed: () {
                  Navigator.pop(context);
                  if (_isBlocked) {
                    setState(() => _isBlocked = false);
                    AppSnackBar.show(context, message: s.sellerUnblocked);
                  } else {
                    _showBlockDialog();
                  }
                },
              ),
              const SizedBox(height: 16),
              // Report button
              SheetButton(
                icon: Icons.flag_outlined,
                label: s.reportProfile,
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


  void _showBlockDialog() {
    final s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;
    showBlurDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: cs.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.blockSellerQuestion,
                style: AppTextStyles.outfit(fontSize: 24, fontWeight: FontWeight.w500, color: cs.onSurface, height: 32 / 24),
              ),
              const SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit',
                style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: cs.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        s.cancel,
                        style: AppTextStyles.chip(cs.onSurfaceVariant),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        setState(() => _isBlocked = true);
                        AppSnackBar.showError(context, message: s.sellerBlocked);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.error,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        s.blockSeller,
                        style: AppTextStyles.chip(cs.onError),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(
              title: 'emma.novak',
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

                  // Follow button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          setState(() => _isFollowing = !_isFollowing);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: _isFollowing
                              ? cs.secondaryContainer
                              : cs.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _isFollowing ? s.following : s.follow,
                          style: AppTextStyles.labelMedium(_isFollowing
                              ? cs.onSecondaryContainer
                              : cs.onPrimary),
                        ),
                      ),
                    ),
                  ),

                  // Message seller button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () {
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
                        icon: Icon(Icons.chat_bubble_outline, size: 20, color: cs.primary),
                        label: Text(
                          s.writeMessage,
                          style: AppTextStyles.labelMedium(cs.primary),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: cs.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // "Inzeráty" section title with "Sestavit sadu" link
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          s.listings,
                          style: AppTextStyles.sectionTitle(cs.onSurface),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push<List<Product>>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BuildSetScreen(
                                  products: _products,
                                ),
                              ),
                            );
                            if (result != null) {
                              setState(() => _setItems = result);
                            }
                          },
                          child: Text(
                            'Sestavit sadu',
                            style: AppTextStyles.actionLink(cs.surfaceTint),
                          ),
                        ),
                      ],
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
          if (_setItems.isNotEmpty)
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
                    final cartItems = _setItems.map((p) => CartItem(
                      title: p.title,
                      price: p.newPrice,
                      priceNum: int.tryParse(p.newPrice.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
                      imageAsset: p.imageAsset,
                    )).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartScreen(initialItems: cartItems),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Buy (${_setItems.length})',
                    style: AppTextStyles.productTitle(cs.onPrimary),
                  ),
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
              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isBlocked)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: cs.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Zablokovaný prodejce',
                        style: AppTextStyles.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: cs.error, letterSpacing: 0.4, height: 16 / 12),
                      ),
                    ),
                  Text('Emma Novak', style: AppTextStyles.sectionTitle(cs.secondary)),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ReviewsScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: AppConstants.starColor)),
                        Icon(Icons.star_border, size: 20, color: cs.tertiary),
                        const SizedBox(width: 8),
                        Text('4.2', style: AppTextStyles.labelMedium(cs.tertiary)),
                      ],
                    ),
                  ),
                ],
              ),
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
        Text(value, style: AppTextStyles.sectionTitle(cs.secondary), textAlign: TextAlign.center),
        Text(label, style: AppTextStyles.labelSmall(cs.tertiary), textAlign: TextAlign.center),
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
        SvgPicture.asset(svgPath, width: 24, height: 24, colorFilter: ColorFilter.mode(cs.secondary, BlendMode.srcIn)),
        const SizedBox(width: 12),
        if (trailingBold != null)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: text, style: AppTextStyles.bodyMedium(cs.secondary)),
                TextSpan(text: trailingBold, style: AppTextStyles.actionLink(cs.secondary)),
              ],
            ),
          )
        else
          Text(text, style: AppTextStyles.bodyMedium(cs.secondary)),
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
    final favProvider = context.read<FavoritesProvider>();
    final isFav = context.watch<FavoritesProvider>().isFavorite(index);
    final heroTag = 'buyer_seller_${product.imageAsset}_$index';
    return ProductCard(
      product: product,
      imageAsset: product.imageAsset,
      isFavorite: isFav,
      heroTag: heroTag,
      onFavoriteToggle: () => favProvider.toggle(index),
      onTap: () {
        Navigator.push(
          context,
          fadeRoute(ProductDetailScreen(
            brand: product.parsedBrand,
            name: product.title,
            condition: AppStrings.of(context).used,
            price: product.newPrice,
            oldPrice: product.oldPrice,
            imageAsset: product.imageAsset,
            heroTag: heroTag,
          )),
        );
      },
    );
  }
}

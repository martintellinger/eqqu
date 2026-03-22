import 'package:flutter/material.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/animated_heart.dart';

/// Reusable product card used in home grid, favorites, seller profile,
/// and product detail "more products" sections.
class ProductCard extends StatelessWidget {
  final Product product;
  final String imageAsset;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback? onTap;
  final String heroTag;

  /// Optional builder for highlighted text (used by search in HomeScreen).
  final Widget Function(String text, TextStyle style)? titleBuilder;
  final Widget Function(String text, TextStyle style)? subtitleBuilder;

  const ProductCard({
    super.key,
    required this.product,
    required this.imageAsset,
    required this.isFavorite,
    required this.onFavoriteToggle,
    this.onTap,
    this.heroTag = '',
    this.titleBuilder,
    this.subtitleBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: onTap != null ? HitTestBehavior.opaque : HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImage(cs),
          const SizedBox(height: 4),
          _buildTitle(cs),
          _buildSubtitle(cs),
          const SizedBox(height: 1),
          _buildPriceRow(cs),
        ],
      ),
    );
  }

  Widget _buildImage(ColorScheme cs) {
    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.asset(
        imageAsset,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );

    if (heroTag.isNotEmpty) {
      image = Hero(tag: heroTag, child: image);
    }

    return AspectRatio(
      aspectRatio: 177 / 200,
      child: Stack(
        children: [
          image,
          Positioned(
            top: 0,
            right: 0,
            child: AnimatedHeartButton(
              isFavorite: isFavorite,
              cs: cs,
              onToggle: onFavoriteToggle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(ColorScheme cs) {
    final style = AppTextStyles.productTitle(cs.secondary);
    if (titleBuilder != null) {
      return titleBuilder!(product.title, style);
    }
    return Text(
      product.title,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle(ColorScheme cs) {
    final style = AppTextStyles.productSubtitle(cs.tertiary);
    if (subtitleBuilder != null) {
      return subtitleBuilder!(product.subtitle, style);
    }
    return Text(
      product.subtitle,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceRow(ColorScheme cs) {
    return Row(
      children: [
        Text(
          '${product.oldPrice}  ',
          style: AppTextStyles.productOldPrice(cs.tertiary),
        ),
        const SizedBox(width: 8),
        Text(
          '${product.newPrice}  ',
          style: AppTextStyles.productNewPrice(cs.surfaceTint),
        ),
        Text(
          'vč.',
          style: AppTextStyles.productBadge(cs.surfaceTint),
        ),
        const SizedBox(width: 4),
        Icon(Icons.verified_user, size: 16, color: cs.surfaceTint),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/screens/product_detail_screen.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  bool _allHidden = false;

  static const _listings = [
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'image': 'assets/images/product_01.png',
      'status': 'active',
      'brand': 'No brand',
      'condition': 'Good',
    },
    {
      'title': 'Green Mountain type saddle',
      'subtitle': 'Rugged Brand / Very G...',
      'oldPrice': '180 €',
      'newPrice': '199 €',
      'image': 'assets/images/product_02.png',
      'status': 'sold',
      'brand': 'Rugged Brand',
      'condition': 'Very Good',
    },
    {
      'title': 'Red Racing type saddle',
      'subtitle': 'Speedy Brand / Excelle...',
      'oldPrice': '200 €',
      'newPrice': '230 €',
      'image': 'assets/images/product_03.png',
      'status': 'sold',
      'brand': 'Speedy Brand',
      'condition': 'Excellent',
    },
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'image': 'assets/images/product_01.png',
      'status': 'shipped',
      'brand': 'No brand',
      'condition': 'Good',
    },
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'image': 'assets/images/product_04.png',
      'status': 'shipped',
      'brand': 'No brand',
      'condition': 'Good',
    },
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'image': 'assets/images/product_05.png',
      'status': 'shipped',
      'brand': 'No brand',
      'condition': 'Good',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: const AppHeader(title: 'Moje inzeráty', showBack: true),
          ),
          Expanded(
            child: Stack(
              children: [
                GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 177 / 290,
                  ),
                  itemCount: _listings.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(cs, index, _listings[index]);
                  },
                ),
                // Dark overlay when hidden
                if (_allHidden)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Bottom button
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: () {
                  setState(() => _allHidden = !_allHidden);
                },
                icon: Icon(
                  _allHidden ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                label: Text(
                  _allHidden ? 'Odkrýt všechny inzeráty' : 'Skrýt všechny inzeráty',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.15,
                    height: 24 / 16,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ColorScheme cs, int index, Map<String, String> product) {
    final status = product['status']!;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              brand: product['brand']!,
              name: product['title']!,
              condition: product['condition']!,
              price: product['newPrice']!,
              oldPrice: product['oldPrice']!,
              imageAsset: product['image']!,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with status badge
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    product['image']!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Status badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: _buildStatusBadge(cs, status),
                ),
                // Eye-slash icon when hidden
                if (_allHidden)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: cs.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.visibility_off, size: 18, color: cs.onSecondaryContainer),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Title
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
          // Subtitle
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
          // Price row
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

  Widget _buildStatusBadge(ColorScheme cs, String status) {
    String label;
    Color dotColor;
    IconData? icon;

    switch (status) {
      case 'active':
        label = 'Aktivní';
        dotColor = const Color(0xFFA46700);
        icon = null; // filled circle
        break;
      case 'sold':
        label = 'Prodáno';
        dotColor = cs.primary;
        icon = Icons.check;
        break;
      case 'shipped':
        label = 'Odesláno';
        dotColor = const Color(0xFFA46700);
        icon = null;
        break;
      default:
        label = status;
        dotColor = cs.tertiary;
        icon = null;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, size: 16, color: dotColor)
          else
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              letterSpacing: 0.4,
              height: 16 / 12,
            ),
          ),
        ],
      ),
    );
  }
}

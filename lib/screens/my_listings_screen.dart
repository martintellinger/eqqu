import 'package:flutter/material.dart';
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
      'subtitle': 'Rugged Brand / Very Good / 16"',
      'oldPrice': '180 €',
      'newPrice': '199 €',
      'image': 'assets/images/product_02.png',
      'status': 'sold',
      'brand': 'Rugged Brand',
      'condition': 'Very Good',
    },
    {
      'title': 'Red Racing type saddle',
      'subtitle': 'Speedy Brand / Excellent / 15"',
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
      'title': 'Red Racing type saddle',
      'subtitle': 'Speedy Brand / Excellent / 15"',
      'oldPrice': '200 €',
      'newPrice': '230 €',
      'image': 'assets/images/product_03.png',
      'status': 'shipped',
      'brand': 'Speedy Brand',
      'condition': 'Excellent',
    },
    {
      'title': 'Green Mountain type saddle',
      'subtitle': 'Rugged Brand / Very Good / 16"',
      'oldPrice': '180 €',
      'newPrice': '199 €',
      'image': 'assets/images/product_02.png',
      'status': 'shipped',
      'brand': 'Rugged Brand',
      'condition': 'Very Good',
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
            child: GridView.builder(
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
          ),
          // Bottom floating button
          Container(
            padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(context).padding.bottom + 16,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(8),
                color: cs.primary,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => setState(() => _allHidden = !_allHidden),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _allHidden ? Icons.visibility : Icons.visibility_off,
                          size: 24,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _allHidden
                              ? 'Odkrýt všechny inzeráty'
                              : 'Skrýt všechny inzeráty',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.15,
                            height: 24 / 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    ColorScheme cs,
    int index,
    Map<String, String> product,
  ) {
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
                // Status badge (top-left)
                Positioned(
                  top: 8,
                  left: 8,
                  child: _buildStatusChip(cs, status),
                ),
                // Hidden eye-off chip (bottom-left)
                if (_allHidden)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: _buildHiddenChip(cs),
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

  /// Elevated assistive chip for status badge (Aktivní / Prodáno / Odesláno)
  Widget _buildStatusChip(ColorScheme cs, String status) {
    String label;
    Color textColor;
    IconData icon;

    switch (status) {
      case 'active':
        label = 'Aktivní';
        textColor = const Color(0xFFA46700);
        icon = Icons.circle;
        break;
      case 'sold':
        label = 'Prodáno';
        textColor = cs.surfaceTint;
        icon = Icons.check_circle;
        break;
      case 'shipped':
        label = 'Odesláno';
        textColor = cs.onSurface;
        icon = Icons.circle;
        break;
      default:
        label = status;
        textColor = cs.tertiary;
        icon = Icons.circle;
    }

    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 8, right: 16, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
              letterSpacing: 0.1,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Icon-only chip for hidden state (eye-off icon at bottom-left)
  Widget _buildHiddenChip(ColorScheme cs) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(Icons.visibility_off, size: 18, color: cs.onSurface),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  static const _products = [
    {
      'title': 'EquiEase Deluxe Saddle for professional riders in Benelux countries.',
      'price': '159 €',
      'image': 'assets/images/product_01.png',
    },
    {
      'title': 'Blue Comfort type saddle',
      'price': '159 €',
      'image': 'assets/images/product_02.png',
    },
    {
      'title': 'EquiEase Deluxe Saddle for professional riders in Benelux countries.',
      'price': '159 €',
      'image': 'assets/images/product_03.png',
    },
  ];

  void _showRatingDialog(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    int selectedStars = 4;
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          backgroundColor: cs.surfaceContainerHigh,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ohodnoťte nákup',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurface,
                          height: 32 / 24,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Lorem ipsum dolor sit amet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurfaceVariant,
                          letterSpacing: 0.25,
                          height: 20 / 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Star rating
                      Row(
                        children: List.generate(5, (i) {
                          return GestureDetector(
                            onTap: () => setDialogState(() => selectedStars = i + 1),
                            child: Icon(
                              i < selectedStars ? Icons.star : Icons.star_border,
                              size: 40,
                              color: i < selectedStars
                                  ? const Color(0xFFFFD700)
                                  : cs.tertiary,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      // Text field
                      SizedBox(
                        height: 140,
                        child: TextField(
                          controller: textController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            labelText: 'Slovní hodnocení',
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Actions
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel button (outlined)
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
                            'Zrušit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: cs.onSurfaceVariant,
                              letterSpacing: 0.1,
                              height: 20 / 14,
                            ),
                          ),
                        ),
                      ),
                      // Submit button (tonal)
                      SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: FilledButton.styleFrom(
                            backgroundColor: cs.secondaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            'Odeslat',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: cs.onSecondaryContainer,
                              letterSpacing: 0.1,
                              height: 20 / 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            child: AppHeader(title: 'Objednávka', showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order header
                  _buildOrderHeader(cs),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Products section
                  _buildProductsSection(cs),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Buyer info
                  _buildBuyerInfo(cs),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Shipping
                  _buildShippingSection(cs),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Seller info
                  _buildSellerInfo(cs),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Price summary
                  _buildPriceSummary(cs),

                  // Rate button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: () => _showRatingDialog(context),
                        child: Text(
                          'Ohodnotit',
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status chip
          Container(
            height: 32,
            padding: const EdgeInsets.only(left: 8, right: 16, top: 6, bottom: 6),
            decoration: BoxDecoration(
              border: Border.all(color: cs.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, size: 18, color: cs.surfaceTint),
                const SizedBox(width: 8),
                Text(
                  'Dokončeno',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: cs.surfaceTint,
                    letterSpacing: 0.1,
                    height: 20 / 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Order title
          Text(
            'Objednávka 12345678',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 32 / 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '23.06.2025 13:49',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cs.tertiary,
              letterSpacing: 0.25,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Produkty',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 16),
          ..._products.map((product) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildProductRow(cs, product),
          )),
        ],
      ),
    );
  }

  Widget _buildProductRow(ColorScheme cs, Map<String, String> product) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            product['image']!,
            width: 80,
            height: 87,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['title']!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.secondary,
                  letterSpacing: 0.1,
                  height: 20 / 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                product['price']!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
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

  Widget _buildBuyerInfo(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informace o kupujícím',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anna Novak',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: cs.secondary,
                    letterSpacing: 0.25,
                    height: 20 / 14,
                  ),
                ),
                Text(
                  '+420 123 456 789',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: cs.secondary,
                    letterSpacing: 0.25,
                    height: 20 / 14,
                  ),
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Doručovací adresa:\n',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: cs.secondary,
                          letterSpacing: 0.25,
                          height: 20 / 14,
                        ),
                      ),
                      TextSpan(
                        text: 'Soukenická 4, Praha 110 00, Česká republika',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: cs.secondary,
                          letterSpacing: 0.25,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingSection(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doprava',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.8,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Doručení na adresu\n',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: cs.secondary,
                      letterSpacing: 0.25,
                      height: 20 / 14,
                    ),
                  ),
                  TextSpan(
                    text: 'Zásilkovna (lorem ipsum dolor)',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: cs.secondary,
                      letterSpacing: 0.25,
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

  Widget _buildSellerInfo(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informace o prodejci',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      // Name + stars row
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                        ],
                      ),
                      // Message seller button
                      GestureDetector(
                        onTap: () {},
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
        ],
      ),
    );
  }

  Widget _buildPriceSummary(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.8,
            child: Text(
              'Cena celkem',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: cs.secondary,
                height: 28 / 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildPriceRow(cs, 'Cena zboží', '416 €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Cena dopravy', '2 €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Poplatek za ochranu kupujícího', '2 €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Celkem k úhradě', '418 €', true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(ColorScheme cs, String label, String value, bool isTotal) {
    final style = isTotal
        ? TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: cs.surfaceTint,
            letterSpacing: 0.5,
            height: 24 / 16,
          )
        : TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.secondary,
            letterSpacing: 0.25,
            height: 20 / 14,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: style)),
        Text(value, style: style),
      ],
    );
  }
}

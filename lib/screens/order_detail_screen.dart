import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/theme/app_constants.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

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

  void _showRatingDialog() {
    final cs = Theme.of(context).colorScheme;
    int selectedStars = 4;
    final textController = TextEditingController();

    showBlurDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          backgroundColor: cs.surfaceContainerHigh,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ohodnoťte nákup',
                    style: AppTextStyles.outfit(fontSize: 24, fontWeight: FontWeight.w400, color: cs.onSurface, height: 32 / 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Lorem ipsum dolor sit amet',
                    style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
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
                              ? AppConstants.starColor
                              : cs.tertiary,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  // Text field
                  TextField(
                    controller: textController,
                    maxLines: 5,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      labelText: 'Slovní hodnocení',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Actions
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
                            'Zrušit',
                            style: AppTextStyles.chip(cs.onSurfaceVariant),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Hodnocení bylo odesláno',
                                  style: AppTextStyles.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                                ),
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: cs.secondaryContainer,
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            'Odeslat',
                            style: AppTextStyles.chip(cs.onSecondaryContainer),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
          const SafeArea(
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
                        onPressed: _showRatingDialog,
                        child: Text(
                          'Ohodnotit',
                          style: AppTextStyles.productTitle(Colors.white),
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
                  style: AppTextStyles.chip(cs.surfaceTint),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Order title
          Text(
            'Objednávka 12345678',
            style: AppTextStyles.outfit(fontSize: 24, fontWeight: FontWeight.w400, color: cs.secondary, height: 32 / 24),
          ),
          const SizedBox(height: 4),
          Text(
            '23.06.2025 13:49',
            style: AppTextStyles.bodyMedium(cs.tertiary),
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
            style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: cs.secondary, height: 28 / 20),
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
                style: AppTextStyles.actionLink(cs.secondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                product['price']!,
                style: AppTextStyles.productNewPrice(cs.surfaceTint),
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
            style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: cs.secondary, height: 28 / 20),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anna Novak',
                  style: AppTextStyles.bodyMedium(cs.secondary),
                ),
                Text(
                  '+420 123 456 789',
                  style: AppTextStyles.bodyMedium(cs.secondary),
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Doručovací adresa:\n',
                        style: AppTextStyles.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: cs.secondary, letterSpacing: 0.25, height: 20 / 14),
                      ),
                      TextSpan(
                        text: 'Soukenická 4, Praha 110 00, Česká republika',
                        style: AppTextStyles.bodyMedium(cs.secondary),
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
            style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: cs.secondary, height: 28 / 20),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.8,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Doručení na adresu\n',
                    style: AppTextStyles.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: cs.secondary, letterSpacing: 0.25, height: 20 / 14),
                  ),
                  TextSpan(
                    text: 'Zásilkovna (lorem ipsum dolor)',
                    style: AppTextStyles.bodyMedium(cs.secondary),
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
            style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: cs.secondary, height: 28 / 20),
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
                            style: AppTextStyles.labelMedium(cs.secondary),
                          ),
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
                                style: AppTextStyles.actionLink(cs.surfaceTint),
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
              style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: cs.secondary, height: 28 / 20),
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
        ? AppTextStyles.productNewPrice(cs.surfaceTint)
        : AppTextStyles.bodyMedium(cs.secondary);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: style)),
        Text(value, style: style),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _paymentMethod = 'card';
  String _deliveryMethod = 'address';
  bool _saveCard = false;

  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  static const _cartItems = [
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

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  void _showOrderConfirmation() {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: cs.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: cs.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 32, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Je to tam!',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                  height: 32 / 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tvoje objednávka byla úspěšně odeslána.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Zobrazit objednávku',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
              ),
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
            child: const AppHeader(title: 'Košík', showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart items
                  _buildCartItems(cs),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Delivery address
                  _buildSection(cs, 'Doručovací adresa', [
                    _buildAddressInfo(cs),
                  ]),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Personal info
                  _buildSection(cs, 'Osobní údaje', [
                    _buildPersonalInfo(cs),
                  ]),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Payment method
                  _buildSection(cs, 'Způsob platby', [
                    _buildPaymentOption(cs, 'apple_pay', 'Apple Pay', Icons.apple),
                    const SizedBox(height: 12),
                    _buildPaymentOption(cs, 'google_pay', 'Google Pay', Icons.g_mobiledata),
                    const SizedBox(height: 12),
                    _buildPaymentOption(cs, 'card', 'Platba kartou', Icons.credit_card),
                    if (_paymentMethod == 'card') ...[
                      const SizedBox(height: 16),
                      _buildCardFields(cs),
                    ],
                  ]),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Delivery method
                  _buildSection(cs, 'Způsob doručení', [
                    _buildDeliveryOption(cs, 'address', 'Doručení na adresu', '2 €'),
                    const SizedBox(height: 12),
                    _buildDeliveryOption(cs, 'pickup', 'Osobní odběr', 'Zdarma'),
                  ]),
                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Price summary
                  _buildPriceSummary(cs),

                  // Order button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: _showOrderConfirmation,
                        child: const Text(
                          'Objednávka zavazující k platbě',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.15,
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

  Widget _buildCartItems(ColorScheme cs) {
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
          ..._cartItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    item['image']!,
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
                        item['title']!,
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
                        item['price']!,
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: cs.onSurfaceVariant),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSection(ColorScheme cs, String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAddressInfo(ColorScheme cs) {
    return Opacity(
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
            'Soukenická 4, Praha 110 00',
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
            'Česká republika',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              letterSpacing: 0.25,
              height: 20 / 14,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Změnit adresu',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: cs.surfaceTint,
                letterSpacing: 0.1,
                height: 20 / 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo(ColorScheme cs) {
    return Opacity(
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
          Text(
            'anna.novak@email.cz',
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
    );
  }

  Widget _buildPaymentOption(ColorScheme cs, String value, String label, IconData icon) {
    final selected = _paymentMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? cs.surfaceTint : cs.outline,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? cs.surfaceTint : cs.onSurfaceVariant,
                  width: selected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(icon, size: 24, color: cs.onSurface),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: cs.onSurface,
                letterSpacing: 0.5,
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFields(ColorScheme cs) {
    return Column(
      children: [
        TextField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: cs.onSurface,
          ),
          decoration: const InputDecoration(
            labelText: 'Číslo karty',
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _expiryController,
                keyboardType: TextInputType.datetime,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                ),
                decoration: const InputDecoration(
                  labelText: 'Expirace',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _cvcController,
                keyboardType: TextInputType.number,
                obscureText: true,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                ),
                decoration: const InputDecoration(
                  labelText: 'CVC/CVV',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: _saveCard,
                onChanged: (v) => setState(() => _saveCard = v ?? false),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Uložit kartu pro příští nákup',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: cs.onSurface,
                letterSpacing: 0.25,
                height: 20 / 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryOption(ColorScheme cs, String value, String label, String price) {
    final selected = _deliveryMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _deliveryMethod = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? cs.surfaceTint : cs.outline,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? cs.surfaceTint : cs.onSurfaceVariant,
                  width: selected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                  letterSpacing: 0.5,
                  height: 24 / 16,
                ),
              ),
            ),
            Text(
              price,
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
    );
  }

  Widget _buildPriceSummary(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cena celkem',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 28 / 20,
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

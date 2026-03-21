import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/screens/order_detail_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _paymentMethod = 'card';
  String _deliveryMethod = 'address';
  bool _saveCard = false;
  bool _hasSubmitted = false;
  String? _cardNumberError;
  String? _expiryError;
  String? _cvcError;

  int _selectedAddressIndex = 0;
  static const _addresses = [
    {'name': 'Anna Novak', 'street': 'Soukenická 4, Praha 110 00', 'country': 'Česká republika', 'icon': 'home'},
    {'name': 'Anna Novak', 'street': 'Náměstí Míru 31, Praha 110 00', 'country': 'Česká republika', 'icon': 'location'},
  ];

  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  late List<Map<String, String>> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = [
      {
        'title': 'EquiEase Deluxe Saddle for professional riders in Benelux countries.',
        'price': '159 €',
        'priceNum': '159',
        'image': 'assets/images/product_01.png',
      },
      {
        'title': 'Blue Comfort type saddle',
        'price': '159 €',
        'priceNum': '159',
        'image': 'assets/images/product_02.png',
      },
      {
        'title': 'EquiEase Deluxe Saddle for professional riders in Benelux countries.',
        'price': '159 €',
        'priceNum': '159',
        'image': 'assets/images/product_03.png',
      },
    ];
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  int get _totalProductPrice {
    int total = 0;
    for (final item in _cartItems) {
      total += int.tryParse(item['priceNum'] ?? '0') ?? 0;
    }
    return total;
  }

  int get _deliveryPrice => _deliveryMethod == 'pickup' ? 0 : 2;

  int get _buyerProtectionFee => _cartItems.isNotEmpty ? 2 : 0;

  int get _totalPrice => _totalProductPrice + _deliveryPrice + _buyerProtectionFee;

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Produkt byl odebrán z košíku',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool _validateCardFields() {
    if (_paymentMethod != 'card') return true;

    bool valid = true;
    setState(() {
      _cardNumberError = null;
      _expiryError = null;
      _cvcError = null;

      final cardNum = _cardNumberController.text.replaceAll(' ', '');
      if (cardNum.isEmpty) {
        _cardNumberError = 'Zadejte číslo karty';
        valid = false;
      } else if (cardNum.length < 13) {
        _cardNumberError = 'Neplatné číslo karty';
        valid = false;
      }

      if (_expiryController.text.trim().isEmpty) {
        _expiryError = 'Zadejte expiraci';
        valid = false;
      }

      if (_cvcController.text.trim().isEmpty) {
        _cvcError = 'Zadejte CVC';
        valid = false;
      } else if (_cvcController.text.trim().length < 3) {
        _cvcError = 'Neplatný CVC';
        valid = false;
      }
    });
    return valid;
  }

  void _submitOrder() {
    setState(() => _hasSubmitted = true);

    if (_cartItems.isEmpty) return;
    if (!_validateCardFields()) return;
    _showOrderConfirmation();
  }

  void _showOrderConfirmation() {
    final cs = Theme.of(context).colorScheme;
    showBlurDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => Dialog(
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
                    Navigator.pop(dialogCtx); // close dialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const OrderDetailScreen()),
                    );
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
            child: _cartItems.isEmpty
                ? _buildEmptyCart(cs)
                : SingleChildScrollView(
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
                              onPressed: _submitOrder,
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

  Widget _buildEmptyCart(ColorScheme cs) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: cs.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            'Košík je prázdný',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: cs.secondary,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Přidejte produkty do košíku a začněte nakupovat.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cs.onSurfaceVariant,
              letterSpacing: 0.25,
              height: 20 / 14,
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
            'Produkty (${_cartItems.length})',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.secondary,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_cartItems.length, (index) {
            final item = _cartItems[index];
            return Padding(
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
                    onPressed: () => _removeItem(index),
                    icon: Icon(Icons.delete_outline, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            );
          }),
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
    final addr = _addresses[_selectedAddressIndex];
    final textStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: cs.secondary,
      letterSpacing: 0.25,
      height: 20 / 14,
    );
    return Opacity(
      opacity: 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(addr['name']!, style: textStyle),
          Text(addr['street']!, style: textStyle),
          Text(addr['country']!, style: textStyle),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _showAddressSheet(),
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

  void _showAddressSheet() {
    final cs = Theme.of(context).colorScheme;
    showBlurBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outline,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Text(
                'Doručovací adresa',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                  height: 28 / 20,
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(_addresses.length, (i) {
                final addr = _addresses[i];
                final isSelected = i == _selectedAddressIndex;
                final icon = addr['icon'] == 'home' ? Icons.home_outlined : Icons.location_on_outlined;
                return Padding(
                  padding: EdgeInsets.only(bottom: i < _addresses.length - 1 ? 12 : 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedAddressIndex = i);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? cs.primary : cs.outlineVariant,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(icon, size: 24, color: cs.onSurface),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addr['name']!,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: cs.onSurface,
                                    letterSpacing: 0.15,
                                    height: 24 / 16,
                                  ),
                                ),
                                Text(
                                  addr['street']!,
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
                          if (isSelected)
                            Icon(Icons.check_circle, size: 24, color: cs.primary),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
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
          decoration: InputDecoration(
            labelText: 'Číslo karty',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorText: _hasSubmitted ? _cardNumberError : null,
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
                decoration: InputDecoration(
                  labelText: 'Expirace',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  errorText: _hasSubmitted ? _expiryError : null,
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
                decoration: InputDecoration(
                  labelText: 'CVC/CVV',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  errorText: _hasSubmitted ? _cvcError : null,
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
          _buildPriceRow(cs, 'Cena zboží', '$_totalProductPrice €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Cena dopravy', '$_deliveryPrice €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Poplatek za ochranu kupujícího', '$_buyerProtectionFee €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Celkem k úhradě', '$_totalPrice €', true),
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

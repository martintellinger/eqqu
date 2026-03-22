import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/screens/order_detail_screen.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/services/cart_service.dart';
import 'package:eqqu/services/validators.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, String>>? initialItems;

  const CartScreen({super.key, this.initialItems});

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
    _cartItems = widget.initialItems != null
        ? widget.initialItems!.map((item) => Map<String, String>.from(item)).toList()
        : [
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

  int get _totalProductPrice => CartService.totalProductPrice(_cartItems);

  int get _deliveryPrice => CartService.deliveryPrice(_deliveryMethod);

  int get _buyerProtectionFee => CartService.buyerProtectionFee(_cartItems);

  int get _totalPrice => CartService.totalPrice(_cartItems, _deliveryMethod);

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    AppSnackBar.show(context, message: 'Produkt byl odebrán z košíku', duration: const Duration(seconds: 2));
  }

  bool _validateCardFields() {
    if (_paymentMethod != 'card') return true;

    bool valid = true;
    setState(() {
      _cardNumberError = Validators.cardNumber(_cardNumberController.text);
      _expiryError = Validators.expiry(_expiryController.text);
      _cvcError = Validators.cvc(_cvcController.text);

      if (_cardNumberError != null || _expiryError != null || _cvcError != null) {
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
                child: Icon(Icons.check, size: 32, color: cs.onPrimary),
              ),
              const SizedBox(height: 16),
              Text(
                'Je to tam!',
                style: AppTextStyles.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: cs.onSurface, height: 32 / 24),
              ),
              const SizedBox(height: 8),
              Text(
                'Tvoje objednávka byla úspěšně odeslána.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
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
                  child: Text(
                    'Zobrazit objednávku',
                    style: AppTextStyles.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: cs.onPrimary, letterSpacing: 0.15),
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
    final s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.cart, showBack: true),
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
                              child: Text(
                                'Objednávka zavazující k platbě',
                                style: AppTextStyles.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: cs.onPrimary, letterSpacing: 0.15),
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
            style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: cs.secondary, height: 28 / 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Přidejte produkty do košíku a začněte nakupovat.',
            style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
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
            style: AppTextStyles.pageHeader(cs.secondary),
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
                          style: AppTextStyles.actionLink(cs.secondary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['price']!,
                          style: AppTextStyles.productNewPrice(cs.surfaceTint),
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
            style: AppTextStyles.pageHeader(cs.secondary),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAddressInfo(ColorScheme cs) {
    final addr = _addresses[_selectedAddressIndex];
    final textStyle = AppTextStyles.bodyMedium(cs.secondary);
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
              style: AppTextStyles.actionLink(cs.surfaceTint),
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
                style: AppTextStyles.sectionTitle(cs.onSurface),
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
                                  style: AppTextStyles.labelMedium(cs.onSurface),
                                ),
                                Text(
                                  addr['street']!,
                                  style: AppTextStyles.bodyMedium(cs.secondary),
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
            style: AppTextStyles.bodyMedium(cs.secondary),
          ),
          Text(
            '+420 123 456 789',
            style: AppTextStyles.bodyMedium(cs.secondary),
          ),
          Text(
            'anna.novak@email.cz',
            style: AppTextStyles.bodyMedium(cs.secondary),
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
              style: AppTextStyles.bodyLarge(cs.onSurface),
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
          style: AppTextStyles.bodyLarge(cs.onSurface),
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
                style: AppTextStyles.bodyLarge(cs.onSurface),
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
                style: AppTextStyles.bodyLarge(cs.onSurface),
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
              style: AppTextStyles.bodyMedium(cs.onSurface),
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
                style: AppTextStyles.bodyLarge(cs.onSurface),
              ),
            ),
            Text(
              price,
              style: AppTextStyles.chip(cs.surfaceTint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSummary(ColorScheme cs) {
    final s = AppStrings.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cena celkem',
            style: AppTextStyles.pageHeader(cs.secondary),
          ),
          const SizedBox(height: 16),
          _buildPriceRow(cs, s.productPrice, '$_totalProductPrice €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Cena dopravy', '$_deliveryPrice €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, 'Poplatek za ochranu kupujícího', '$_buyerProtectionFee €', false),
          const SizedBox(height: 8),
          _buildPriceRow(cs, s.totalPrice, '$_totalPrice €', true),
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

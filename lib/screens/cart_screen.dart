import 'package:flutter/material.dart';
import 'package:eqqu/data/mock_orders.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/models/cart_item.dart';
import 'package:eqqu/models/enums.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/screens/order_detail_screen.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/services/cart_service.dart';
import 'package:eqqu/services/validators.dart';
import 'package:eqqu/widgets/price_summary.dart';
import 'package:eqqu/widgets/radio_option.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem>? initialItems;

  const CartScreen({super.key, this.initialItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PaymentMethod _paymentMethod = PaymentMethod.card;
  DeliveryMethod _deliveryMethod = DeliveryMethod.address;
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

  late List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.initialItems != null
        ? List.of(widget.initialItems!)
        : List.of(MockOrders.defaultCartItems);
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
    final s = AppStrings.of(context);
    setState(() {
      _cartItems.removeAt(index);
    });
    AppSnackBar.showError(context, message: s.productRemovedFromCart, duration: const Duration(seconds: 2));
  }

  bool _validateCardFields() {
    if (_paymentMethod != PaymentMethod.card) return true;

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
    final s = AppStrings.of(context);
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
                s.orderSuccess,
                style: AppTextStyles.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: cs.onSurface, height: 32 / 24),
              ),
              const SizedBox(height: 8),
              Text(
                s.orderSuccessMessage,
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
                    s.viewOrder,
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
                        _buildSection(cs, s.deliveryAddress, [
                          _buildAddressInfo(cs),
                        ]),
                        Divider(height: 1, thickness: 1, color: cs.outline),

                        // Personal info
                        _buildSection(cs, s.personalInfo, [
                          _buildPersonalInfo(cs),
                        ]),
                        Divider(height: 1, thickness: 1, color: cs.outline),

                        // Payment method
                        _buildSection(cs, s.paymentMethod, [
                          _buildPaymentOption(cs, PaymentMethod.applePay, 'Apple Pay', Icons.apple),
                          const SizedBox(height: 12),
                          _buildPaymentOption(cs, PaymentMethod.googlePay, 'Google Pay', Icons.g_mobiledata),
                          const SizedBox(height: 12),
                          _buildPaymentOption(cs, PaymentMethod.card, s.cardPayment, Icons.credit_card),
                          if (_paymentMethod == PaymentMethod.card) ...[
                            const SizedBox(height: 16),
                            _buildCardFields(cs),
                          ],
                        ]),
                        Divider(height: 1, thickness: 1, color: cs.outline),

                        // Delivery method
                        _buildSection(cs, s.deliveryMethodLabel, [
                          _buildDeliveryOption(cs, DeliveryMethod.address, s.deliveryToAddress, '2 €'),
                          const SizedBox(height: 12),
                          _buildDeliveryOption(cs, DeliveryMethod.pickup, s.personalPickup, s.free),
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
                                s.bindingOrder,
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
    final s = AppStrings.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: cs.onSurfaceVariant, semanticLabel: s.cartEmpty),
          const SizedBox(height: 16),
          Text(
            s.cartEmpty,
            style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: cs.secondary, height: 28 / 20),
          ),
          const SizedBox(height: 8),
          Text(
            s.addProductsToCart,
            style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(ColorScheme cs) {
    final s = AppStrings.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.productsCount(_cartItems.length),
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
                      item.imageAsset,
                      width: 80,
                      height: 87,
                      cacheWidth: 240,
                      cacheHeight: 261,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: AppTextStyles.actionLink(cs.secondary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.price,
                          style: AppTextStyles.productNewPrice(cs.surfaceTint),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _removeItem(index),
                    icon: Icon(Icons.delete_outline, color: cs.onSurfaceVariant),
                    tooltip: s.delete,
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
    final s = AppStrings.of(context);
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
          Semantics(
            button: true,
            label: s.changeAddress,
            child: GestureDetector(
              onTap: () => _showAddressSheet(),
              child: Text(
                s.changeAddress,
                style: AppTextStyles.actionLink(cs.surfaceTint),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressSheet() {
    final s = AppStrings.of(context);
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
              buildDragHandle(cs),
              Text(
                s.deliveryAddress,
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

  Widget _buildPaymentOption(ColorScheme cs, PaymentMethod value, String label, IconData icon) {
    return RadioOption<PaymentMethod>(
      value: value,
      groupValue: _paymentMethod,
      onChanged: (v) => setState(() => _paymentMethod = v),
      child: Row(
        children: [
          Icon(icon, size: 24, color: cs.onSurface),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.bodyLarge(cs.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildCardFields(ColorScheme cs) {
    final s = AppStrings.of(context);
    return Column(
      children: [
        TextField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          style: AppTextStyles.bodyLarge(cs.onSurface),
          decoration: InputDecoration(
            labelText: s.cardNumber,
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
                  labelText: s.expiry,
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
                  labelText: s.cvcCvv,
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
              s.saveCardForNext,
              style: AppTextStyles.bodyMedium(cs.onSurface),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryOption(ColorScheme cs, DeliveryMethod value, String label, String price) {
    return RadioOption<DeliveryMethod>(
      value: value,
      groupValue: _deliveryMethod,
      onChanged: (v) => setState(() => _deliveryMethod = v),
      child: Row(
        children: [
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
    );
  }

  Widget _buildPriceSummary(ColorScheme cs) {
    final s = AppStrings.of(context);
    return PriceSummary(
      title: s.totalPriceLabel,
      rows: [
        PriceRow(label: s.productPrice, value: '$_totalProductPrice €'),
        PriceRow(label: s.shippingCost, value: '$_deliveryPrice €'),
        PriceRow(label: s.buyerProtectionFee, value: '$_buyerProtectionFee €'),
        PriceRow(label: s.totalPrice, value: '$_totalPrice €', isBold: true),
      ],
    );
  }
}

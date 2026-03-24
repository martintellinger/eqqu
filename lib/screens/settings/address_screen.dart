import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/widgets/app_header.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Anna Novak');
  final _streetController = TextEditingController(text: 'Soukenická 4');
  final _cityController = TextEditingController(text: 'Praha');
  final _zipController = TextEditingController(text: '110 00');
  final _countryController = TextEditingController(text: 'Česká republika');
  bool _hasSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _hasSubmitted = true);

    if (_formKey.currentState!.validate()) {
      final s = AppStrings.of(context);
      AppSnackBar.showSuccess(context, message: s.addressSaved);
      Navigator.pop(context);
    }
  }

  InputDecoration _fieldDecoration(String label, {bool hasTrailing = false}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.labelSmall(cs.onSurfaceVariant),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: cs.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: cs.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: hasTrailing ? Icon(Icons.chevron_right, color: cs.onSurfaceVariant) : null,
    );
  }

  TextStyle get _fieldTextStyle {
    final cs = Theme.of(context).colorScheme;
    return AppTextStyles.bodyLarge(cs.onSurface);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = AppStrings.of(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.address, showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Form(
                key: _formKey,
                autovalidateMode: _hasSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration(s.fullNameLabel),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return s.enterFullName;
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _streetController,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration(s.streetAndNumber),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return s.enterStreetNumber;
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _cityController,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration(s.cityLabel),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return s.enterCity;
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _zipController,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration(s.postalCode),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return s.enterPostalCode;
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _countryController,
                      readOnly: true,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration(s.countryLabel, hasTrailing: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  s.save,
                  style: AppTextStyles.productTitle(cs.onPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

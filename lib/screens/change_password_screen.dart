import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/app_header.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _hasSubmitted = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _hasSubmitted = true);
    if (_formKey.currentState!.validate()) {
      AppSnackBar.show(context, message: 'Heslo bylo změněno');
      Navigator.pop(context);
    }
  }

  InputDecoration _fieldDecoration(ColorScheme cs, String label) {
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
            child: AppHeader(title: 'Změna hesla', showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: _hasSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Změň si heslo',
                        style: AppTextStyles.pageHeader(cs.secondary),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Pro změnu hesla zadej staré heslo a poté nové heslo.',
                        style: AppTextStyles.bodyMedium(cs.secondary),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _oldPasswordController,
                        obscureText: true,
                        style: AppTextStyles.bodyLarge(cs.onSurface),
                        decoration: _fieldDecoration(cs, 'Staré heslo*'),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Zadejte staré heslo';
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _newPasswordController,
                        obscureText: true,
                        style: AppTextStyles.bodyLarge(cs.onSurface),
                        decoration: _fieldDecoration(cs, 'Nové heslo*'),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Zadejte nové heslo';
                          if (v.length < 6) return 'Heslo musí mít alespoň 6 znaků';
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        style: AppTextStyles.bodyLarge(cs.onSurface),
                        decoration: _fieldDecoration(cs, 'Potvrzení nového hesla*'),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Potvrďte nové heslo';
                          if (v != _newPasswordController.text) return 'Hesla se neshodují';
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          onPressed: _save,
                          child: Text(
                            'Uložit',
                            style: AppTextStyles.productTitle(Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

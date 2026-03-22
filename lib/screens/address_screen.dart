import 'package:flutter/material.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Adresa byla uložena',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      Navigator.pop(context);
    }
  }

  InputDecoration _fieldDecoration(String label, {bool hasTrailing = false}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: cs.onSurfaceVariant,
        letterSpacing: 0.4,
      ),
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
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: cs.onSurface,
      letterSpacing: 0.5,
      height: 24 / 16,
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
            child: AppHeader(title: 'Adresa', showBack: true),
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
                      decoration: _fieldDecoration('Jméno a příjmení*'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Zadejte jméno a příjmení';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _streetController,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration('Ulice a čp'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Zadejte ulici a číslo popisné';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _cityController,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration('Město'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Zadejte město';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _zipController,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration('PSČ'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Zadejte PSČ';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _countryController,
                      readOnly: true,
                      style: _fieldTextStyle,
                      decoration: _fieldDecoration('Stát*', hasTrailing: true),
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
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Uložit',
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
    );
  }
}

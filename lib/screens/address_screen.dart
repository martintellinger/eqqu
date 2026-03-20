import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _nameController = TextEditingController(text: 'Anna Novak');
  final _streetController = TextEditingController(text: 'Soukenická 4');
  final _cityController = TextEditingController(text: 'Praha');
  final _zipController = TextEditingController(text: '110 00');
  final _countryController = TextEditingController(text: 'Česká republika');

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    super.dispose();
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
          SafeArea(
            bottom: false,
            child: const AppHeader(title: 'Adresa', showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration('Jméno a příjmení*'),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _streetController,
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration('Ulice a čp'),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _cityController,
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration('Město'),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _zipController,
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration('PSČ'),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
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
                    height: 24 / 16,
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

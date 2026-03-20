import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _emailController = TextEditingController(text: 'example@gmail.com');
  final _usernameController = TextEditingController(text: 'anna.novak');
  final _nameController = TextEditingController(text: 'Anna Novak');
  final _countryController = TextEditingController(text: 'Česká republika');
  final _birthdateController = TextEditingController(text: '14.5.2000');
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController(text: 'Soukenická 43, Praha 110 00');
  final _phoneController = TextEditingController(text: '+420 123 456 789');
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    _countryController.dispose();
    _birthdateController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String label, {bool enabled = true, bool hasTrailing = false}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: enabled ? cs.onSurfaceVariant : cs.onSurface.withOpacity(0.38),
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
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: cs.onSurface.withOpacity(0.1)),
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
            child: const AppHeader(title: 'Nastavení účtu', showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar section
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.asset(
                              'assets/images/avatar_1.png',
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: -4,
                            bottom: -4,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: cs.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Form fields
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          enabled: false,
                          style: _fieldTextStyle.copyWith(color: cs.onSurface.withOpacity(0.38)),
                          decoration: _fieldDecoration('E-mail*', enabled: false),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _usernameController,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Uživatelské jméno*'),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _nameController,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Jméno a příjmení*'),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _countryController,
                          readOnly: true,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Stát*', hasTrailing: true),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _birthdateController,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Datum narození*'),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 120,
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Popis'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _addressController,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Adresa*'),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _phoneController,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Telefonní číslo*'),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Password change section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Změna hesla',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: cs.secondary,
                            height: 28 / 20,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _oldPasswordController,
                          obscureText: true,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Staré heslo'),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _newPasswordController,
                          obscureText: true,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Nové heslo'),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          style: _fieldTextStyle,
                          decoration: _fieldDecoration('Potvrzení nového hesla'),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, thickness: 1, color: cs.outline),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: FilledButton(
                            onPressed: null, // Disabled by default
                            style: FilledButton.styleFrom(
                              backgroundColor: cs.primary,
                              disabledBackgroundColor: cs.onSurface.withOpacity(0.1),
                              disabledForegroundColor: cs.onSurface.withOpacity(0.38),
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
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: TextButton(
                            onPressed: () => _showDeleteDialog(),
                            child: Text(
                              'Smazat účet',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFCE0101),
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
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF7F7F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Smazat profil?',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: cs.onSurface,
            height: 32 / 24,
          ),
        ),
        content: Text(
          'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.onSurfaceVariant,
            letterSpacing: 0.25,
            height: 20 / 14,
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: cs.outlineVariant),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              'Zrušit',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: cs.onSurfaceVariant,
                letterSpacing: 0.1,
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFCE0101),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text(
              'Smazat',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

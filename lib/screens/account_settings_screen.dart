import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/utils/blur_overlay.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
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

  bool _isDirty = false;
  bool _hasSubmitted = false;

  // Store initial values to detect changes
  late final Map<String, String> _initialValues;

  @override
  void initState() {
    super.initState();
    _initialValues = {
      'username': _usernameController.text,
      'name': _nameController.text,
      'country': _countryController.text,
      'birthdate': _birthdateController.text,
      'description': _descriptionController.text,
      'address': _addressController.text,
      'phone': _phoneController.text,
    };

    for (final c in [
      _usernameController, _nameController, _countryController,
      _birthdateController, _descriptionController, _addressController,
      _phoneController, _oldPasswordController, _newPasswordController,
      _confirmPasswordController,
    ]) {
      c.addListener(_checkDirty);
    }
  }

  void _checkDirty() {
    final dirty = _usernameController.text != _initialValues['username'] ||
        _nameController.text != _initialValues['name'] ||
        _countryController.text != _initialValues['country'] ||
        _birthdateController.text != _initialValues['birthdate'] ||
        _descriptionController.text != _initialValues['description'] ||
        _addressController.text != _initialValues['address'] ||
        _phoneController.text != _initialValues['phone'] ||
        _oldPasswordController.text.isNotEmpty ||
        _newPasswordController.text.isNotEmpty ||
        _confirmPasswordController.text.isNotEmpty;
    if (dirty != _isDirty) {
      setState(() => _isDirty = dirty);
    }
  }

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

  void _save() {
    setState(() => _hasSubmitted = true);

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Změny byly uloženy',
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

  InputDecoration _fieldDecoration(String label, {bool enabled = true, bool hasTrailing = false}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: enabled ? cs.onSurfaceVariant : cs.onSurface.withValues(alpha: 0.38),
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
        borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.1)),
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
              child: Form(
                key: _formKey,
                autovalidateMode: _hasSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar section
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          width: 148,
                          height: 148,
                          child: Stack(
                            clipBehavior: Clip.none,
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
                                right: 0,
                                bottom: 0,
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
                    ),

                    // Form fields
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            enabled: false,
                            style: _fieldTextStyle.copyWith(color: cs.onSurface.withValues(alpha: 0.38)),
                            decoration: _fieldDecoration('E-mail*', enabled: false),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _usernameController,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Uživatelské jméno*'),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Zadejte uživatelské jméno';
                              if (v.trim().length < 3) return 'Minimálně 3 znaky';
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
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
                          TextField(
                            controller: _countryController,
                            readOnly: true,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Stát*', hasTrailing: true),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _birthdateController,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Datum narození*'),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Zadejte datum narození';
                              return null;
                            },
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
                          TextFormField(
                            controller: _addressController,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Adresa*'),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Zadejte adresu';
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _phoneController,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Telefonní číslo*'),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Zadejte telefonní číslo';
                              return null;
                            },
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
                          TextFormField(
                            controller: _oldPasswordController,
                            obscureText: true,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Staré heslo'),
                            validator: (v) {
                              // Only validate if user is trying to change password
                              if (_newPasswordController.text.isNotEmpty &&
                                  (v == null || v.isEmpty)) {
                                return 'Zadejte staré heslo';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: true,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Nové heslo'),
                            validator: (v) {
                              if (_oldPasswordController.text.isNotEmpty) {
                                if (v == null || v.isEmpty) return 'Zadejte nové heslo';
                                if (v.length < 6) return 'Heslo musí mít alespoň 6 znaků';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration('Potvrzení nového hesla'),
                            validator: (v) {
                              if (_newPasswordController.text.isNotEmpty) {
                                if (v == null || v.isEmpty) return 'Potvrďte nové heslo';
                                if (v != _newPasswordController.text) return 'Hesla se neshodují';
                              }
                              return null;
                            },
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
                              onPressed: _isDirty ? _save : null,
                              style: FilledButton.styleFrom(
                                backgroundColor: cs.primary,
                                disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.1),
                                disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
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
                                  color: cs.error,
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
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    final cs = Theme.of(context).colorScheme;
    showBlurDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: cs.surfaceContainerHigh,
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
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(dialogCtx),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cs.outlineVariant),
                  minimumSize: const Size(0, 48),
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
                  Navigator.pop(dialogCtx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Účet byl smazán',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      backgroundColor: cs.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  );
                  Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: cs.error,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text(
                  'Smazat',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

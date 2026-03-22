import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/main.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/screens/account_settings_screen.dart';
import 'package:eqqu/screens/shipping_screen.dart';
import 'package:eqqu/screens/secure_account_screen.dart';
import 'package:eqqu/screens/notifications_screen.dart';

import 'package:eqqu/utils/language_notifier.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_onChanged);
    languageNotifier.addListener(_onChanged);
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onChanged);
    languageNotifier.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() => setState(() {});

  void _showAppearanceSheet(ColorScheme cs) {
    ThemeMode selected = themeNotifier.themeMode;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      barrierColor: kBlurBarrierColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                  'Vzhled',
                  style: AppTextStyles.sectionTitle(cs.onSurface),
                ),
                const SizedBox(height: 16),
                _buildThemeOption(cs, ThemeMode.light, 'Light mode', selected, (mode) {
                  setSheetState(() => selected = mode);
                  themeNotifier.setThemeMode(mode);
                }),
                const SizedBox(height: 12),
                _buildThemeOption(cs, ThemeMode.dark, 'Dark mode', selected, (mode) {
                  setSheetState(() => selected = mode);
                  themeNotifier.setThemeMode(mode);
                }),
                const SizedBox(height: 12),
                _buildThemeOption(cs, ThemeMode.system, 'Podle systému', selected, (mode) {
                  setSheetState(() => selected = mode);
                  themeNotifier.setThemeMode(mode);
                }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageSheet(ColorScheme cs) {
    String selected = languageNotifier.selectedCode;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      barrierColor: kBlurBarrierColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                  'Jazyk',
                  style: AppTextStyles.sectionTitle(cs.onSurface),
                ),
                const SizedBox(height: 16),
                ...LanguageNotifier.languages.map((lang) {
                  final isSelected = lang.code == selected;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildLanguageOption(cs, lang, isSelected, (code) {
                      setSheetState(() => selected = code);
                      languageNotifier.setLanguage(code);
                    }),
                  );
                }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(ColorScheme cs, Language lang, bool isSelected, ValueChanged<String> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(lang.code),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? cs.surfaceTint : cs.outlineVariant,
            width: isSelected ? 2 : 1,
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
                  color: isSelected ? cs.surfaceTint : cs.outlineVariant,
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              lang.flag,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 12),
            Text(
              lang.name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? cs.surfaceTint : cs.onSurface,
                letterSpacing: 0.5,
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(ColorScheme cs, ThemeMode mode, String label, ThemeMode selected, ValueChanged<ThemeMode> onChanged) {
    final isSelected = selected == mode;
    return GestureDetector(
      onTap: () => onChanged(mode),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? cs.surfaceTint : cs.outlineVariant,
            width: isSelected ? 2 : 1,
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
                  color: isSelected ? cs.surfaceTint : cs.outlineVariant,
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? cs.surfaceTint : cs.onSurface,
                letterSpacing: 0.5,
                height: 24 / 16,
              ),
            ),
          ],
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
            child: const AppHeader(title: 'Nastavení', showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildMenuItem(
                      cs,
                      Icons.person_outline,
                      'Nastavení účtu',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountSettingsScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.account_balance_wallet_outlined,
                      'Platby',
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.local_shipping_outlined,
                      'Přeprava',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.shield_outlined,
                      'Bezpečný účet',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const SecureAccountScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.notifications_outlined,
                      'Oznámení',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.language,
                      'Jazyk',
                      trailingText: '${languageNotifier.selected.flag} ${languageNotifier.selected.name}',
                      onTap: () => _showLanguageSheet(cs),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.palette_outlined,
                      'Vzhled',
                      trailingText: themeNotifier.label,
                      onTap: () => _showAppearanceSheet(cs),
                    ),
                    const SizedBox(height: 24),
                    _buildLogoutButton(cs),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    ColorScheme cs,
    IconData icon,
    String label, {
    String? trailingText,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 24, color: cs.onSurface),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.bodyLarge(cs.onSurface),
                  ),
                ),
                if (trailingText != null) ...[
                  Text(
                    trailingText,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: cs.surfaceTint,
                      letterSpacing: 0.1,
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Icon(Icons.chevron_right, size: 20, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(ColorScheme cs) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 24, color: cs.secondary),
            const SizedBox(width: 8),
            Text(
              'Odhlásit se',
              style: AppTextStyles.productTitle(cs.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

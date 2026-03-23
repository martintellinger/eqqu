import 'package:flutter/material.dart';
import 'package:eqqu/routes.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/app_state.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/screens/account_settings_screen.dart';
import 'package:eqqu/screens/shipping_screen.dart';
import 'package:eqqu/screens/secure_account_screen.dart';
import 'package:eqqu/screens/notifications_screen.dart';
import 'package:eqqu/utils/language_notifier.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Listeners attached in didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = AppState.of(context);
    appState.themeNotifier.addListener(_onChanged);
    appState.languageNotifier.addListener(_onChanged);
  }

  @override
  void dispose() {
    // Note: listeners are cleaned up when the notifier is disposed
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  void _showAppearanceSheet(ColorScheme cs) {
    ThemeMode selected = AppState.of(context).themeNotifier.themeMode;
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
                buildDragHandle(cs),
                Text(
                  AppStrings.of(context).appearance,
                  style: AppTextStyles.sectionTitle(cs.onSurface),
                ),
                const SizedBox(height: 16),
                _buildThemeOption(cs, ThemeMode.light, AppStrings.of(context).lightMode, selected, (mode) {
                  setSheetState(() => selected = mode);
                  AppState.of(context).themeNotifier.setThemeMode(mode);
                }),
                const SizedBox(height: 12),
                _buildThemeOption(cs, ThemeMode.dark, AppStrings.of(context).darkMode, selected, (mode) {
                  setSheetState(() => selected = mode);
                  AppState.of(context).themeNotifier.setThemeMode(mode);
                }),
                const SizedBox(height: 12),
                _buildThemeOption(cs, ThemeMode.system, AppStrings.of(context).systemMode, selected, (mode) {
                  setSheetState(() => selected = mode);
                  AppState.of(context).themeNotifier.setThemeMode(mode);
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
    final langNotifier = AppState.of(context).languageNotifier;
    String selected = langNotifier.selectedCode;
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
                buildDragHandle(cs),
                Text(
                  AppStrings.of(context).language,
                  style: AppTextStyles.sectionTitle(cs.onSurface),
                ),
                const SizedBox(height: 16),
                ...LanguageNotifier.languages.map((lang) {
                  final isSelected = lang.code == selected;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildLanguageOption(cs, lang, isSelected, (code) {
                      setSheetState(() => selected = code);
                      langNotifier.setLanguage(code);
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
              style: AppTextStyles.selectableOption(
                color: isSelected ? cs.surfaceTint : cs.onSurface,
                isSelected: isSelected,
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
              style: AppTextStyles.selectableOption(
                color: isSelected ? cs.surfaceTint : cs.onSurface,
                isSelected: isSelected,
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
    final s = AppStrings.of(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.settings, showBack: true),
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
                      s.accountSettings,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountSettingsScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.account_balance_wallet_outlined,
                      s.payments,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.local_shipping_outlined,
                      s.shipping,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.shield_outlined,
                      s.secureAccount,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const SecureAccountScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.notifications_outlined,
                      s.notifications,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.language,
                      s.language,
                      trailingText: '${AppState.of(context).languageNotifier.selected.flag} ${AppState.of(context).languageNotifier.selected.name}',
                      onTap: () => _showLanguageSheet(cs),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.palette_outlined,
                      s.appearance,
                      trailingText: AppState.of(context).themeNotifier.label,
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
                    style: AppTextStyles.chip(cs.surfaceTint),
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
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
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
              AppStrings.of(context).logout,
              style: AppTextStyles.productTitle(cs.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

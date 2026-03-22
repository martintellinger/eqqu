import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/app_state.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/theme/app_text_styles.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late ThemeMode _selected;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selected = AppState.of(context).themeNotifier.themeMode;
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
            child: AppHeader(title: s.appearance, showBack: true),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOption(cs, ThemeMode.light, s.lightMode),
                const SizedBox(height: 16),
                _buildOption(cs, ThemeMode.dark, s.darkMode),
                const SizedBox(height: 16),
                _buildOption(cs, ThemeMode.system, s.systemMode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(ColorScheme cs, ThemeMode mode, String label) {
    final selected = _selected == mode;
    return GestureDetector(
      onTap: () {
        setState(() => _selected = mode);
        AppState.of(context).themeNotifier.setThemeMode(mode);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? cs.surfaceTint : cs.outlineVariant,
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
                  color: selected ? cs.surfaceTint : cs.outlineVariant,
                  width: selected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.poppins(
                fontSize: 16,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? cs.surfaceTint : cs.onSurface,
                letterSpacing: 0.5,
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

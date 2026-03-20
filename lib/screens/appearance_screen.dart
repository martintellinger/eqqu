import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/main.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late ThemeMode _selected;

  @override
  void initState() {
    super.initState();
    _selected = themeNotifier.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: const AppHeader(title: 'Vzhled', showBack: true),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOption(cs, ThemeMode.light, 'Light mode'),
                const SizedBox(height: 16),
                _buildOption(cs, ThemeMode.dark, 'Dark mode'),
                const SizedBox(height: 16),
                _buildOption(cs, ThemeMode.system, 'Podle systému'),
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
        themeNotifier.setThemeMode(mode);
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
              style: TextStyle(
                fontFamily: 'Poppins',
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

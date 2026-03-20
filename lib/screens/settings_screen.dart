import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/main.dart';
import 'package:eqqu/screens/appearance_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});

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
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.shield_outlined,
                      'Bezpečný účet',
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.notifications_outlined,
                      'Oznámení',
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.language,
                      'Jazyk',
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      cs,
                      Icons.palette_outlined,
                      'Vzhled',
                      trailingText: themeNotifier.label,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AppearanceScreen(),
                          ),
                        );
                      },
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
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: cs.onSurface,
                      letterSpacing: 0.5,
                      height: 24 / 16,
                    ),
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
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cs.secondary,
                letterSpacing: 0.15,
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

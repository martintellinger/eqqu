import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/screens/change_password_screen.dart';
import 'package:eqqu/screens/login_overview_screen.dart';

class SecureAccountScreen extends StatelessWidget {
  const SecureAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            bottom: false,
            child: AppHeader(title: 'Bezpečný účet', showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Zabezpeč si účet',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: cs.secondary,
                            height: 28 / 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Zkontroluj si své údaje, pomůžeš tím svůj účet ochránit.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: cs.secondary,
                            letterSpacing: 0.25,
                            height: 20 / 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildSecurityItem(
                          cs,
                          'E-mail',
                          'Vždy používej aktuální e-mail',
                          Icons.email_outlined,
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        _buildSecurityItem(
                          cs,
                          'Heslo',
                          'Chraň svůj účet silnějším heslem',
                          Icons.lock_outlined,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePasswordScreen()));
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildSecurityItem(
                          cs,
                          'Přehled přihlášení',
                          'Spravuj přihlašená zařízení',
                          Icons.devices_outlined,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginOverviewScreen()));
                          },
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

  Widget _buildSecurityItem(
    ColorScheme cs,
    String title,
    String subtitle,
    IconData icon, {
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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 24, color: cs.onSurface),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurface,
                          letterSpacing: 0.5,
                          height: 24 / 16,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurfaceVariant,
                          letterSpacing: 0.25,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, size: 20, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/app_header.dart';

class LoginOverviewScreen extends StatelessWidget {
  const LoginOverviewScreen({super.key});

  static const _sessions = [
    {
      'device': 'iPhone 15 Pro',
      'os': 'iOS 18.1',
      'date': '21.03.2026 10:32',
      'current': true,
    },
    {
      'device': 'MacBook Pro',
      'os': 'macOS 15.3',
      'date': '20.03.2026 18:45',
      'current': false,
    },
    {
      'device': 'Chrome – Windows',
      'os': 'Windows 11',
      'date': '18.03.2026 09:12',
      'current': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            bottom: false,
            child: AppHeader(title: 'Přehled přihlášení', showBack: true),
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
                          'Přihlášená zařízení',
                          style: AppTextStyles.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: cs.secondary, height: 28 / 20),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Zkontroluj si zařízení, na kterých jsi přihlášený/á.',
                          style: AppTextStyles.bodyMedium(cs.secondary),
                        ),
                      ],
                    ),
                  ),
                  ..._sessions.map((s) => _buildSessionItem(cs, s)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItem(ColorScheme cs, Map<String, dynamic> session) {
    final isCurrent = session['current'] as bool;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            session['device'].toString().contains('iPhone')
                ? Icons.phone_iphone
                : session['device'].toString().contains('Mac')
                    ? Icons.laptop_mac
                    : Icons.computer,
            size: 32,
            color: cs.onSurface,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        session['device'] as String,
                        style: AppTextStyles.labelMedium(cs.onSurface),
                      ),
                    ),
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: cs.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Aktuální',
                          style: AppTextStyles.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.4),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${session['os']} • ${session['date']}',
                  style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

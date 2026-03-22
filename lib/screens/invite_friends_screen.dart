import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/widgets/app_header.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = AppStrings.of(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.inviteFriends, showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pozvěte své přátele do EQQU – nejlepší aplikace pro nákup jezdeckých potřeb, kde najdete vše pro vašeho koně na jednom místě.',
                    style: AppTextStyles.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: cs.secondary, height: 32 / 24),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Přidejte se k EQQU a objevte široký výběr kvalitních potřeb pro koně. Pozvěte přátele a užijte si pohodlný nákup s odbornou podporou přímo v aplikaci.',
                    style: AppTextStyles.bodyLarge(cs.secondary),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/product_04.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Floating button at bottom
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Odkaz byl zkopírován do schránky')),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Sdílet odkaz',
                    style: AppTextStyles.productTitle(Colors.white),
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

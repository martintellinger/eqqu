import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/app_header.dart';

class MimoStajScreen extends StatefulWidget {
  const MimoStajScreen({super.key});

  @override
  State<MimoStajScreen> createState() => _MimoStajScreenState();
}

class _MimoStajScreenState extends State<MimoStajScreen> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            bottom: false,
            child: AppHeader(title: 'Mimo stáj', showBack: true),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                    style: AppTextStyles.bodyLarge(cs.secondary),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mimo stáj',
                            style: AppTextStyles.labelMedium(cs.secondary),
                          ),
                        ),
                        Switch(
                          value: _enabled,
                          onChanged: (v) {
                            setState(() => _enabled = v);
                            AppSnackBar.show(context, message: v ? 'Mimo stáj zapnuto' : 'Mimo stáj vypnuto', duration: const Duration(seconds: 2));
                          },
                          activeColor: Colors.white,
                          activeTrackColor: cs.primary,
                          inactiveThumbColor: cs.onSurfaceVariant,
                          inactiveTrackColor: cs.surfaceContainerHighest,
                          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) return Colors.transparent;
                            return cs.onSurfaceVariant;
                          }),
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
}

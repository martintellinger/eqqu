import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/app_header.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushEnabled = true;
  bool _emailEnabled = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = AppStrings.of(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.notifications, showBack: true),
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
                  _buildToggleItem(
                    cs,
                    'Push-notifikace',
                    _pushEnabled,
                    (v) {
                      setState(() => _pushEnabled = v);
                      _onToggleChanged('Push-notifikace', v);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildToggleItem(
                    cs,
                    'E-mailové notifikace',
                    _emailEnabled,
                    (v) {
                      setState(() => _emailEnabled = v);
                      _onToggleChanged('E-mailové notifikace', v);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onToggleChanged(String label, bool value) {
    AppSnackBar.show(context, message: value ? '$label zapnuto' : '$label vypnuto', duration: const Duration(seconds: 2));
  }

  Widget _buildToggleItem(ColorScheme cs, String label, bool value, ValueChanged<bool> onChanged) {
    return Container(
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
              label,
              style: AppTextStyles.labelMedium(cs.secondary),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
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
    );
  }
}

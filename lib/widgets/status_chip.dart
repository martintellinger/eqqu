import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;

  const StatusChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.backgroundColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 8, right: 16, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: backgroundColor == null ? Border.all(color: cs.outline) : null,
        borderRadius: BorderRadius.circular(8),
        boxShadow: boxShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.chip(color),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';

class FilterChipBar extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FilterChipBar({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: List.generate(filters.length, (i) {
          final selected = selectedIndex == i;
          return Padding(
            padding: EdgeInsets.only(right: i < filters.length - 1 ? 8 : 0),
            child: _buildChip(cs, filters[i], selected, () => onSelected(i)),
          );
        }),
      ),
    );
  }

  Widget _buildChip(ColorScheme cs, String label, bool selected, VoidCallback onTap) {
    return Semantics(
      label: label,
      selected: selected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        height: 32,
        padding: EdgeInsets.only(
          left: selected ? 8 : 16,
          right: 16,
          top: 6,
          bottom: 6,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.primary : Colors.transparent,
          border: selected ? null : Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Icon(Icons.check, size: 18, color: cs.onPrimary),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: AppTextStyles.chip(selected ? cs.onPrimary : cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

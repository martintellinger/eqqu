import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';

/// Drag handle at top of bottom sheets.
Widget buildDragHandle(ColorScheme cs) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    width: 40,
    height: 4,
    decoration: BoxDecoration(
      color: cs.onSurface.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(2),
    ),
  );
}

/// Sheet header with back arrow and centered title.
Widget buildSheetHeader(BuildContext context, ColorScheme cs, String title, {VoidCallback? onBack}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 48),
      ],
    ),
  );
}

/// App bar with back arrow, centered title, and trash icon.
Widget buildFilterAppBar(ColorScheme cs, String title, {
  required VoidCallback onBack,
  required VoidCallback onClear,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: onBack,
        ),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete_outline, color: cs.onSurface),
          onPressed: onClear,
        ),
      ],
    ),
  );
}

/// List tile with checkmark for filter selection.
Widget buildCheckListTile(ColorScheme cs, String label, bool isSelected, {
  required VoidCallback onTap,
  Widget? leading,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.outlineVariant, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyLarge(cs.onSurface),
            ),
          ),
          if (isSelected)
            Icon(Icons.check_circle, color: cs.primary, size: 20),
        ],
      ),
    ),
  );
}

/// Navigation tile in main filter sheet (label + value text + chevron).
Widget buildFilterNavTile(ColorScheme cs, String label, String? value, {required VoidCallback onTap}) {
  return ListTile(
    title: Text(
      label,
      style: AppTextStyles.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: cs.onSurface,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null && value.isNotEmpty)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(
              value,
              style: AppTextStyles.bodyMedium(cs.surfaceTint),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        const SizedBox(width: 4),
        Icon(Icons.chevron_right, color: cs.onSurface, size: 24),
      ],
    ),
    onTap: onTap,
  );
}

/// Green save button at bottom of sheets.
Widget buildSaveButton(ColorScheme cs, BuildContext context, String label, {required VoidCallback onPressed}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).viewPadding.bottom + 12),
    child: SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: cs.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label),
      ),
    ),
  );
}

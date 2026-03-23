import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';

/// Shows the report selection bottom sheet with 3 radio options.
/// Options 0 and 1 submit immediately with a snackbar confirmation.
/// Option 2 ("Something else") opens a dialog for a custom description.
void showReportSelectionSheet(BuildContext context) {
  final s = AppStrings.of(context);
  final cs = Theme.of(context).colorScheme;
  int selectedReason = -1;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: cs.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => StatefulBuilder(
      builder: (ctx, setSheetState) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: buildDragHandle(cs)),
              Text(
                s.reportReason,
                style: AppTextStyles.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                  height: 32 / 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit.',
                style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              _buildRadioOption(
                cs, 0, selectedReason, s.scamOrSpam,
                (val) => setSheetState(() => selectedReason = val),
              ),
              _buildRadioOption(
                cs, 1, selectedReason, s.offensiveText,
                (val) => setSheetState(() => selectedReason = val),
              ),
              _buildRadioOption(
                cs, 2, selectedReason, s.somethingElse,
                (val) => setSheetState(() => selectedReason = val),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: selectedReason >= 0
                      ? () {
                          Navigator.pop(ctx);
                          if (selectedReason == 2) {
                            _showReportReasonDialog(context);
                          } else {
                            AppSnackBar.show(context, message: s.reportSent);
                          }
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    disabledBackgroundColor: cs.primary.withAlpha(100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    s.send,
                    style: AppTextStyles.labelMedium(cs.onPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildRadioOption(
  ColorScheme cs,
  int value,
  int groupValue,
  String label,
  ValueChanged<int> onChanged,
) {
  final selected = value == groupValue;
  return GestureDetector(
    onTap: () => onChanged(value),
    child: SizedBox(
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.poppins(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? cs.surfaceTint : cs.onSurface,
                letterSpacing: 0.25,
                height: 20 / 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
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
        ],
      ),
    ),
  );
}

void _showReportReasonDialog(BuildContext context) {
  final s = AppStrings.of(context);
  final cs = Theme.of(context).colorScheme;
  final controller = TextEditingController();

  showBlurDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setDialogState) {
        final hasText = controller.text.trim().isNotEmpty;
        return Dialog(
          backgroundColor: cs.surfaceContainerHigh,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.reportReason,
                  style: AppTextStyles.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: cs.onSurface,
                    height: 32 / 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit',
                  style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  maxLines: 5,
                  onChanged: (_) => setDialogState(() {}),
                  decoration: InputDecoration(
                    hintText: s.describeReason,
                    hintStyle: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: cs.outlineVariant),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: cs.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: cs.primary),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: AppTextStyles.bodyMedium(cs.onSurface),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: cs.outlineVariant),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          s.cancel,
                          style: AppTextStyles.chip(cs.onSurfaceVariant),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: hasText
                            ? () {
                                Navigator.pop(ctx);
                                AppSnackBar.show(context, message: s.reportSent);
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: cs.secondaryContainer,
                          disabledBackgroundColor: cs.secondaryContainer.withAlpha(100),
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          s.send,
                          style: AppTextStyles.chip(
                            hasText ? cs.onSecondaryContainer : cs.onSecondaryContainer.withAlpha(100),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

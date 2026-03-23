import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';

class AppSnackBar {
  AppSnackBar._();

  /// Neutral snackbar – black background, white text.
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: AppTextStyles.snackBarMessage(),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: backgroundColor ?? Colors.black,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: duration,
      ),
    );
  }

  /// Destructive / error snackbar – red from design system.
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Theme.of(context).colorScheme.error,
      duration: duration,
    );
  }

  /// Positive / success snackbar – green (primary) from design system.
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: duration,
    );
  }
}

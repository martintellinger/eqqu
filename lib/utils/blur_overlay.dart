import 'dart:ui';
import 'package:flutter/material.dart';

/// Shows a dialog with a blurred background overlay.
Future<T?> showBlurDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (ctx, animation, secondaryAnimation) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withValues(alpha: 0.3),
            alignment: Alignment.center,
            child: builder(ctx),
          ),
        ),
      );
    },
  );
}

/// Barrier color for blurred bottom sheets - semi-transparent for visual depth.
const kBlurBarrierColor = Color(0x26000000); // ~15% black

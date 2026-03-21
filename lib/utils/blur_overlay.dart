import 'dart:ui';
import 'package:flutter/material.dart';

/// Shows a dialog with a blurred background overlay.
Future<T?> showBlurDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.transparent,
    builder: (ctx) {
      return Stack(
        children: [
          // Full-screen blur layer
          Positioned.fill(
            child: GestureDetector(
              onTap: barrierDismissible ? () => Navigator.pop(ctx) : null,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withValues(alpha: 0.15)),
              ),
            ),
          ),
          // Dialog on top
          builder(ctx),
        ],
      );
    },
  );
}

/// Barrier color for blurred bottom sheets - semi-transparent for visual depth.
const kBlurBarrierColor = Color(0x26000000); // ~15% black

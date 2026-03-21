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

/// Shows a modal bottom sheet with a blurred background overlay.
Future<T?> showBlurBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  ShapeBorder? shape,
  bool isScrollControlled = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    builder: (ctx) {
      final effectiveBg = backgroundColor ?? Theme.of(ctx).colorScheme.surface;
      final effectiveShape = shape ?? const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      );
      return Stack(
        children: [
          // Full-screen blur barrier
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(ctx),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withValues(alpha: 0.15)),
              ),
            ),
          ),
          // Bottom sheet content
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: effectiveBg,
              shape: effectiveShape,
              clipBehavior: Clip.antiAlias,
              child: builder(ctx),
            ),
          ),
        ],
      );
    },
  );
}

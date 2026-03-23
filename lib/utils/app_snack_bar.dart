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
    final bg = backgroundColor ?? Colors.black;
    _showAnimated(context, message: message, backgroundColor: bg, duration: duration);
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

  static void _showAnimated(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Duration duration,
  }) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _AnimatedSnackBar(
        message: message,
        backgroundColor: backgroundColor,
        duration: duration,
        onDismissed: () => entry.remove(),
      ),
    );
    Overlay.of(context).insert(entry);
  }
}

class _AnimatedSnackBar extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Duration duration;
  final VoidCallback onDismissed;

  const _AnimatedSnackBar({
    required this.message,
    required this.backgroundColor,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
    Future.delayed(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (!mounted) return;
    _controller.reverse().then((_) {
      if (mounted) widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomPadding + 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.message,
                  style: AppTextStyles.snackBarMessage(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

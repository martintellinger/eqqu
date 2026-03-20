import 'package:flutter/material.dart';

/// Shared app header matching the Figma M3 App bar (Small, Flat).
///
/// Height 64px, bottom border, centered title (Poppins Regular 20px).
/// Supports optional leading icon (back button), subtitle, and trailing widget.
class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? trailing;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Leading icon
                if (showBack)
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: cs.onSurface),
                      onPressed: onBack ?? () => Navigator.pop(context),
                    ),
                  ),

                // Centered title (+ optional subtitle)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 52),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurface,
                          height: 28 / 20,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurfaceVariant,
                            letterSpacing: 0.5,
                            height: 16 / 12,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                    ],
                  ),
                ),

                // Trailing widget
                if (trailing != null)
                  Positioned(
                    right: 0,
                    child: trailing!,
                  ),
              ],
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: cs.outline),
      ],
    );
  }
}

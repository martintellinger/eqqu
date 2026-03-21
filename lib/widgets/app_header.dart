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
  final VoidCallback? onSubtitleTap;
  final Widget? trailing;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.onSubtitleTap,
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
            child: Row(
              children: [
                // Leading icon (fixed 48px slot)
                if (showBack)
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: cs.onSurface),
                    onPressed: onBack ?? () => Navigator.pop(context),
                  )
                else
                  const SizedBox(width: 48),

                // Centered title fills remaining space
                Expanded(
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
                        GestureDetector(
                          onTap: onSubtitleTap,
                          child: Text(
                            subtitle!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: onSubtitleTap != null ? cs.surfaceTint : cs.onSurfaceVariant,
                              letterSpacing: 0.5,
                              height: 16 / 12,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                    ],
                  ),
                ),

                // Trailing widget (fixed 48px slot)
                if (trailing != null)
                  trailing!
                else
                  const SizedBox(width: 48),
              ],
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: cs.outline),
      ],
    );
  }
}

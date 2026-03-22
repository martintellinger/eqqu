import 'package:flutter/material.dart';

/// Centralized text styles used across the app.
///
/// All styles accept a [ColorScheme] so they adapt to light/dark mode.
/// Use these instead of inline TextStyle definitions.
class AppTextStyles {
  AppTextStyles._();

  // ── Poppins helpers ──

  static TextStyle poppins({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle outfit({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  // ── Product card styles ──

  static TextStyle productTitle(Color color) => poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.15,
    height: 24 / 16,
  );

  static TextStyle productSubtitle(Color color) => poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: 0.25,
    height: 20 / 14,
  );

  static TextStyle productOldPrice(Color color) => poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: 0.4,
    height: 16 / 12,
  );

  static TextStyle productNewPrice(Color color) => poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.5,
    height: 24 / 16,
  );

  static TextStyle productBadge(Color color) => poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.25,
    height: 20 / 14,
  );

  // ── Section headers ──

  static TextStyle sectionTitle(Color color) => outfit(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: color,
    height: 28 / 20,
  );

  // ── Body text ──

  static TextStyle bodyMedium(Color color) => poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: 0.25,
    height: 20 / 14,
  );

  static TextStyle bodyLarge(Color color) => poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: 0.5,
    height: 24 / 16,
  );

  static TextStyle labelMedium(Color color) => poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 0.15,
    height: 24 / 16,
  );

  static TextStyle labelSmall(Color color) => poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: 0.4,
    height: 16 / 12,
  );

  // ── Links / actions ──

  static TextStyle actionLink(Color color) => poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.1,
    height: 20 / 14,
  );

  // ── Nav bar ──

  static TextStyle navLabel({
    required Color color,
    required bool isActive,
  }) => poppins(
    fontSize: 12,
    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
    color: color,
    letterSpacing: 0.5,
    height: 16 / 12,
  );

  // ── Chip ──

  static TextStyle chip(Color color) => poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 0.1,
    height: 20 / 14,
  );
}

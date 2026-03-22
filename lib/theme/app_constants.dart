import 'package:flutter/material.dart';

/// Centralized spacing, sizing, and dimension constants.
class AppConstants {
  AppConstants._();

  // ── Spacing ──
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;
  static const double spacingXl = 24;
  static const double spacingXxl = 32;

  // ── Border radius ──
  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusLg = 16;
  static const double radiusXl = 28;
  static const double radiusPill = 1000;

  static final BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);

  // ── Sizes ──
  static const double buttonHeight = 56;
  static const double appBarHeight = 64;
  static const double iconSizeSm = 16;
  static const double iconSizeMd = 20;
  static const double iconSizeLg = 24;
  static const double iconSizeXl = 32;
  static const double avatarSizeSm = 40;
  static const double avatarSizeMd = 64;
  static const double avatarSizeLg = 80;

  // ── Product card ──
  static const double productCardAspectRatio = 177 / 200;

  // ── Bottom sheet ──
  static const double dragHandleWidth = 32;
  static const double dragHandleHeight = 4;

  // ── Durations ──
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animMedium = Duration(milliseconds: 300);
  static const Duration animSlow = Duration(milliseconds: 350);

  // ── Colors (non-theme) ──
  static const Color starColor = Color(0xFFFFD700);
}

/// Common product image paths.
const kProductImages = [
  'assets/images/product_01.png',
  'assets/images/product_02.png',
  'assets/images/product_03.png',
  'assets/images/product_04.png',
  'assets/images/product_05.png',
  'assets/images/product_06.png',
  'assets/images/product_07.png',
  'assets/images/product_8.png',
  'assets/images/product_9.png',
  'assets/images/product_10.png',
];

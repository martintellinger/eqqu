import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _primaryGreen = Color(0xFF006535);

  // ── Dark Theme ──
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: _primaryGreen,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF006434),
      onPrimaryContainer: Color(0xFF8ADEA2),
      secondary: Colors.white,
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFF070707),
      onSecondaryContainer: Colors.white,
      tertiary: Color(0xFF8C8C8C),
      surface: Color(0xFF070707),
      onSurface: Colors.white,
      surfaceContainerLow: Color(0xFF1C1B1B),
      surfaceContainerHigh: Color(0xFF2A2A2A),
      surfaceContainerHighest: Color(0xFF353434),
      surfaceTint: Color(0xFF85D89C),
      error: Color(0xFFFFB4A8),
      onError: Color(0xFFA10000),
      outline: Color(0xFF545454),
      outlineVariant: Color(0xFF3F4940),
      onSurfaceVariant: Color(0xFFBFC9BE),
      inverseSurface: Color(0xFFF5F9F7),
    );
    return _buildThemeData(colorScheme);
  }

  // ── Light Theme ──
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: _primaryGreen,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF006434),
      onPrimaryContainer: Color(0xFF8ADEA2),
      secondary: Colors.black,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF070707),
      onSecondaryContainer: Colors.white,
      tertiary: Color(0xFF8C8C8C),
      surface: Colors.white,
      onSurface: Color(0xFF1C1B1B),
      surfaceContainerLow: Color(0xFFF5F9F7),
      surfaceContainerHigh: Color(0xFFF7F7F7),
      surfaceContainerHighest: Color(0xFFEDEDED),
      surfaceTint: _primaryGreen,
      error: Color(0xFFA10000),
      onError: Colors.white,
      outline: Color(0xFFEDEDED),
      outlineVariant: Color(0xFFD6E6DF),
      onSurfaceVariant: Color(0xFF3F4940),
      inverseSurface: Color(0xFF1C1B1B),
    );
    return _buildThemeData(colorScheme);
  }

  static ThemeData _buildThemeData(ColorScheme colorScheme) {
    final bool isDark = colorScheme.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _buildTextTheme(colorScheme.onSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _poppins(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 28 / 20,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: colorScheme.onSurface, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: colorScheme.error, width: 3),
        ),
        labelStyle: _poppins(
          fontSize: 16,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
        floatingLabelStyle: _poppins(
          fontSize: 12,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.4,
        ),
        errorStyle: _poppins(
          fontSize: 12,
          color: colorScheme.error,
          letterSpacing: 0.4,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: _poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          textStyle: _poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.secondary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onSecondary),
        side: BorderSide(color: colorScheme.secondary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline,
        thickness: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: _primaryGreen,
        unselectedItemColor: const Color(0xFF8C8C8C),
      ),
    );
  }

  static TextStyle _poppins({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.white,
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

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      titleLarge: _poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 28 / 20,
      ),
      titleMedium: _poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.15,
        height: 24 / 16,
      ),
      bodyLarge: _poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.5,
        height: 24 / 16,
      ),
      bodyMedium: _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.25,
        height: 20 / 14,
      ),
      bodySmall: _poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.4,
        height: 16 / 12,
      ),
      labelLarge: _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.1,
        height: 20 / 14,
      ),
    );
  }
}

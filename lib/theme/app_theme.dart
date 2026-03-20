import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Brand colors from Figma M3 Design Kit
  static const Color _primaryGreen = Color(0xFF006535);
  static const Color _primaryContainer = Color(0xFF006434);
  static const Color _onPrimaryContainer = Color(0xFF8ADEA2);
  static const Color _error = Color(0xFFA10000);
  static const Color _onError = Color(0xFFFFB4A8);

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: _primaryGreen,
      onPrimary: Colors.white,
      primaryContainer: _primaryContainer,
      onPrimaryContainer: _onPrimaryContainer,
      secondary: Colors.white,
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFF070707),
      onSecondaryContainer: Colors.white,
      surface: Color(0xFF070707),
      onSurface: Colors.white,
      surfaceContainerLow: Color(0xFF1C1B1B),
      surfaceContainerHighest: Color(0xFF353434),
      error: _onError,
      onError: _error,
      outline: Color(0xFF545454),
      outlineVariant: Color(0xFF3F4940),
      onSurfaceVariant: Color(0xFFBFC9BE),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF070707),
      textTheme: _buildTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _poppins(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 28 / 20,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFF545454)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFF545454)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFFFB4A8), width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFFFB4A8), width: 3),
        ),
        labelStyle: _poppins(
          fontSize: 16,
          color: const Color(0xFFBFC9BE),
          letterSpacing: 0.5,
        ),
        floatingLabelStyle: _poppins(
          fontSize: 12,
          color: const Color(0xFFBFC9BE),
          letterSpacing: 0.4,
        ),
        errorStyle: _poppins(
          fontSize: 12,
          color: const Color(0xFFFFB4A8),
          letterSpacing: 0.4,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
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
          foregroundColor: Colors.white,
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
            return Colors.white;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.black),
        side: const BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF545454),
        thickness: 1,
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

  static TextTheme _buildTextTheme() {
    return TextTheme(
      titleLarge: _poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 28 / 20,
      ),
      titleMedium: _poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 24 / 16,
      ),
      bodyLarge: _poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 24 / 16,
      ),
      bodyMedium: _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 20 / 14,
      ),
      bodySmall: _poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 16 / 12,
      ),
      labelLarge: _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 20 / 14,
      ),
    );
  }
}

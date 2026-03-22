import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  /// Returns a display label for the current theme mode.
  /// Uses the provided [getString] to resolve localized labels,
  /// falling back to English defaults.
  String labelFor({
    required String Function(String key) getString,
  }) {
    switch (_themeMode) {
      case ThemeMode.light:
        return getString('lightMode');
      case ThemeMode.dark:
        return getString('darkMode');
      case ThemeMode.system:
        return getString('systemMode');
    }
  }

  /// Simple label (non-localized fallback).
  String get label {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light mode';
      case ThemeMode.dark:
        return 'Dark mode';
      case ThemeMode.system:
        return 'Podle systému';
    }
  }
}

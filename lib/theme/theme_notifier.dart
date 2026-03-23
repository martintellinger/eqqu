import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  static const _key = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  /// Load persisted theme mode from disk.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key);
    if (stored != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (m) => m.name == stored,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
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

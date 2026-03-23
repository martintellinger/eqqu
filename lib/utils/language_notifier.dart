import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language {
  final String code;
  final String name;
  final String flag;

  const Language(this.code, this.name, this.flag);
}

class LanguageNotifier extends ChangeNotifier {
  static const _key = 'language_code';

  static const List<Language> languages = [
    Language('cs', 'Čeština', '🇨🇿'),
    Language('sk', 'Slovenčina', '🇸🇰'),
    Language('en', 'English', '🇬🇧'),
    Language('de', 'Deutsch', '🇩🇪'),
  ];

  String _selectedCode = 'cs';

  String get selectedCode => _selectedCode;

  Language get selected => languages.firstWhere((l) => l.code == _selectedCode);

  /// Load persisted language from disk.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key);
    if (stored != null && languages.any((l) => l.code == stored)) {
      _selectedCode = stored;
      notifyListeners();
    }
  }

  Future<void> setLanguage(String code) async {
    if (_selectedCode == code) return;
    _selectedCode = code;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
  }
}

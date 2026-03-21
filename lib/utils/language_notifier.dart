import 'package:flutter/foundation.dart';

class Language {
  final String code;
  final String name;
  final String flag;

  const Language(this.code, this.name, this.flag);
}

class LanguageNotifier extends ChangeNotifier {
  static const List<Language> languages = [
    Language('cs', 'Čeština', '🇨🇿'),
    Language('sk', 'Slovenčina', '🇸🇰'),
    Language('en', 'English', '🇬🇧'),
    Language('de', 'Deutsch', '🇩🇪'),
  ];

  String _selectedCode = 'cs';

  String get selectedCode => _selectedCode;

  Language get selected => languages.firstWhere((l) => l.code == _selectedCode);

  void setLanguage(String code) {
    if (_selectedCode != code) {
      _selectedCode = code;
      notifyListeners();
    }
  }
}

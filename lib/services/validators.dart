import 'package:eqqu/l10n/app_strings.dart';

class Validators {
  Validators._();

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? value, [AppStrings? s]) {
    if (value == null || value.trim().isEmpty) {
      return s?.enterEmail ?? 'Zadejte e-mail';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return s?.invalidEmailFormat ?? 'Neplatný formát e-mailu';
    }
    return null;
  }

  static bool isEmailValid(String value) {
    return _emailRegex.hasMatch(value.trim());
  }

  static String? username(String? value, [AppStrings? s]) {
    if (value == null || value.trim().isEmpty) {
      return s?.enterUsername ?? 'Zadejte uživatelské jméno';
    }
    if (value.trim().length < 3) {
      return s?.minThreeChars ?? 'Minimálně 3 znaky';
    }
    return null;
  }

  static String? password(String? value, [AppStrings? s]) {
    if (value == null || value.isEmpty) {
      return s?.enterPassword ?? 'Zadejte heslo';
    }
    if (value.length < 6) {
      return s?.passwordMinSix ?? 'Heslo musí mít alespoň 6 znaků';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password, [AppStrings? s]) {
    if (value == null || value.isEmpty) {
      return s?.confirmPasswordField ?? 'Potvrďte heslo';
    }
    if (value != password) {
      return s?.passwordsDoNotMatch ?? 'Hesla se neshodují';
    }
    return null;
  }

  static String? cardNumber(String value, [AppStrings? s]) {
    final cleaned = value.replaceAll(' ', '');
    if (cleaned.isEmpty) {
      return s?.enterCardNumber ?? 'Zadejte číslo karty';
    }
    if (cleaned.length < 13) {
      return s?.invalidCardNumber ?? 'Neplatné číslo karty';
    }
    return null;
  }

  static String? expiry(String value, [AppStrings? s]) {
    if (value.trim().isEmpty) {
      return s?.enterExpiry ?? 'Zadejte expiraci';
    }
    return null;
  }

  static String? cvc(String value, [AppStrings? s]) {
    if (value.trim().isEmpty) {
      return s?.enterCvc ?? 'Zadejte CVC';
    }
    if (value.trim().length < 3) {
      return s?.invalidCvc ?? 'Neplatný CVC';
    }
    return null;
  }
}

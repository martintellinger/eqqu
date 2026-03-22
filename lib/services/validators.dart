class Validators {
  Validators._();

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Zadejte e-mail';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Neplatný formát e-mailu';
    }
    return null;
  }

  static bool isEmailValid(String value) {
    return _emailRegex.hasMatch(value.trim());
  }

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Zadejte uživatelské jméno';
    }
    if (value.trim().length < 3) {
      return 'Minimálně 3 znaky';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zadejte heslo';
    }
    if (value.length < 6) {
      return 'Heslo musí mít alespoň 6 znaků';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Potvrďte heslo';
    }
    if (value != password) {
      return 'Hesla se neshodují';
    }
    return null;
  }

  static String? cardNumber(String value) {
    final cleaned = value.replaceAll(' ', '');
    if (cleaned.isEmpty) {
      return 'Zadejte číslo karty';
    }
    if (cleaned.length < 13) {
      return 'Neplatné číslo karty';
    }
    return null;
  }

  static String? expiry(String value) {
    if (value.trim().isEmpty) {
      return 'Zadejte expiraci';
    }
    return null;
  }

  static String? cvc(String value) {
    if (value.trim().isEmpty) {
      return 'Zadejte CVC';
    }
    if (value.trim().length < 3) {
      return 'Neplatný CVC';
    }
    return null;
  }
}

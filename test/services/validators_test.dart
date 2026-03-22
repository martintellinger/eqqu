import 'package:flutter_test/flutter_test.dart';
import 'package:eqqu/services/validators.dart';

void main() {
  group('Validators.email', () {
    test('returns error for null', () {
      expect(Validators.email(null), isNotNull);
    });

    test('returns error for empty string', () {
      expect(Validators.email(''), isNotNull);
    });

    test('returns error for whitespace only', () {
      expect(Validators.email('   '), isNotNull);
    });

    test('returns error for invalid format', () {
      expect(Validators.email('notanemail'), isNotNull);
      expect(Validators.email('no@'), isNotNull);
      expect(Validators.email('@no.com'), isNotNull);
    });

    test('returns null for valid email', () {
      expect(Validators.email('test@example.com'), isNull);
      expect(Validators.email('user@domain.cz'), isNull);
    });
  });

  group('Validators.isEmailValid', () {
    test('returns false for invalid email', () {
      expect(Validators.isEmailValid(''), isFalse);
      expect(Validators.isEmailValid('bad'), isFalse);
    });

    test('returns true for valid email', () {
      expect(Validators.isEmailValid('test@example.com'), isTrue);
    });
  });

  group('Validators.username', () {
    test('returns error for null', () {
      expect(Validators.username(null), isNotNull);
    });

    test('returns error for too short', () {
      expect(Validators.username('ab'), isNotNull);
    });

    test('returns null for valid username', () {
      expect(Validators.username('abc'), isNull);
      expect(Validators.username('longusername'), isNull);
    });
  });

  group('Validators.password', () {
    test('returns error for null', () {
      expect(Validators.password(null), isNotNull);
    });

    test('returns error for too short', () {
      expect(Validators.password('12345'), isNotNull);
    });

    test('returns null for valid password', () {
      expect(Validators.password('123456'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('returns error for null', () {
      expect(Validators.confirmPassword(null, 'pass'), isNotNull);
    });

    test('returns error for mismatch', () {
      expect(Validators.confirmPassword('abc', 'def'), isNotNull);
    });

    test('returns null for match', () {
      expect(Validators.confirmPassword('pass123', 'pass123'), isNull);
    });
  });

  group('Validators.cardNumber', () {
    test('returns error for empty', () {
      expect(Validators.cardNumber(''), isNotNull);
    });

    test('returns error for too short', () {
      expect(Validators.cardNumber('1234 5678'), isNotNull);
    });

    test('returns null for valid card', () {
      expect(Validators.cardNumber('4111 1111 1111 1111'), isNull);
    });
  });

  group('Validators.expiry', () {
    test('returns error for empty', () {
      expect(Validators.expiry(''), isNotNull);
    });

    test('returns null for non-empty', () {
      expect(Validators.expiry('12/25'), isNull);
    });
  });

  group('Validators.cvc', () {
    test('returns error for empty', () {
      expect(Validators.cvc(''), isNotNull);
    });

    test('returns error for too short', () {
      expect(Validators.cvc('12'), isNotNull);
    });

    test('returns null for valid CVC', () {
      expect(Validators.cvc('123'), isNull);
    });
  });
}

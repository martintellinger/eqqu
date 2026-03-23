import 'package:eqqu/repositories/auth_repository.dart';

/// Mock implementation of [AuthRepository].
///
/// Always succeeds with a fake token. Replace with a real auth
/// backend implementation (Firebase, custom JWT, etc.).
class MockAuthRepository implements AuthRepository {
  bool _signedIn = false;

  @override
  Future<String> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _signedIn = true;
    return 'mock_token_${email.hashCode}';
  }

  @override
  Future<String> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _signedIn = true;
    return 'mock_token_${email.hashCode}';
  }

  @override
  Future<void> signOut() async {
    _signedIn = false;
  }

  @override
  Future<bool> isSignedIn() async {
    return _signedIn;
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}

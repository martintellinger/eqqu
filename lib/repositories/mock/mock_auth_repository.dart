import 'package:eqqu/models/result.dart';
import 'package:eqqu/repositories/auth_repository.dart';

/// Mock implementation of [AuthRepository].
///
/// Always succeeds with a fake token. Replace with a real auth
/// backend implementation (Firebase, custom JWT, etc.).
class MockAuthRepository implements AuthRepository {
  bool _signedIn = false;

  @override
  Future<Result<String>> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _signedIn = true;
    return Success('mock_token_${email.hashCode}');
  }

  @override
  Future<Result<String>> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _signedIn = true;
    return Success('mock_token_${email.hashCode}');
  }

  @override
  Future<Result<void>> signOut() async {
    _signedIn = false;
    return const Success(null);
  }

  @override
  Future<Result<bool>> isSignedIn() async {
    return Success(_signedIn);
  }

  @override
  Future<Result<void>> resetPassword({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const Success(null);
  }
}

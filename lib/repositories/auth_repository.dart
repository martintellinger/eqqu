import 'package:eqqu/models/result.dart';

/// Abstract contract for authentication.
///
/// Replace the mock implementation with a real one that communicates
/// with your auth backend (Firebase, custom JWT, etc.).
abstract class AuthRepository {
  /// Sign in with email and password. Returns a user token or throws.
  Future<Result<String>> signIn({required String email, required String password});

  /// Register a new account. Returns a user token or throws.
  Future<Result<String>> register({
    required String email,
    required String username,
    required String password,
  });

  /// Sign out the current user.
  Future<Result<void>> signOut();

  /// Returns `true` if a user is currently signed in.
  Future<Result<bool>> isSignedIn();

  /// Request a password reset email.
  Future<Result<void>> resetPassword({required String email});
}

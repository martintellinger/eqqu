/// Abstract contract for authentication.
///
/// Replace the mock implementation with a real one that communicates
/// with your auth backend (Firebase, custom JWT, etc.).
abstract class AuthRepository {
  /// Sign in with email and password. Returns a user token or throws.
  Future<String> signIn({required String email, required String password});

  /// Register a new account. Returns a user token or throws.
  Future<String> register({
    required String email,
    required String username,
    required String password,
  });

  /// Sign out the current user.
  Future<void> signOut();

  /// Returns `true` if a user is currently signed in.
  Future<bool> isSignedIn();

  /// Request a password reset email.
  Future<void> resetPassword({required String email});
}

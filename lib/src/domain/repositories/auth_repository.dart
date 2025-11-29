abstract class AuthRepository {
  /// Returns true if user is signed in (placeholder)
  Future<bool> isSignedIn();

  /// Sign in with email/password (placeholder)
  Future<void> signIn(String email, String password);

  /// Sign out (placeholder)
  Future<void> signOut();
}

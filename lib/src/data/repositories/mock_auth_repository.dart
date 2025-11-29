import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  bool _signedIn = false;

  @override
  Future<bool> isSignedIn() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _signedIn;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _signedIn = true;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _signedIn = false;
  }
}

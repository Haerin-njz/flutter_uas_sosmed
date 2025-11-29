import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../domain/repositories/auth_repository.dart';

/// Firebase-backed implementation of [AuthRepository].


/// [FirebaseService.initializeIfPossible] or checking [firebase_core] init

class FirebaseAuthRepository implements AuthRepository {
  final fb_auth.FirebaseAuth _auth;

  FirebaseAuthRepository([fb_auth.FirebaseAuth? auth])
    : _auth = auth ?? fb_auth.FirebaseAuth.instance;

  @override
  Future<bool> isSignedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

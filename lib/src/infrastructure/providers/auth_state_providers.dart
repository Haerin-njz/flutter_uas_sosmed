import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uas_sosmed/data/dummy_data.dart';

/// Holds the currently signed-in user (null when signed out).
class AuthStateNotifier extends StateNotifier<User?> {
  AuthStateNotifier(): super(null);

  void signInAs(User user) {
    state = user;
  }

  void signOut() {
    state = null;
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  return AuthStateNotifier();
});

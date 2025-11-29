import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthUser {
  final String id;
  final String displayName;
  final String avatarUrl;

  AuthUser({required this.id, required this.displayName, required this.avatarUrl});
}

/// Holds the current authenticated user (or null).
/// For demo purposes this defaults to a demo user; set to null to require sign-in.
final authStateProvider = StateProvider<AuthUser?>((ref) {
  return AuthUser(
    id: 'user_0',
    displayName: 'Demo User',
    avatarUrl: 'https://i.pravatar.cc/100?img=5',
  );
});

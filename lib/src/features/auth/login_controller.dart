import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../infrastructure/providers/auth_state_provider.dart';
import '../../../../data/dummy_data.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      // Simulate sign-in operation (replace with real repo call later)
      await Future.delayed(const Duration(milliseconds: 300));

      // Pick a demo user (you can improve matching logic later)
      final matched = dummyUsers.isNotEmpty ? dummyUsers[0] : null;
      if (matched == null) throw Exception('No demo users available');

      // Map DummyUser -> AuthUser from auth_state_provider
      final authUser = AuthUser(
        id: 'user_0',
        displayName: matched.name,
        avatarUrl: matched.avatarUrl,
      );

      // Set the global auth state
      ref.read(authStateProvider.notifier).state = authUser;

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
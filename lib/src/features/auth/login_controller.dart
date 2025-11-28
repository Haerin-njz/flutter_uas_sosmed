import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../infrastructure/providers/auth_providers.dart';
import '../../../infrastructure/providers/auth_state_provider.dart';
import '../../../../data/dummy_data.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() async {
    // initial state - nothing to load here
    return;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      // Find a user with matching email (mock behavior)
      final matched = dummyUsers.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase(),
        orElse: () => dummyUsers[0],
      );

      await repo.signIn(email, password);

      // Set current user to the matched user (mock auth)
      ref.read(authStateProvider.notifier).signInAs(matched);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
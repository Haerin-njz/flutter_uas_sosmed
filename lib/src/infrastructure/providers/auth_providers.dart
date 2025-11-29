import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // For Phase 1/2 we use a mock implementation. Swap out for Firebase-backed
  // implementation later by changing this provider.
  return MockAuthRepository();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../data/repositories/mock_profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return MockProfileRepository();
});

final profileInfoProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.fetchProfile(userId);
});

final profilePostsProvider = FutureProvider.family.autoDispose((ref, String userId) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.fetchPosts(userId);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/search_repository.dart';
import '../../data/repositories/mock_search_repository.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return MockSearchRepository();
});

final searchPostsProvider = FutureProvider.family.autoDispose((ref, String query) async {
  final repo = ref.read(searchRepositoryProvider);
  return repo.searchPosts(query);
});

final searchUsersProvider = FutureProvider.family.autoDispose((ref, String query) async {
  final repo = ref.read(searchRepositoryProvider);
  return repo.searchUsers(query);
});

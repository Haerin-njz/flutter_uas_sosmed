import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/feed_repository.dart';
import '../../data/repositories/mock_feed_repository.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return MockFeedRepository();
});

final feedProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final repo = ref.read(feedRepositoryProvider);
  final posts = await repo.fetchFeed();
  return posts;
});

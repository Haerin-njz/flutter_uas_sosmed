import '../../domain/entities/post.dart';
import '../../../data/dummy_data.dart' as dummy_data;
import '../../domain/repositories/feed_repository.dart';

class MockFeedRepository implements FeedRepository {
  @override
  Future<List<Post>> fetchFeed({int page = 0, int limit = 20}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final now = DateTime.now();
    // Generate some mock posts using picsum
    return List.generate(10, (i) {
      final id = 'post_${page}_$i';
      final user = dummy_data.dummyUsers[i % dummy_data.dummyUsers.length];
      return Post(
        id: id,
        imageUrl: 'https://picsum.photos/seed/$id/800/600',
        caption: 'This is a sample caption from ${user.displayName}',
        authorId: user.id,
        authorName: user.displayName,
        authorAvatar: user.avatarUrl,
        likeCount: i * 3,
        liked: false,
        createdAt: now.subtract(Duration(hours: i * 2)),
      );
    });
  }
}

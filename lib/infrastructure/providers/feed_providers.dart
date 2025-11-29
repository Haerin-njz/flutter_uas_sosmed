import 'package:flutter_riverpod/flutter_riverpod.dart';

// Minimal Post model to satisfy local usage.
// Replace with your shared domain/entities/post.dart when available.
class Post {
  final String id;
  final String imageUrl;
  final String authorId;
  final String authorName;

  Post({
    required this.id,
    required this.imageUrl,
    required this.authorId,
    required this.authorName,
  });
}

// Provides a feed (list of Post). Replace the body with a real repository/service call.
final feedProvider = FutureProvider<List<Post>>((ref) async {
  try {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate network latency

    // Simulated feed items. Replace with real fetch, e.g. ref.read(feedRepository).fetchPosts()
    return List.generate(8, (i) {
      final authorId = 'user_$i';
      return Post(
        id: 'post_$i',
        imageUrl: 'https://picsum.photos/seed/feed_$i/600/800',
        authorId: authorId,
        authorName: 'user_$i',
        // add other required fields here if Post requires them
      );
    });
  } catch (e) {
    throw Exception('Failed to load feed: $e');
  }
});

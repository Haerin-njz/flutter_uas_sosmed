import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.dart';

// Mock data for posts
final mockPosts = [
  Post(
    id: '1',
    imageUrl: 'public/images/gambar1.jpg',
    caption: 'Lapar Mo',
    authorId: 'user1',
    authorName: 'Rapuy_Nasihuy',
    authorAvatar: 'public/images/profile1.jpg',
    likeCount: 42,
    liked: false,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Post(
    id: '2',
    imageUrl: 'https://picsum.photos/800/600?random=2',
    caption: 'Coffee time ☕ #coffee #morning #caffeine',
    authorId: 'user2',
    authorName: 'jane_smith',
    authorAvatar: 'https://picsum.photos/100/100?random=2',
    likeCount: 28,
    liked: true,
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
  ),
  Post(
    id: '3',
    imageUrl: 'https://picsum.photos/800/600?random=3',
    caption: 'City lights at night ✨ #city #night #lights',
    authorId: 'user3',
    authorName: 'mike_wilson',
    authorAvatar: 'https://picsum.photos/100/100?random=3',
    likeCount: 156,
    liked: false,
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
  ),
];

class PostListNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  PostListNotifier() : super(const AsyncValue.loading()) {
    loadPosts();
  }

  Future<void> loadPosts() async {
    state = const AsyncValue.loading();
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      state = AsyncValue.data(mockPosts);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadPosts();
  }

  void addPost(Post post) {
    state = state.whenData((posts) => [post, ...posts]);
  }

  /// Toggle like for a post by id. This updates the `liked` flag and adjusts `likeCount`.
  void toggleLike(String postId) {
    state = state.whenData((posts) => posts.map((p) {
          if (p.id != postId) return p;
          final currentlyLiked = p.liked;
          final newCount = currentlyLiked ? (p.likeCount - 1).clamp(0, 999999) : p.likeCount + 1;
          return p.copyWith(liked: !currentlyLiked, likeCount: newCount);
        }).toList());
  }
}

final postListProvider =
    StateNotifierProvider<PostListNotifier, AsyncValue<List<Post>>>(
      (ref) => PostListNotifier(),
    );

import '../../domain/entities/post.dart';
import '../../domain/repositories/profile_repository.dart';

class MockProfileRepository implements ProfileRepository {
  @override
  Future<Map<String, dynamic>> fetchProfile(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'id': userId,
      'username': 'user_${userId.replaceAll('user_', '')}',
      'displayName': 'User ${userId.replaceAll('user_', '')}',
      'bio': 'This is a sample bio for $userId.',
      'avatar': 'https://i.pravatar.cc/150?img=${int.tryParse(userId.replaceAll(RegExp(r"[^0-9]"), '')) ?? 1}',
      'followers': 120,
      'following': 80,
    };
  }

  @override
  Future<List<Post>> fetchPosts(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final now = DateTime.now();
    return List.generate(8, (i) {
      final id = '${userId}_post_$i';
      return Post(
        id: id,
        imageUrl: 'https://picsum.photos/seed/$id/600/600',
        caption: 'User post #$i',
        authorId: userId,
        authorName: 'user${userId.replaceAll(RegExp(r"[^0-9]"), '')}',
        authorAvatar: 'https://i.pravatar.cc/150?img=${i + 2}',
        likeCount: i * 2,
        liked: false,
        createdAt: now.subtract(Duration(days: i)),
      );
    });
  }
}

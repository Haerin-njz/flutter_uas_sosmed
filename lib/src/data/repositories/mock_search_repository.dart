import '../../domain/entities/post.dart';
import '../../domain/repositories/search_repository.dart';

class MockSearchRepository implements SearchRepository {
  @override
  Future<List<Map<String, String>>> searchUsers(String query) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return List.generate(6, (i) => {'id': 'user_$i', 'username': 'user$i'}).where((u) => u['username']!.contains(query)).toList();
  }

  @override
  Future<List<Post>> searchPosts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Create a few posts that include query in caption
    return List.generate(8, (i) => Post(
      id: 'search_post_$i',
      imageUrl: 'https://picsum.photos/seed/search_$i/600/800',
      caption: 'Result $i for $query',
      authorId: 'user_$i',
      authorName: 'user$i',
      authorAvatar: 'https://i.pravatar.cc/150?img=${i+10}',
      likeCount: i,
      liked: false,
      createdAt: DateTime.now().subtract(Duration(hours: i)),
    ));
  }
}

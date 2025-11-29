import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uas_sosmed/infrastructure/providers/feed_providers.dart'; // uses the Post model defined there

class PostListNotifier extends StateNotifier<List<Post>> {
  PostListNotifier() : super([]);

  void addPost(Post post) {
    state = [post, ...state];
  }

  void removePostById(String id) {
    state = state.where((p) => p.id != id).toList();
  }
}

final postListProvider = StateNotifierProvider<PostListNotifier, List<Post>>((ref) {
  return PostListNotifier();
});

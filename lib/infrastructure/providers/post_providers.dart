import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/posts/data/post_model.dart';

class PostListNotifier extends StateNotifier<AsyncValue<List<PostModel>>> {
  PostListNotifier(): super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();

        final posts = snapshot.docs
          .map((d) => PostModel.fromMap(d.data(), d.id))
          .toList();

      state = AsyncValue.data(posts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _load();
  }
}

final postListProvider = StateNotifierProvider<PostListNotifier, AsyncValue<List<PostModel>>>((ref) {
  return PostListNotifier();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.dart';

// Provides a feed (list of Post). Replace the body with a real repository/service call.
final feedProvider = FutureProvider<List<Post>>((ref) async {
  try {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate network latency

    // TODO: replace with real fetch, e.g. ref.read(feedRepository).fetchPosts()
    return <Post>[]; // placeholder empty list to keep API stable
  } catch (e) {
    throw Exception('Failed to load feed: $e');
  }
});

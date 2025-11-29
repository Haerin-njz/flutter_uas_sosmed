import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uas_sosmed/infrastructure/providers/feed_providers.dart';

/// Simulated search provider. Replace with real repository/service.
final searchPostsProvider = FutureProvider.family<List<Post>, String>((ref, query) async {
  final q = query.trim();
  await Future.delayed(const Duration(milliseconds: 300)); // simulate latency

  if (q.isEmpty) {
    return <Post>[]; // no results until user searches
  }

  // generate sample results (adjust Post fields to match your Post entity)
  return List.generate(8, (i) {
    return Post(
      id: 'search_${q}_$i',
      imageUrl: 'https://picsum.photos/seed/search_${q}_$i/400/400',
      authorId: 'user_$i',
      authorName: 'user_$i',
      // add other required fields if necessary
    );
  });
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uas_sosmed/infrastructure/providers/feed_providers.dart';

/// Simulated profile info provider. Replace with real repository/service.
final profileInfoProvider = FutureProvider.family<Map<String, String>, String>((ref, userId) async {
  await Future.delayed(const Duration(milliseconds: 300)); // simulate latency
  return {
    'username': 'user_$userId',
    'avatar': 'https://i.pravatar.cc/600?u=$userId',
  };
});

/// Simulated posts for a profile. Replace with real repository/service.
final profilePostsProvider = FutureProvider.family<List<Post>, String>((ref, userId) async {
  await Future.delayed(const Duration(milliseconds: 400)); // simulate latency
  // Generate a small grid of images using picsum (seeded by userId)
  return List.generate(12, (i) {
    return Post(
      id: 'post_${userId}_$i',
      imageUrl: 'https://picsum.photos/seed/${userId}_$i/300/300',
      authorId: userId, // required by Post
      authorName: 'user_$userId', // required by Post
      // other fields (caption, author, etc.) can be omitted or set depending on Post definition
    );
  });
});

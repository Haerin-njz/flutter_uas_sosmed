import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../domain/entities/post.dart';
import '../../../infrastructure/providers/feed_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(feedProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: postsAsync.when(
        data: (posts) => MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          padding: const EdgeInsets.all(8),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final Post p = posts[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: p.imageUrl,
                placeholder: (c, s) => Container(color: Colors.grey[200], height: 150),
                errorWidget: (c, s, e) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Explore error: $e')),
      ),
    );
  }
}

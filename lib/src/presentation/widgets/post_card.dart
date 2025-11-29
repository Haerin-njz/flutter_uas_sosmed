import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/post.dart';

class PostCard extends ConsumerWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                post.authorAvatar ?? '',
              ),
              onBackgroundImageError: (_, __) {},
              child: post.authorAvatar == null
                  ? Text(post.authorName[0].toUpperCase())
                  : null,
            ),
            title: Text(post.authorName),
            subtitle: Text(
              '${DateTime.now().difference(post.createdAt!).inHours.abs()}h ago',
            ),
          ),

          // Image
          CachedNetworkImage(
            imageUrl: post.imageUrl,
            placeholder: (context, url) => AspectRatio(
              aspectRatio: 1,
              child: Container(color: Colors.grey[200]),
            ),
            errorWidget: (context, url, error) => AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.grey[200],
                child: const Icon(Icons.error),
              ),
            ),
            fit: BoxFit.cover,
            width: double.infinity,
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Like button with animation
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    key: ValueKey(post.liked),
                    icon: Icon(
                      post.liked ? Icons.favorite : Icons.favorite_border,
                      color: post.liked ? Colors.red : null,
                    ),
                    onPressed: () async {
                      // Haptic feedback
                      await HapticFeedback.mediumImpact();

                      // Toggle like (in a real app, this would update the provider)
                      // For now, just show the animation
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Like count with animation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                '${post.likeCount} likes',
                key: ValueKey(post.likeCount),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          // Caption
          if (post.caption != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8,
              ),
              child: Text(post.caption!),
            ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

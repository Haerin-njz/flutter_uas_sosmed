import 'package:flutter/material.dart';
import '../../../features/posts/data/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Post ID: ${post.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Media: ${post.mediaUrl}'),
            const SizedBox(height: 8),
            Text('By: ${post.userId} • ${post.createdAt.toIso8601String()}'),
          ],
        ),
      ),
    );
  }
}

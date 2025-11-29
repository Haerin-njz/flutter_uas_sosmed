import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uas_sosmed/src/infrastructure/providers/post_providers.dart';
import 'package:flutter_uas_sosmed/src/infrastructure/providers/auth_state_providers.dart';
import 'package:flutter_uas_sosmed/src/domain/entities/post.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final _imageController = TextEditingController();
  final _captionController = TextEditingController();

  @override
  void dispose() {
    _imageController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _submitPost() {
    final user = ref.read(authStateProvider);
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please sign in first')));
      return;
    }

    final imageUrl = _imageController.text.trim();
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Image URL required')));
      return;
    }

    final post = Post(
      id: 'userpost_${DateTime.now().millisecondsSinceEpoch}',
      imageUrl: imageUrl,
      authorId: user.id,
      authorName: user.displayName,
    );

    ref.read(postListProvider.notifier).addPost(post);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(labelText: 'Caption'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
          ],
        ),
      ),
    ); 
  }
}

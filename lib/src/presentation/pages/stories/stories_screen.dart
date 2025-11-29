import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers/story_providers.dart';
import '../../widgets/story_viewer.dart';

class StoriesScreen extends ConsumerWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsync = ref.watch(storiesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Stories')),
      body: storiesAsync.when(
        data: (stories) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final s = stories[index];
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(s.userAvatar ?? ''), backgroundColor: Colors.grey[300]),
              title: Text(s.userName),
              subtitle: Text('${s.mediaUrls.length} items'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Scaffold(body: StoryViewer(story: s, onComplete: () => Navigator.of(context).pop())))),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading stories: $e')),
      ),
    );
  }
}

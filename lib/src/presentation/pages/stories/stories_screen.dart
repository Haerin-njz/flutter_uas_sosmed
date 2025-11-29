import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../infrastructure/story_providers.dart';
import '../../widgets/story_viewer.dart'; 

class StoriesScreen extends ConsumerWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mengambil data dari provider stories
    final storiesAsync = ref.watch(storiesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Stories')),
      body: storiesAsync.when(
        data: (stories) {
          if (stories.isEmpty) {
            return const Center(child: Text("No stories yet."));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: stories.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final story = stories[index];
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: story.isViewed ? Colors.grey : Colors.blue,
                      width: 2.5,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(story.userAvatar ?? ''),
                    radius: 24,
                  ),
                ),
                title: Text(
                  story.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${story.mediaUrls.length} snaps'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StoryViewer(
                        story: story,
                        onComplete: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
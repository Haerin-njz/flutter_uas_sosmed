import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/story_list.dart';
import '../../widgets/post_card.dart';
import '../../../infrastructure/providers/story_providers.dart';
import '../../../infrastructure/providers/post_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsync = ref.watch(storiesProvider);
    final postsAsync = ref.watch(postListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Feed'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () => context.go('/messages'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh both stories and posts
          ref.invalidate(storiesProvider);
          await ref.read(postListProvider.notifier).refresh();
        },
        child: CustomScrollView(
          slivers: [
            // Stories
            SliverToBoxAdapter(
              child: storiesAsync.when(
                data: (stories) => StoryList(
                  stories: stories,
                  onStoryTap: (story) {
                    // Navigate to story viewer
                    context.go('/stories/${story.id}');
                  },
                ),
                loading: () => const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => const SizedBox(
                  height: 100,
                  child: Center(child: Text('Failed to load stories')),
                ),
              ),
            ),
            // Posts
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: postsAsync.when(
                data: (posts) => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final post = posts[index];
                    return PostCard(post: post);
                  }, childCount: posts.length),
                ),
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => const SliverFillRemaining(
                  child: Center(child: Text('Failed to load posts')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

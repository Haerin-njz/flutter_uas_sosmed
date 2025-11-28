import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers/profile_providers.dart';
// post_card not directly used here; grid shows images only

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileInfoProvider(userId));
    final postsAsync = ref.watch(profilePostsProvider(userId));

    return Scaffold(
      body: profileAsync.when(
        data: (profile) => DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, inner) => [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
                  title: Text(profile['username'] ?? ''),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(profile['avatar'], fit: BoxFit.cover),
                      Container(color: Colors.black26),
                    ],
                  ),
                ),
                bottom: const TabBar(tabs: [Tab(icon: Icon(Icons.grid_on)), Tab(icon: Icon(Icons.photo)), Tab(icon: Icon(Icons.favorite_border))]),
              )
            ],
            body: TabBarView(
              children: [
                // Posts grid
                postsAsync.when(
                  data: (posts) => GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
                    itemCount: posts.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {},
                      child: Image.network(posts[index].imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error loading posts: $e')),
                ),
                // Photos (same as posts for now)
                const Center(child: Text('Photos tab - coming soon')),
                // Likes
                const Center(child: Text('Likes tab - coming soon')),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading profile: $e')),
      ),
    );
  }
}

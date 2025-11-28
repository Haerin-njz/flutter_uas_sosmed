import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers/search_providers.dart';
import '../../widgets/post_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch() {
    setState(() => _query = _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(searchPostsProvider(_query));

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _onSearch(),
                    decoration: const InputDecoration(hintText: 'Search posts or users', border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _onSearch, child: const Text('Search'))
              ],
            ),
          ),
          Expanded(
            child: postsAsync.when(
              data: (posts) => ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => PostCard(post: posts[index]),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Search error: $e')),
            ),
          )
        ],
      ),
    );
  }
}

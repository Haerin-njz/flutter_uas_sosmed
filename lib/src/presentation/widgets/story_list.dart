import 'package:flutter/material.dart';
import '../../../features/stories/data/story_model.dart';

typedef StoryTapCallback = void Function(StoryModel story);

class StoryList extends StatelessWidget {
  final List<StoryModel> stories;
  final StoryTapCallback? onStoryTap;

  const StoryList({super.key, required this.stories, this.onStoryTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final s = stories[index];
          return GestureDetector(
            onTap: () => onStoryTap?.call(s),
            child: Column(
              children: [
                CircleAvatar(radius: 30, child: Text(s.userId.isNotEmpty ? s.userId[0].toUpperCase() : '?')),
                const SizedBox(height: 6),
                SizedBox(width: 70, child: Text('Story', overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: stories.length,
      ),
    );
  }
}

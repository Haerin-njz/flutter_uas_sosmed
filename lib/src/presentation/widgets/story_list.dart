import 'package:flutter/material.dart';
import 'story_circle.dart';
import '../../domain/entities/story.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key, required this.stories, this.onStoryTap});

  final List<Story> stories;
  final void Function(Story)? onStoryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return StoryCircle(
            story: story,
            onTap: () => onStoryTap?.call(story),
          );
        },
      ),
    );
  }
}

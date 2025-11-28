import 'package:flutter/material.dart';
import '../../../features/stories/data/story_model.dart';

// Ubah StoryModel jadi Story
typedef StoryTapCallback = void Function(Story story);

class StoryList extends StatelessWidget {
  final List<Story> stories;
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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: (s.userAvatar != null) ? NetworkImage(s.userAvatar!) : null,
                  child: (s.userAvatar == null)
                      ? Text(s.userName.isNotEmpty ? s.userName[0].toUpperCase() : '?')
                      : null,
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 70,
                  child: Text(
                    s.userName, // Tampilkan nama user
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
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
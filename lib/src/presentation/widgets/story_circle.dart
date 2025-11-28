import 'package:flutter/material.dart';
import '../../../features/stories/data/story_model.dart';

class StoryCircle extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;

  const StoryCircle({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: story.isViewed ? Colors.grey : Colors.blue,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: (story.userAvatar != null && story.userAvatar!.isNotEmpty)
                  ? NetworkImage(story.userAvatar!)
                  : null,
              child: (story.userAvatar == null || story.userAvatar!.isEmpty)
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 70,
            child: Text(
              story.userName,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
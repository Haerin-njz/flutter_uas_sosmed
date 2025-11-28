import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/stories/data/story_model.dart';

// Gunakan List<Story>, bukan StoryModel
final storiesProvider = FutureProvider<List<Story>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 500));
  
  // Return data dummy
  return [
    Story(
      id: '1',
      userId: 'user1',
      userName: 'Jojo',
      userAvatar: 'https://i.pravatar.cc/150?img=11',
      mediaUrls: ['https://picsum.photos/500/800'],
      createdAt: DateTime.now(),
    ),
    Story(
      id: '2',
      userId: 'user2',
      userName: 'Haerin',
      mediaUrls: ['https://picsum.photos/500/801'],
      createdAt: DateTime.now(),
    ),
  ];
});
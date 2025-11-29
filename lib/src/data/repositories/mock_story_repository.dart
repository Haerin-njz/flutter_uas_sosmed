import '../../domain/entities/story.dart';
import '../../domain/repositories/story_repository.dart';

class MockStoryRepository implements StoryRepository {
  @override
  Future<List<Story>> fetchStories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final now = DateTime.now();
    // Create 6 users with 1 story each
    return List.generate(6, (i) {
      final id = 'story_user_$i';
      return Story(
        id: id,
        userId: 'user_$i',
        userName: 'user$i',
        userAvatar: 'https://i.pravatar.cc/150?img=${i + 5}',
        mediaUrls: ['https://picsum.photos/seed/$id/900/1600'],
        createdAt: now.subtract(Duration(hours: i)),
        isViewed: i % 3 == 0,
      );
    });
  }
}

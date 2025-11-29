import '../../domain/entities/story.dart';
import '../../domain/repositories/story_repository.dart';

class MockStoryRepository implements StoryRepository {
  @override
  Future<List<Story>> fetchStories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final now = DateTime.now();
    // Create 6 users with 1 story each (use local asset avatars so you can swap images)
    final names = ['Dustin', 'Will', 'Finn', 'Eleven', 'Hopper', 'Vecna'];
    return List.generate(6, (i) {
      final id = 'story_user_${i + 1}';
      return Story(
        id: id,
        userId: 'user_${i + 1}',
        userName: names[i],
        // Local asset path - place story images as public/images/story1.jpg .. story6.jpg
        userAvatar: 'public/images/story${i + 1}.jpg',
        mediaUrls: ['https://picsum.photos/seed/$id/900/1600'],
        createdAt: now.subtract(Duration(hours: i)),
        isViewed: i % 3 == 0,
      );
    });
  }
}

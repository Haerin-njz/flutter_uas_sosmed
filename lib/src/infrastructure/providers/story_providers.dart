import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/story_repository.dart';
import '../../data/repositories/mock_story_repository.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return MockStoryRepository();
});

final storiesProvider = FutureProvider<List<Story>>((ref) async {
  final repo = ref.read(storyRepositoryProvider);
  return repo.fetchStories();
});

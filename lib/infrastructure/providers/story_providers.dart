import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/stories/data/story_model.dart';

// Simple FutureProvider that returns an empty list by default.
// Replace the body with real data fetching logic as needed.
final storiesProvider = FutureProvider<List<StoryModel>>((ref) async {
  // Simulated fetch: replace with repository/service call (e.g. ref.read(storiesRepo).fetchAll())
  try {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate network latency

    
    return <StoryModel>[]; // placeholder empty list to keep API stable
  } catch (e) {
    // Propagate error to the FutureProvider so consumers can handle it.
    throw Exception('Failed to load stories: $e');
  }
});

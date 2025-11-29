import '../entities/post.dart';

abstract class FeedRepository {

  Future<List<Post>> fetchFeed({int page = 0, int limit = 20});
}

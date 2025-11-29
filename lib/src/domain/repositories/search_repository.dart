import '../entities/post.dart';

abstract class SearchRepository {
  Future<List<Post>> searchPosts(String query);
  Future<List<Map<String, String>>> searchUsers(String query);
}

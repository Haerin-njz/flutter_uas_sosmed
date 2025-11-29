import '../entities/post.dart';

abstract class ProfileRepository {
  Future<Map<String, dynamic>> fetchProfile(String userId);

  Future<List<Post>> fetchPosts(String userId);
}

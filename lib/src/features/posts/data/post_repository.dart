import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_model.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  final _db = FirebaseFirestore.instance;
  
  Future<void> createPost(String mediaUrl, String userId) async {
    final id = const Uuid().v4();

    final post = PostModel(
      id: id,
      mediaUrl: mediaUrl,
      userId: userId,
      createdAt: DateTime.now(),
    );

    await _db.collection("posts").doc(id).set(post.toMap());
  }
}

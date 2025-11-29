import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/feed_repository.dart';

/// Firestore-backed implementation of [FeedRepository].
class FirebaseFeedRepository implements FeedRepository {
  final FirebaseFirestore _firestore;

  FirebaseFeedRepository([FirebaseFirestore? firestore])
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Post>> fetchFeed({int page = 0, int limit = 20}) async {
    final snapshot = await _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(
        doc.data() as Map<String, dynamic>,
      );
      // Ensure an 'id' exists for the Post.
      data['id'] = data['id'] ?? doc.id;
      // Firebase stores Timestamps; convert if necessary.
      if (data['createdAt'] is Timestamp) {
        data['createdAt'] = (data['createdAt'] as Timestamp).toDate();
      }
      return Post.fromJson(data);
    }).toList();
  }
}

class PostModel {
  final String id;
  final String mediaUrl;
  final String userId;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.mediaUrl,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    "mediaUrl": mediaUrl,
    "userId": userId,
    "createdAt": createdAt.toIso8601String(),
  };

  factory PostModel.fromMap(Map<String, dynamic> map, String id) {
    final createdAtValue = map['createdAt'];
    DateTime createdAt;
    if (createdAtValue is String) {
      createdAt = DateTime.tryParse(createdAtValue) ?? DateTime.now();
    } else if (createdAtValue is int) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(createdAtValue);
    } else {
      // Fallback: if value is a Firestore Timestamp, it will be handled by runtime import
      try {
        createdAt = (createdAtValue as dynamic).toDate();
      } catch (_) {
        createdAt = DateTime.now();
      }
    }

    return PostModel(
      id: id,
      mediaUrl: map['mediaUrl'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      createdAt: createdAt,
    );
  }
}

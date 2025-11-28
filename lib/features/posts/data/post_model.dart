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
}

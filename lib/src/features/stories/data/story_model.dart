class Story {
  final String id;
  final String userId;
  final String userName; 
  final String? userAvatar; 
  final List<String> mediaUrls;
  final DateTime createdAt;
  final bool isViewed;

  Story({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.mediaUrls,
    required this.createdAt,
    this.isViewed = false,
  });
}
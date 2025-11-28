class Story {  
  final String id;
  final String mediaUrl; 
  final String userId;
  final DateTime createdAt;
  
  final String userName; 
  final String? userAvatar;
  final List<String> mediaUrls; 
  final bool isViewed;

  Story({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.mediaUrls,
    required this.createdAt,
    this.isViewed = false,
  }) : mediaUrl = mediaUrls.isNotEmpty ? mediaUrls.first : ''; 
}
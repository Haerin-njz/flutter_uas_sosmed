import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String imageUrl,
    String? caption,
    required String authorId,
    required String authorName,
    String? authorAvatar,
    @Default(0) int likeCount,
    @Default(false) bool liked,
    DateTime? createdAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

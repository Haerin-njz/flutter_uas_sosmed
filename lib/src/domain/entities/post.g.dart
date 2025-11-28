// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
  id: json['id'] as String,
  imageUrl: json['imageUrl'] as String,
  caption: json['caption'] as String?,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  authorAvatar: json['authorAvatar'] as String?,
  likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
  liked: json['liked'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'caption': instance.caption,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'likeCount': instance.likeCount,
      'liked': instance.liked,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

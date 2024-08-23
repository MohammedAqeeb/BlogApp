// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
      blogId: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'id': instance.blogId,
      'user_id': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'topics': instance.topics,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

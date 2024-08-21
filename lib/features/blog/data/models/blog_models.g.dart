// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
      blogId: json['blogId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      contents: json['contents'] as String,
      imageUrl: json['imageUrl'] as String,
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'blogId': instance.blogId,
      'userId': instance.userId,
      'title': instance.title,
      'contents': instance.contents,
      'imageUrl': instance.imageUrl,
      'topics': instance.topics,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

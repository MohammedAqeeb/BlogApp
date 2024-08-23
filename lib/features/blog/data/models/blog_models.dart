import 'package:blog_app/features/blog/domain/entity/blog.dart';

import 'package:json_annotation/json_annotation.dart';

part 'blog_models.g.dart';

@JsonSerializable()
class BlogModel extends Blog {
  BlogModel({
    required super.blogId,
    required super.userId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

  BlogModel copyWith({
    String? blogId,
    userId,
    title,
    content,
    imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      blogId: blogId ?? this.blogId,
      content: content ?? this.content,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

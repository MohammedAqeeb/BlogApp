import 'package:blog_app/features/blog/domain/entity/blog.dart';

import 'package:json_annotation/json_annotation.dart';

part 'blog_models.g.dart';

@JsonSerializable()
class BlogModel extends Blog {
  BlogModel({
    required super.blogId,
    required super.userId,
    required super.title,
    required super.contents,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);
}

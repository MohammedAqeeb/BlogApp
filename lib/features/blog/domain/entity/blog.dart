// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

class Blog {
  @JsonKey(name: 'id')
  final String blogId;
  @JsonKey(name: 'user_id')
  final String userId;
  final String title, content;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final List<String> topics;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String? name;

  const Blog({
    required this.blogId,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
    this.name,
  });
}

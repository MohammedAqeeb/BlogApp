class Blog {
  final String blogId, userId, title, contents, imageUrl;
  final List<String> topics;
  final DateTime updatedAt;

  const Blog({
    required this.blogId,
    required this.userId,
    required this.title,
    required this.contents,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });
}

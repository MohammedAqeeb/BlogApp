part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String userId, blogTitle, contents;
  final List<String> topics;
  final File uploadedImage;

  BlogUploadEvent(
    this.userId,
    this.blogTitle,
    this.contents,
    this.uploadedImage,
    this.topics,
  );
}

final class FetchBlogEvent extends BlogEvent {}

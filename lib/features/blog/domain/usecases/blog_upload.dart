import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repositries/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class BlogUploadUseCase implements UseCase<Blog, BlogUploadParams> {
  final BlogRepositary blogRepositary;

  BlogUploadUseCase(this.blogRepositary);

  @override
  Future<Either<Failure, Blog>> call(BlogUploadParams params) async {
    return await blogRepositary.uploadBlog(
      uploadedImage: params.uploadedImage,
      blogTitle: params.blogTitle,
      contents: params.contents,
      userId: params.userId,
      topics: params.topics,
    );
  }
}

class BlogUploadParams {
  final String userId, blogTitle, contents;
  final List<String> topics;
  final File uploadedImage;

  BlogUploadParams(
    this.userId,
    this.blogTitle,
    this.contents,
    this.uploadedImage,
    this.topics,
  );
}

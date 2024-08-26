import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/data/data_source/remote_blog.dart';
import 'package:blog_app/features/blog/data/models/blog_models.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repositries/blog_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepositary {
  final RemoteBlogDataSoure remoteBlogDataSoure;

  BlogRepositoryImpl(this.remoteBlogDataSoure);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File uploadedImage,
    required String blogTitle,
    required String contents,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      /// 1. Assigning the values to blog Models
      BlogModel blogModel = BlogModel(
        blogId: const Uuid().v1(),
        userId: userId,
        title: blogTitle,
        content: contents,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      // 2. Obtaining the imageUrl from supabase
      final image = await remoteBlogDataSoure.uploadBlogImage(
          blog: blogModel, uploadedImage: uploadedImage);

      // 3. passing the imageUrl to blog with the help og copyWith method
      blogModel = blogModel.copyWith(imageUrl: image);

      // 4. uploading the blog to data source supabase
      final uploadedBlog = await remoteBlogDataSoure.uploadBlog(blogModel);

      // returning the blog model from the Either function to Right
      return right(uploadedBlog);
    } on CustomException catch (e) {
      // returning the failure message from the Either function to left
      throw left(e.message);
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> fetchBlog() async {
    try {
      final allBlogs = await remoteBlogDataSoure.fetchAllBlog();

      return right(allBlogs);
    } on CustomException catch (e) {
      throw left(e.toString());
    }
  }
}

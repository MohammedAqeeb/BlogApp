import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepositary {
  Future<Either<Failure, Blog>> uploadBlog({
    required File uploadedImage,
    required String blogTitle,
    required String contents,
    required String userId,
    required List<String> topics,
  });
}

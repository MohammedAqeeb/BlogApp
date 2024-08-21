import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_models.dart';

abstract interface class RemoteBlogDataSoure {
  Future<String> uploadBlogImage({
    required File uploadedImage,
    required BlogModel blog,
  });
  Future<BlogModel> uploadBlod(BlogModel blog);
}

class RemoteBlogDataSourceImpl implements RemoteBlogDataSoure {
  final SupabaseClient supabaseClient;

  RemoteBlogDataSourceImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlod(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File uploadedImage,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blog.blogId, uploadedImage);

      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blog.blogId);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}

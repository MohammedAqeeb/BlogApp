import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_models.dart';

abstract interface class RemoteBlogDataSoure {
  Future<String> uploadBlogImage({
    required File uploadedImage,
    required BlogModel blog,
  });
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<List<BlogModel>> fetchAllBlog();
}

class RemoteBlogDataSourceImpl implements RemoteBlogDataSoure {
  final SupabaseClient supabaseClient;

  RemoteBlogDataSourceImpl(this.supabaseClient);

  /// Function to upload blogs on supabase
  ///
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  /// Function to upload image on supabase storage
  ///
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

  @override
  Future<List<BlogModel>> fetchAllBlog() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (name)');

      return blogs
          .map((blog) =>
              BlogModel.fromJson(blog).copyWith(name: blog['profiles']['name']))
          .toList();
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}

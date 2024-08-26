import 'dart:io';

import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/blog_upload.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUploadUseCase _blogUploadUseCase;
  final FetchBlogUseCase _fetchBlogUseCase;
  BlogBloc({
    required BlogUploadUseCase blogUploadUseCase,
    required FetchBlogUseCase fetchBlogUseCase,
  })  : _blogUploadUseCase = blogUploadUseCase,
        _fetchBlogUseCase = fetchBlogUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));

    on<BlogUploadEvent>((event, emit) => _uploadBlogEvent(event, emit));

    on<FetchBlogEvent>((event, emit) => _fetchEvents(event, emit));
  }

  void _uploadBlogEvent(
    BlogUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
   
    final blog = await _blogUploadUseCase(BlogUploadParams(
      event.userId,
      event.blogTitle,
      event.contents,
      event.uploadedImage,
      event.topics,
    ));

    blog.fold(
      (l) => emit(BlogFailure(l.message)),
      (success) => emit(BlogSuccess()),
    );
  }

  void _fetchEvents(
    FetchBlogEvent event,
    Emitter<BlogState> emit,
  ) async {
    final fetchedBlogs = await _fetchBlogUseCase.call(NoParams());

    fetchedBlogs.fold(
      (l) => emit(BlogFailure(l.message)),
      (allBlogs) => emit(FetchBlogSuccess(blogs: allBlogs)),
    );
  }
}

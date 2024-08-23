import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/blog_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUploadUseCase _blogUploadUseCase;
  BlogBloc({
    required BlogUploadUseCase blogUploadUseCase,
  })  : _blogUploadUseCase = blogUploadUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));

    on<BlogUploadEvent>((event, emit) => uploadBlogEvent(event, emit));
  }

  void uploadBlogEvent(
    BlogUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
    print('on event triggered 3');
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
}

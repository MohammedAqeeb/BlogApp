import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_home.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const AddNewBlog());
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final blogTitleController = TextEditingController();
  final blogCommentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<String> selectedTopics = [];
  File? image;
  void selectImage() async {
    final selectedImage = await pickImage();
    if (selectedImage != null) {
      setState(() {});
      image = selectedImage;
    }
  }

  void onPressedUploadBlog() {
    print('on user clicked 1');
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      print('on clicked validate 2');
      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      context.read<BlogBloc>().add(
            BlogUploadEvent(
              userId,
              blogTitleController.text.trim(),
              blogCommentController.text.trim(),
              image!,
              selectedTopics,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: onPressedUploadBlog,
            // onPressed: () {
            //   final userId =
            //       (context.read<AppUserCubit>().state as AppUserLoggedIn)
            //           .user
            //           .id;

            //   print(userId);
            // },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            return showSnackBar(context, state.message);
          } else if (state is BlogSuccess) {
            Navigator.pushAndRemoveUntil(
                context, BlogHome.route(), (route) => false);
            return showSnackBar(context, 'Blog Added Successfully');
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              color: AppPalette.borderColor,
                              dashPattern: const [12, 6],
                              radius: const Radius.circular(22),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open_rounded, size: 35),
                                    SizedBox(height: 10),
                                    Text(
                                      'Select your image',
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: [
                        'Technology',
                        'Daily Update',
                        'Motivation',
                        'Programming',
                      ]
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8, top: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedTopics.contains(e)) {
                                        selectedTopics.remove(e);
                                      } else {
                                        selectedTopics.add(e);
                                      }

                                      setState(() {});
                                    },
                                    child: Chip(
                                      label: Text(e),
                                      color: selectedTopics.contains(e)
                                          ? const WidgetStatePropertyAll(
                                              AppPalette.gradient1)
                                          : null,
                                      side: selectedTopics.contains(e)
                                          ? BorderSide.none
                                          : const BorderSide(
                                              color: AppPalette.borderColor),
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    const SizedBox(height: 20),
                    BlogField(
                      controller: blogTitleController,
                      hintText: 'Blog Title',
                    ),
                    const SizedBox(height: 20),
                    BlogField(
                      controller: blogCommentController,
                      hintText: 'Comments',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

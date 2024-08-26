import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_blog.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogHome extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogHome(),
      );
  const BlogHome({super.key});

  @override
  State<BlogHome> createState() => _BlogHomeState();
}

class _BlogHomeState extends State<BlogHome> {
  @override
  void initState() {
    context.read<BlogBloc>().add(FetchBlogEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlog.route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            return showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is FetchBlogSuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCards(
                  blog: blog,
                  cardColor: index % 3 == 0
                      ? AppPalette.cardColor7
                      : index % 3 == 1
                          ? AppPalette.cardColor2
                          : AppPalette.cardColor1,
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

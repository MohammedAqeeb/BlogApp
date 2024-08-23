import 'package:blog_app/features/blog/presentation/pages/add_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogHome extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogHome(),
      );
  const BlogHome({super.key});

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
        body: const Center(
          child: Text('Home'),
        ));
  }
}

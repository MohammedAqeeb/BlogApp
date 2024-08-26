import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/blog_reading_time.dart';
import 'package:blog_app/core/utils/date_formatter.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:flutter/material.dart';

class BlogDetail extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogDetail(blog: blog));
  final Blog blog;
  const BlogDetail({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "By ${blog.name}",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 6),
              Text(
                "${dateFormatter(blog.updatedAt)} . ${calculateBlogReadingTime(blog.content)} min",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppPalette.greyColor,
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  height: 250,
                  width: double.infinity,
                  blog.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                blog.content,
                style: const TextStyle(
                  height: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

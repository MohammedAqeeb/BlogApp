import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/blog_reading_time.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_detail.dart';
import 'package:flutter/material.dart';

class BlogCards extends StatelessWidget {
  final Blog blog;
  final Color cardColor;
  const BlogCards({
    super.key,
    required this.blog,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogDetail.route(blog));
      },
      child: Container(
        margin: const EdgeInsets.all(16).copyWith(bottom: 5),
        padding: const EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Chip(
                          color: const WidgetStatePropertyAll(
                            Color.fromRGBO(31, 31, 31, 25),
                          ),
                          shape: const StadiumBorder(),
                          label: Text(e),
                          side: const BorderSide(
                            color: AppPalette.borderColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Text(
              blog.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            Text('${calculateBlogReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}

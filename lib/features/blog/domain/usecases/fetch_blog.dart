import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repositries/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchBlogUseCase implements UseCase<List<Blog>, NoParams> {
  final BlogRepositary blogRepositary;
  FetchBlogUseCase(this.blogRepositary);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepositary.fetchBlog();
  }
}

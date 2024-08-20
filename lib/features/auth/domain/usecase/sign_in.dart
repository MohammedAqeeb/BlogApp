import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/entity/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<User, UseCaseSignInParams> {
  final AuthRepository authRepository;

  const UserSignIn({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UseCaseSignInParams params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UseCaseSignInParams {
  final String email, password;

  UseCaseSignInParams({
    required this.email,
    required this.password,
  });
}

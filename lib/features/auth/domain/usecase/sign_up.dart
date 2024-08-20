import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/entity/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParam> {
  final AuthRepository authRepository;
  const UserSignUp({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, User>> call(UserSignUpParam params) async {
    return await authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParam {
  final String email, name, password;

  UserSignUpParam({
    required this.email,
    required this.name,
    required this.password,
  });
}

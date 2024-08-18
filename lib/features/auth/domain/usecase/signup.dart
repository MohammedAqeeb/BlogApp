import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignUpParam> {
  final AuthRepository authRepository;
  const UserSignUp({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(UserSignUpParam params) async {
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

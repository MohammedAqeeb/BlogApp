import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
// import 'package:blog_app/core/network/check_connectivity.dart';
import 'package:blog_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:blog_app/core/entity/user.dart';
// import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource authDataSource;
  // final CheckNetworkConnectivity checkNetworkConnectivity;

  AuthRepositoryImplementation(
    this.authDataSource,
    // this.checkNetworkConnectivity,
  );
  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authDataSource.signInEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    // if (!await (checkNetworkConnectivity.isInternetConnected)) {
    //   return left(const Failure('No Internet Connection!!'));
    // }

    try {
      final user = await fn();
      return right(user);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      // if (!await (checkNetworkConnectivity.isInternetConnected)) {
      //   final session = authDataSource.currentUserSession;
      //   if (session == null) {
      //     return left(const Failure('User not Logged in'));
      //   } else {
      //     return right(
      //       UserModel(
      //           id: session.user.id, email: session.user.email ?? '', name: ''),
      //     );
      //   }
      // }
      final user = await authDataSource.getCurrentUser();

      if (user == null) {
        return left(const Failure(('user does\'t exists')));
      }
      return right(user);
    } on CustomException catch (e) {
      throw left(Failure(e.toString()));
    }
  }
}

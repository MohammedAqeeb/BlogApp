import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:blog_app/features/auth/domain/usecase/current_user.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_source/remote_blog.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositries/blog_repo.dart';
import 'package:blog_app/features/blog/domain/usecases/blog_upload.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/keys/app_keys.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecase/sign_in.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependendcy() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  //core related dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // DataSource instance
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository instance
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(
        serviceLocator(),
      ),
    )
    // userSignUp UseCase instance
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )
    // userSignIn UseCase instance
    ..registerFactory(
      () => UserSignIn(
        authRepository: serviceLocator(),
      ),
    )
    // Current User UseCase instance
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    // AuthBloc instance
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // DataSource instance
  serviceLocator
    ..registerFactory<RemoteBlogDataSoure>(
      () => RemoteBlogDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository instance
    ..registerFactory<BlogRepositary>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    //  Blog Upload UseCase instance
    ..registerFactory(
      () => BlogUploadUseCase(
        serviceLocator(),
      ),
    )
    // Blog Bloc instance
    ..registerLazySingleton(
      () => BlogBloc(
        blogUploadUseCase: serviceLocator(),
      ),
    );
}

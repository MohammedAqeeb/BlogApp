import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:blog_app/features/auth/domain/usecase/current_user.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/keys/app_keys.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecase/sign_in.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependendcy() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  //core related dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

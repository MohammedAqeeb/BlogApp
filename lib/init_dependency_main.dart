part of 'init_dependency.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependendcy() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.anonKey,
  );

  // instance of Supabase
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Connection Checker instance
  // serviceLocator.registerFactory(() => InternetConnection());

  // Hive Path to a user directory for storing locally
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  // Hive Dependency
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));

  //core related dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // Network Dependency
  // serviceLocator.registerFactory<CheckNetworkConnectivity>(
  //   () => CheckNetworkConnectivityImpl(
  //     serviceLocator(),
  //   ),
  // );
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
        // serviceLocator(),
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
    // Local remote datasource instance
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImp(
        serviceLocator(),
      ),
    )
    // Repository instance
    ..registerFactory<BlogRepositary>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        // serviceLocator(),
      ),
    )
    //  Blog Upload UseCase instance
    ..registerFactory(
      () => BlogUploadUseCase(
        serviceLocator(),
      ),
    )
    // fetch Blog UseCase instance
    ..registerFactory(
      () => FetchBlogUseCase(
        serviceLocator(),
      ),
    )

    // Blog Bloc instance
    ..registerLazySingleton(
      () => BlogBloc(
        blogUploadUseCase: serviceLocator(),
        fetchBlogUseCase: serviceLocator(),
      ),
    );
}

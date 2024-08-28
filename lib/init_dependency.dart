import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
// import 'package:blog_app/core/network/check_connectivity.dart';
import 'package:blog_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:blog_app/features/auth/domain/usecase/current_user.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_source/local_blog.dart';
import 'package:blog_app/features/blog/data/data_source/remote_blog.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositries/blog_repo.dart';
import 'package:blog_app/features/blog/domain/usecases/blog_upload.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/keys/app_keys.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecase/sign_in.dart';

part 'init_dependency_main.dart';

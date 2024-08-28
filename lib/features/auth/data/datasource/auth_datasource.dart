import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// interface to interacts with database/supabase
///
///
abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  /// Function to get raw data weather user signed in or not
  ///
  @override
  Future<UserModel> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw CustomException('User Does\'t exists');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw CustomException(e.message);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  /// Function to send data to supabase for registering users
  ///
  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw CustomException('User is null!!');
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } on AuthException catch (e) {
      throw CustomException(e.message);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  /// Function to check the current user sessions
  ///
  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        // from supabase tables checking weather the current user matches with the registered users
        final userSession = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);

        return UserModel.fromJson(userSession.first);
      }

      return null;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}

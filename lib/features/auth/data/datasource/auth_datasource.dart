import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> signInEmailPassword({
    required String email,
    required String password,
  });
}

class AuthService implements AuthDataSource {
  final SupabaseClient supabaseClient;

  AuthService(this.supabaseClient);

  @override
  Future<String> signInEmailPassword({
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
      return response.session!.accessToken;
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailPassword({
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
      return response.user!.id;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}

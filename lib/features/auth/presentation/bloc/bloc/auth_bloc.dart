import 'package:blog_app/features/auth/domain/usecase/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      final res = await _userSignUp(
        UserSignUpParam(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );

      res.fold(
        (l) => emit(AuthFailure(failureMessage: l.message)),
        (r) => emit(AuthSuccess(userId: r)),
      );
    });
  }
}

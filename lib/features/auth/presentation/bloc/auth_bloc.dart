import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/entity/user.dart';
import 'package:blog_app/features/auth/domain/usecase/current_user.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_in.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpEvent>(_authSignUp);
    on<AuthSignInEvent>(_authSignIn);
    on<AuthUserLoggedIn>(_userLoggedIn);
  }

  /// Function to register the user
  ///
  void _authSignUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParam(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(failureMessage: l.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  /// Function to login the user
  ///
  void _authSignIn(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignIn(
      UseCaseSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (onFailure) => emit(AuthFailure(failureMessage: onFailure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  /// Function to check weather the currentUser is logged in or not
  ///
  ///
  void _userLoggedIn(
    AuthUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final user = await _currentUser(NoParams());

    user.fold(
      // if not logged it then displays the message
      (isNotLogged) => emit(AuthFailure(failureMessage: isNotLogged.message)),
      // if user is logged in then updateUser function is called
      (loggedUser) => _emitAuthSuccess(loggedUser, emit),
    );
  }

  /// Function to update the logged in user
  ///
  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}

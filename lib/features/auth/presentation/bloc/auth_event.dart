part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String email, name, password;

  AuthSignUpEvent({
    required this.email,
    required this.name,
    required this.password,
  });
}

final class AuthSignInEvent extends AuthEvent {
  final String email, password;

  AuthSignInEvent({
    required this.email,
    required this.password,
  });
}

final class AuthUserLoggedIn extends AuthEvent {}

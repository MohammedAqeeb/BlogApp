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

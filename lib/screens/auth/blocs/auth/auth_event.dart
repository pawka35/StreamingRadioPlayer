part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthInitEvent extends AuthEvent {}

class AuthDoneEvent extends AuthEvent {
  final User user;

  AuthDoneEvent(this.user);
}

class AuthLogOutEvent extends AuthEvent {}

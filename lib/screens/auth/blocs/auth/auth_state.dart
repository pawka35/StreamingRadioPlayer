part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthDoneState extends AuthState {
  final User user;

  const AuthDoneState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class AuthNeededState extends AuthState {
  @override
  List<Object?> get props => [];
}

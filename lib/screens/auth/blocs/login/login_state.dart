part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

class LoginNeedEnterOtpState extends LoginState {}

class LoginOtpSuccessState extends LoginState {
  final User user;

  LoginOtpSuccessState(this.user);
}

class LoginOtpErrorState extends LoginState {
  final String message;

  LoginOtpErrorState(this.message);
}

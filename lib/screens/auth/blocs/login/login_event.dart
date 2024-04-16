part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginGetOtpSendEvent extends LoginEvent {
  final String phoneNumber;

  LoginGetOtpSendEvent(this.phoneNumber);
}

class LoginOtpEnteredEvent extends LoginEvent {
  final String otpCode;

  LoginOtpEnteredEvent(this.otpCode);
}

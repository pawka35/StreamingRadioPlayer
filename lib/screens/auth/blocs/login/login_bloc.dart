import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../repositories/auth/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginGetOtpSendEvent>((event, emit) {
      FireBaseAuth.sentOtp(phoneNumber: event.phoneNumber);
      emit(LoginNeedEnterOtpState());
    });

    on<LoginOtpEnteredEvent>((event, emit) async {
      var result = await FireBaseAuth.loginWithOtp(otp: event.otpCode);
      if (result.user != null) {
        emit(LoginOtpSuccessState(result.user!));
      } else {
        emit(LoginOtpErrorState(result.message));
      }
    });
  }
}

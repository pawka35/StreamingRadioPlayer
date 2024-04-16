import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/repositories/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthInitEvent>((event, emit) async {
      var currentUser = await FireBaseAuth.getUser();
      if (currentUser != null) {
        emit(AuthDoneState(user: currentUser));
      } else {
        emit(AuthNeededState());
      }
    });

    on<AuthDoneEvent>((event, emit) async {
      emit(AuthDoneState(user: event.user));
    });

    on<AuthLogOutEvent>((event, emit) async {
      FireBaseAuth.logout();
      emit(AuthNeededState());
    });
  }
}

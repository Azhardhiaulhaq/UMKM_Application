import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umkm_application/Authentication/data/repositories/user_repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
        if (event is SignInButtonPressed){
      yield LoginLoading();

      try {
        var user = await UserRepository.signIn(event.email, event.password);
        if (user != null){
          yield LoginSucceed(user:user);
        } else {
          yield LoginFailed(message: 'Email atau Password yang digunakan salah');
        }
      } catch(e){
        yield LoginFailed(message: e.toString());
      }
    }
  }
}

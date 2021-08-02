import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umkm_application/data/repositories/user_repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppLoaded){
      try{
        var isSignedIn = await UserRepository.isSignedIn();
        if (isSignedIn){
          var user = await UserRepository.getCurrentUser();
          if (user != null){
            yield AuthenticateState(user: user);
          } else {
            yield UnAuthenticateState();
          }
        } else {
          yield UnAuthenticateState();
        }
      } catch(e){
        yield UnAuthenticateState();
      }
    }
  }
}

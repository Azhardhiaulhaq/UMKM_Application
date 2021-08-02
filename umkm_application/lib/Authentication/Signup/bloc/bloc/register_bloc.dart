import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umkm_application/data/repositories/user_repositories.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUpButtonPressed){
      yield RegisterLoading();

      try {
        var user = await UserRepository.signUp(event.email, event.password, event.umkmName);
        if (user != null){
          yield RegisterSucceed(user:user);
        } else {
          yield RegisterFailed(message: 'Alamat Email telah digunakan oleh akun lain');
        }
        
      } catch(e){
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}

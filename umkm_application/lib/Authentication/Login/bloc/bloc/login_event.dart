part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SignInButtonPressed extends LoginEvent {
  String email, password;
  SignInButtonPressed({required this.email, required this.password});
}
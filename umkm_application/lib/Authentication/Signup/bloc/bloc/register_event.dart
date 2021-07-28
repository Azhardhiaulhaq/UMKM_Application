part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SignUpButtonPressed extends RegisterEvent {
  String email, password, umkmName;
  SignUpButtonPressed({required this.email, required this.password, required this.umkmName});
}
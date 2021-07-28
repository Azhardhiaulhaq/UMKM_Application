import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm_application/Authentication/Signup/bloc/bloc/register_bloc.dart';
import 'package:umkm_application/Authentication/Signup/ui/signup.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
          child: SignUpPage(title: 'Title')),
    );
  }
}

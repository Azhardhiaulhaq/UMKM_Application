import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm_application/Authentication/Login/bloc/bloc/login_bloc.dart';
import 'package:umkm_application/Authentication/Login/ui/login.dart';

class LoginScreen extends StatelessWidget{
 const LoginScreen({Key? key,}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: LoginPage(title: 'Title')
      ),
    );
  }
  
}
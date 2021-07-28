import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Authentication/Login/ui/login.dart';
import 'package:umkm_application/Authentication/Login/ui/loginscreen.dart';
import 'package:umkm_application/Authentication/bloc/auth_bloc.dart';
import 'package:umkm_application/Authentication/data/repositories/user_repositories.dart';
import 'package:umkm_application/BottomNav/ui/bottomnav.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('Main');
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'UMKM Application',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (context)=>AuthBloc()..add(AppLoaded()),
      child:MainScreen())
    );
  }
}

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key : key);
  @override
  Widget build(BuildContext context) {
        return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnAuthenticateState) {
          return LoginScreen();
        } else if (state is AuthenticateState) {
          return BottomNavigation(
            menuScreenContext: context,
          );
        }

        return Container();
      },
    );
  }
  
}
// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Authentication/Login/bloc/bloc/login_bloc.dart';
import 'package:umkm_application/Authentication/Signup/ui/signupscreen.dart';
import 'package:umkm_application/Const/const_color.dart';
import '../../../widget/bezierContainer.dart';

class CoachingPage extends StatefulWidget {
  CoachingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CoachingPageState createState() => _CoachingPageState();
}

class _CoachingPageState extends State<CoachingPage> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Kembali',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Expanded(
            child: Container(
              color: ConstColor.lightBluePastelBG,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'UMKM CLINIC',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: ConstColor.darkDatalab),
                    ),
                    Text(
                      'Ikuti Coaching Clinic bersama mentor-mentor terbaik dari Sekolah Bisnis dan Manajemen ITB. Segera atur jadwalnya dan dapatkan ilmu baru untuk membuat UMKM anda melesat.',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ConstColor.darkDatalab,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

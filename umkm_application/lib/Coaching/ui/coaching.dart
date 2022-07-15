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
import 'package:url_launcher/url_launcher.dart';
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

  Widget _coachingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ConstColor.darkDatalab,ConstColor.darkDatalab])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              openLink('https://datalab.sbm-itb.org/coaching-clinic-2/');
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Ikuti Coaching Clinic',
                    style: TextStyle(fontSize: 20, color: ConstColor.secondaryTextDatalab))),
          )),
    );
  }

  void openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      print('There was a problem to open the url: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
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
                          fontSize: 28,
                          color: ConstColor.darkDatalab),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Ikuti Coaching Clinic bersama mentor-mentor terbaik dari Sekolah Bisnis dan Manajemen ITB. Segera atur jadwalnya dan dapatkan ilmu baru untuk membuat UMKM anda melesat.',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ConstColor.darkDatalab,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image(image: AssetImage('assets/conference.png')),
                    SizedBox(height: 20,),
                    _coachingButton(context)

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

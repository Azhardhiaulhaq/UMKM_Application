import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _title() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Our',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400)),
                  Text('UMKM Members',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700))
                ])
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ], 
                  begin: Alignment.topCenter, 
                  end: Alignment.bottomCenter)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _title()
                ],)
            ))
      ]),
    ));
  }
}
// Container(
//         decoration: BoxDecoration(color: ConstColor.lightgreyBG),
//         child: Center(child: Text('Home Screen')));

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

class DummyStatisticPage extends StatefulWidget {
  DummyStatisticPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DummyStatisticPageState createState() => _DummyStatisticPageState();
}

class _DummyStatisticPageState extends State<DummyStatisticPage> {

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
              openLink('https://datalab-sbmitb.shinyapps.io/sm-dashboard');
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Dapatkan Statistik Produkmu',
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
          Expanded(
            child: Container(
              color: ConstColor.backgroundDatalab,
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
                      'Product Analysis',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: ConstColor.darkDatalab),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Dapatkan analisa secara nyata dari sosial media untuk produk-produk yang kamu jual! Data ini bisa digunakan untuk menganalisa penjualan dan penerimaan produk dalam masyarakat!',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ConstColor.darkDatalab,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image(image: AssetImage('assets/5024152.png'), fit: BoxFit.fitWidth,),
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

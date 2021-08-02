import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: must_be_immutable
class EventDetail extends StatelessWidget {
  final BuildContext context;
  String name;
  String author;
  String bannerImage;
  String contactPerson;
  DateTime date;
  String description;
  String link;
  String location;
  EventDetail(
      {Key? key,
      required this.context,
      required this.name,
      required this.author,
      required this.bannerImage,
      required this.contactPerson,
      required this.date,
      required this.description,
      required this.link,
      required this.location})
      : super(key: key);

  Future<void> share(String phone, String text) async {
    await WhatsappShare.share(
      text: text,
      phone: phone,
    );
  }

  Future<void> isInstalled() async {
    final val = await WhatsappShare.isInstalled();
    print('Whatsapp is installed: $val');
  }

  void openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      print('There was a problem to open the url: $url');
    }
  }

  Widget _eventImage(String image) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fitWidth),
                  border: Border.all(color: Color(0xfff7f7f7)),
                  borderRadius: BorderRadius.circular(16)))),
    );
  }

  Widget _eventTitle(String name, String author, String date, String location) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: <Widget>[
                          Icon(Icons.date_range_rounded,
                              color: Colors.blueAccent),
                          SizedBox(
                            width: 8,
                          ),
                          Text(date,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: <Widget>[
                          Icon(Icons.location_city,
                              color: Colors.redAccent),
                          SizedBox(
                            width: 8,
                          ),
                          Text(location,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Oleh : ' + author,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                  ))),
        ));
  }

  Widget _eventDescription(String description) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deskripsi',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(description,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                            textAlign: TextAlign.justify),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Contact Person',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text('+62 ' + contactPerson,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Icon(MdiIcons.whatsapp,
                                  color: Colors.green, size: 30),
                              onPressed: () {
                                share('62' + contactPerson, 'Halo');
                              },
                            )),
                      ],
                    ),
                  ))),
        ));
  }

  Widget _linkButton(String link) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            openLink(link);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                        height: 20,
                        child: Center(
                          child: Text(
                            'DAFTAR',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ))),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ConstColor.sbmdarkBlue,
          elevation: 1,
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
        ),
        body: SafeArea(
          child: Stack(fit: StackFit.expand, children: <Widget>[
            SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
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
                        SizedBox(height: 20),
                        _eventImage(bannerImage),
                        _eventTitle(
                            name, author, DateFormat.yMMMMd().format(date), location),
                        _eventDescription(description),
                        SizedBox(
                          height: 10,
                        ),
                        _linkButton(link),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )))
          ]),
        ));
  }
}

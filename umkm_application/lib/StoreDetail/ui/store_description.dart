import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class StoreDescription extends StatelessWidget {
  late DocumentReference statistics;
  final BuildContext context;
  String id;
  String name;
  String image;
  String city;
  String province;
  String address;
  List<String> tags;
  String bukalapak;
  String description;
  String email;
  String facebook;
  String instagram;
  String phone;
  String shoope;
  String tokopedia;
  // ignore: non_constant_identifier_names
  String youtube_link;
  StoreDescription({
    Key? key,
    required this.context,
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.province,
    required this.address,
    required this.tags,
    required this.bukalapak,
    required this.description,
    required this.email,
    required this.facebook,
    required this.instagram,
    required this.phone,
    required this.shoope,
    required this.tokopedia,
    // ignore: non_constant_identifier_names
    required this.youtube_link,
  }) : super(key: key);

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

  Widget _overviewStore() {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(image),
                          minRadius: 30,
                          maxRadius: 50,
                        ),
                        SizedBox(width: 5),
                        VerticalDivider(),
                        SizedBox(width: 5),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(city + ', ' + province,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                SizedBox(height: 15),
                                Row(children: <Widget>[
                                  Icon(Icons.email,
                                      color: ConstColor.sbmdarkBlue),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(email,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(children: <Widget>[
                                  Icon(Icons.local_phone_rounded,
                                      color: ConstColor.sbmdarkBlue),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('0' + phone,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))
                                ])
                              ],
                            ))
                      ],
                    ),
                  ))),
        ));
  }

  Widget _videoPromotion() {
    String? videoID = YoutubePlayer.convertUrlToId(youtube_link);
    YoutubePlayerController _youtubeController = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
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
                      child: Column(children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('Video Promosi',
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: ConstColor.sbmlightBlue,
                          progressColors: ProgressBarColors(
                              playedColor: ConstColor.sbmlightBlue,
                              handleColor: ConstColor.sbmdarkBlue),
                        ),
                      ]))))),
    );
  }

  Widget _descriptionStore() {
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
                      child: Column(children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Deskripsi Toko',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            description,
                            style: GoogleFonts.lato(
                                color: Colors.black, fontSize: 14),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Lokasi',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            address + ', ' + city + ', ' + province,
                            style: GoogleFonts.lato(
                                color: Colors.black, fontSize: 14),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Kontak dan Sosial Media',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text('+62 ' + phone,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Icon(MdiIcons.whatsapp,
                                  color: Colors.green, size: 30),
                              onPressed: () {
                                share('62' + phone, 'Halo');
                              },
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(instagram,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Icon(MdiIcons.instagram,
                                  color: Color(0xffE1306C), size: 30),
                              onPressed: () {
                                openLink('https://www.instagram.com/' +
                                    instagram +
                                    '/');
                              },
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(facebook,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Icon(MdiIcons.facebook,
                                  color: Color(0xff4267B2), size: 30),
                              onPressed: () {
                                openLink('https://www.facebook.com/' +
                                    facebook +
                                    '/');
                              },
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Marketplace',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(tokopedia,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Image.asset("assets/tokopedia.png",
                                  width: 30, height: 30),
                              onPressed: () {
                                statistics.update({'tokopedia':FieldValue.increment(1)});
                                openLink('https://www.tokopedia.com/' +
                                    tokopedia +
                                    '/');
                              },
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(shoope,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Image.asset("assets/shopee.png",
                                  width: 30, height: 30),
                              onPressed: () {
                                statistics.update({'shopee':FieldValue.increment(1)});
                                openLink(
                                    'https://www.shopee.co.id/' + shoope + '/');
                              },
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(bukalapak,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Image.asset("assets/bukalapak.png",
                                  width: 30, height: 30),
                              onPressed: () {
                                statistics.update({'bukalapak':FieldValue.increment(1)});
                                openLink('https://www.bukalapak.com/' +
                                    bukalapak +
                                    '/');
                              },
                            )),
                      ]))))),
    );
  }

  @override
  Widget build(BuildContext context) {
    statistics = FirebaseFirestore.instance.collection('statistics').doc(id);
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    _overviewStore(),
                    SizedBox(height: 5),
                    _videoPromotion(),
                    SizedBox(height: 5),
                    _descriptionStore(),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                )))
      ]),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/widget/store_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDescription extends StatelessWidget {
  final BuildContext context;
  final Store model;
  StoreDescription({Key? key, required this.context, required this.model})
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

  void openLink(String url) async{
    if (await canLaunch(url)){
      await launch(url, universalLinksOnly: true);
    } else {
      print('There was a problem to open the url: $url');
    }
  }

  Widget _overviewStore(Store model) {
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
                          backgroundImage: NetworkImage(model.image),
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
                                Text(model.name,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(model.city + ', ' + model.province,
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
                                  Text('Sepatu@gmail.com',
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
                                  Text('087851962334',
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

  Widget _videoPromotion(Store model) {
    String videoID = YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=3grIIRIzpM0")
        .toString();
    YoutubePlayerController _youtubeController = YoutubePlayerController(
      initialVideoId: videoID,
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
                          child: Text('Promotion Video',
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

  Widget _descriptionStore(Store model) {
    String assetName = 'assets\whatsapp-icon.svg';
    Widget svgIcon = SvgPicture.asset(assetName);
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
                            'Description',
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
                            'Sepatu Murah Surabaya adalah sebuah UMKM lokal asli Surabaya yang bergerak dalam bidang fashion. Didirakan oleh sudirman pada tahun 1907',
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
                            'Location',
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
                            'Jl. Ganesha No. 10, Bandung, Jawa Barat. 40135',
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
                            'Contact',
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
                              label: Text('+ ' + '6287851942992',
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Icon(MdiIcons.whatsapp,
                                  color: Colors.green, size: 30),
                              onPressed: () {
                                share('6287851942992', 'Halo');
                              },
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text('azhardhiaulhaq',
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Icon(MdiIcons.instagram, color: Color(0xffE1306C),size: 30),
                              onPressed: () {
                                openLink('https://www.instagram.com/' + 'azhardhiaulhaq' +'/');
                              },
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text('azhardhiaulhaq',
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14)),
                              icon: Icon(MdiIcons.facebook, color: Color(0xff4267B2),size: 30),
                              onPressed: () {
                                openLink('https://www.facebook.com/' + 'AzharDhiaulhaq29' +'/');
                              },
                            )),
                      ]))))),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    _overviewStore(model),
                    SizedBox(height: 5),
                    _videoPromotion(model),
                    SizedBox(height: 5),
                    _descriptionStore(model),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                )))
      ]),
    ));
  }
}

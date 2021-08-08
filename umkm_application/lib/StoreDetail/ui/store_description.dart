import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umkm_application/Authentication/Login/ui/loginscreen.dart';
import 'package:umkm_application/StoreDetail/ui/description_form_page_screen.dart';
import 'package:umkm_application/data/repositories/pref_repositories.dart';
import 'package:umkm_application/data/repositories/statistic_repositories.dart';
import 'package:umkm_application/data/repositories/user_repositories.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:umkm_application/data/repositories/store_repositories.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class StoreDescription extends StatefulWidget {
  StoreDescription({
    Key? key,
    required this.context,
    required this.id,
  }) : super(key: key);
  late DocumentReference statistics;
  final BuildContext context;

  String id;

  @override
  _StoreDescriptionState createState() => _StoreDescriptionState(
        context: context,
        id: id,
      );
}

// ignore: must_be_immutable
class _StoreDescriptionState extends State<StoreDescription> {
  late DocumentReference statistics;
  final BuildContext context;
  String id;

  _StoreDescriptionState({
    Key? key,
    required this.context,
    required this.id,
  });
  late String _userID;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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

  Widget _overviewStore(String image, String name, String city, String province,
      String email, String phone) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
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
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: image != '' ? NetworkImage(image) : NetworkImage('https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png'),
                              minRadius: 30,
                              maxRadius: 50,
                              backgroundColor: ConstColor.darkDatalab,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            _userID == id
                                ? SizedBox(
                                    height: 25,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();
                                        final XFile? image =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);
                                        File _imageFile = File(image!.path);
                                        await StoreRepository.updateImage(
                                            id, _imageFile);
                                      },
                                      child: Text('Ubah Foto'),
                                      style: ElevatedButton.styleFrom(
                                          elevation: 3,
                                          primary: ConstColor.darkDatalab,
                                          shape: StadiumBorder()),
                                    ))
                                : Container(),
                            _userID == id
                                ? SizedBox(
                                    height: 8,
                                  )
                                : Container(),
                            _userID == id
                                ? SizedBox(
                                    height: 25,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await UserRepository.signOut()
                                            .then((user) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
                                        });
                                      },
                                      child: Text('Keluar'),
                                      style: ElevatedButton.styleFrom(
                                          elevation: 3,
                                          primary: ConstColor.failedNotification,
                                          shape: StadiumBorder()),
                                    ))
                                : Container(),
                          ],
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
                                    style: GoogleFonts.lato(
                                        color: ConstColor.textDatalab,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    city != ''
                                        ? city + ', ' + province
                                        : 'Lokasi UMKM Belum Ditambahkan',
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.lato(
                                        color: ConstColor.textDatalab,
                                        fontSize: 14)),
                                SizedBox(height: 15),
                                Row(children: <Widget>[
                                  Icon(Icons.email,
                                      color: ConstColor.textDatalab),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(email,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(children: <Widget>[
                                  Icon(Icons.local_phone_rounded,
                                      color: ConstColor.textDatalab),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                      phone != ''
                                          ? '0' + phone
                                          : 'Nomor Belum Ditambahkan',
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.lato(
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

  Widget _videoPromotion(String youtube_link) {
    String? videoID = YoutubePlayer.convertUrlToId(youtube_link) != null
        ? YoutubePlayer.convertUrlToId(youtube_link)
        : '';
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
                                  color: ConstColor.textDatalab,
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

  Widget _descriptionStore(String description, address, city, province, phone,
      instagram, facebook, tokopedia, shoope, bukalapak) {
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
                                color: ConstColor.textDatalab,
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
                            description != ''
                                ? description
                                : 'Deskripsi UMKM Belum Ditambahkan',
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
                                color: ConstColor.textDatalab,
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
                            city != ''
                                ? address + ', ' + city + ', ' + province
                                : 'Lokasi UMKM Belum Ditambahkan',
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
                                color: ConstColor.textDatalab,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        phone != ''
                            ? Container(
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
                                ))
                            : Container(),
                        instagram != ''
                            ? Container(
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
                                ))
                            : Container(),
                        facebook != ''
                            ? Container(
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
                                ))
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Marketplace',
                            style: GoogleFonts.lato(
                                color: ConstColor.textDatalab,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        tokopedia != ''
                            ? Container(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  label: Text(tokopedia,
                                      style: GoogleFonts.lato(
                                          color: Colors.black, fontSize: 14)),
                                  icon: Image.asset("assets/tokopedia.png",
                                      width: 30, height: 30),
                                  onPressed: () {
                                    StatisticRepository.updateStatistic(
                                        id, 'tokopedia');
                                    openLink('https://www.tokopedia.com/' +
                                        tokopedia +
                                        '/');
                                  },
                                ))
                            : Container(),
                        shoope != ''
                            ? Container(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  label: Text(shoope,
                                      style: GoogleFonts.lato(
                                          color: Colors.black, fontSize: 14)),
                                  icon: Image.asset("assets/shopee.png",
                                      width: 30, height: 30),
                                  onPressed: () {
                                    StatisticRepository.updateStatistic(
                                        id, 'shopee');
                                    openLink('https://www.shopee.co.id/' +
                                        shoope +
                                        '/');
                                  },
                                ))
                            : Container(),
                        bukalapak != ''
                            ? Container(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  label: Text(bukalapak,
                                      style: GoogleFonts.lato(
                                          color: Colors.black, fontSize: 14)),
                                  icon: Image.asset("assets/bukalapak.png",
                                      width: 30, height: 30),
                                  onPressed: () {
                                    StatisticRepository.updateStatistic(
                                        id, 'bukalapak');
                                    openLink('https://www.bukalapak.com/' +
                                        bukalapak +
                                        '/');
                                  },
                                ))
                            : Container(),
                      ]))))),
    );
  }

  Future<void> initPreference() async {
    _userID = await PrefRepository.getUserID() ?? '';
  }

  @override
  void initState() {
    super.initState();
    initPreference().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    statistics = FirebaseFirestore.instance.collection('statistics').doc(id);
    return StreamBuilder<DocumentSnapshot>(
      stream: users.doc(id).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: ConstColor.darkDatalab,));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Stack(fit: StackFit.expand, children: <Widget>[
              SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            ConstColor.backgroundDatalab,
                            ConstColor.backgroundDatalab
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          _overviewStore(
                              snapshot.data!.get('image'),
                              snapshot.data!.get('umkm_name'),
                              snapshot.data!.get('city'),
                              snapshot.data!.get('province'),
                              snapshot.data!.get('email'),
                              snapshot.data!.get('phone_number')),
                          SizedBox(height: 5),
                          snapshot.data!.get('youtube_link') != ''
                              ? _videoPromotion(
                                  snapshot.data!.get('youtube_link'))
                              : Container(),
                          SizedBox(height: 5),
                          _descriptionStore(
                              snapshot.data!.get('description'),
                              snapshot.data!.get('address'),
                              snapshot.data!.get('city'),
                              snapshot.data!.get('province'),
                              snapshot.data!.get('phone_number'),
                              snapshot.data!.get('instagram_acc'),
                              snapshot.data!.get('facebook_acc'),
                              snapshot.data!.get('tokopedia_name'),
                              snapshot.data!.get('shoope_name'),
                              snapshot.data!.get('bukalapak_name')),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      )))
            ]),
          ),
          floatingActionButton: _userID == id
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoreFormScreen(
                                  address: snapshot.data!.get('address'),
                                  bukalapakName:
                                      snapshot.data!.get('bukalapak_name'),
                                  city: snapshot.data!.get('city'),
                                  description:
                                      snapshot.data!.get('description'),
                                  email: snapshot.data!.get('email'),
                                  province: snapshot.data!.get('province'),
                                  facebookAcc:
                                      snapshot.data!.get('facebook_acc'),
                                  instagramAcc:
                                      snapshot.data!.get('instagram_acc'),
                                  phoneNumber:
                                      snapshot.data!.get('phone_number'),
                                  shoopeName: snapshot.data!.get('shoope_name'),
                                  tag: snapshot.data!.get('tag').cast<String>(),
                                  tokopediaName:
                                      snapshot.data!.get('tokopedia_name'),
                                  uid: id,
                                  umkmName: snapshot.data!.get('umkm_name'),
                                  youtubeLink:
                                      snapshot.data!.get('youtube_link'),
                                )));
                  },
                  label: Text("Sunting Profile"),
                  icon: Icon(Icons.edit),
                  backgroundColor: ConstColor.darkDatalab,
                )
              : Container(),
          floatingActionButtonLocation: AlmostEndFloatFabLocation(),
        );
      },
    );
  }
}

class AlmostEndFloatFabLocation extends StandardFabLocation
    with FabEndOffsetX, FabFloatOffsetY {
  @override
  double getOffsetX(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? 5.0 : 0;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }

  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? 350 : -10;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }
}

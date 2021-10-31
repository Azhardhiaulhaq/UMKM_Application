import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umkm_application/Authentication/Login/ui/loginscreen.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/StoreDetail/ui/description_form_page_screen.dart';
import 'package:umkm_application/data/repositories/shared_pref_repositories.dart';
import 'package:umkm_application/data/repositories/statistic_repositories.dart';
import 'package:umkm_application/data/repositories/user_repositories.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:umkm_application/data/repositories/store_repositories.dart';
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
  late YoutubePlayerController _youtubeController;
  String id;

  _StoreDescriptionState({
    Key? key,
    required this.context,
    required this.id,
  });
  late String _userID;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference stores = FirebaseFirestore.instance.collection('stores');

  Future<void> share(String phone, String message) async {
    var phoneNumber = '+' + phone;
    // ignore: non_constant_identifier_names
    var whatsappURl_android =
        "whatsapp://send?phone=" + phoneNumber + "&text=" + message;
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
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
                              backgroundImage: image != ''
                                  ? NetworkImage(image)
                                  : NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
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
                                          primary:
                                              ConstColor.failedNotification,
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
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return youtube_link != ''
        ? Material(
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
          )
        : Container();
  }

  Widget _descriptionStore(String description, address, city, province, phone,
      instagram, facebook, tokopedia, shoope, bukalapak, umkm_name) {
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
                                    share('62' + phone,
                                        'Halo. Apakah ini benar dengan pemilik $umkm_name ?');
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

  @override
  void initState() {
    super.initState();
    _userID = sharedPrefs.userid;
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    statistics = FirebaseFirestore.instance.collection('statistics').doc(id);
    return StreamBuilder<DocumentSnapshot>(
      stream: stores.doc(id).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: ConstColor.darkDatalab,
          ));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }
        var storeMap = snapshot.data!.data() as Map<String, dynamic>;
        Store store = Store(
            id: id,
            address: storeMap['address'] ?? '',
            bukalapakName: storeMap['bukalapak_name'] ?? '',
            city: storeMap['city'] ?? '',
            description: storeMap['description'] ?? '',
            email: storeMap['email'] ?? '',
            facebookAcc: storeMap['facebook_acc'] ?? '',
            image: storeMap['image'] ?? '',
            instagramAcc: storeMap['instagram_acc'],
            phoneNumber: storeMap['phone_number'],
            province: storeMap['province'] ?? '',
            shopeeName: storeMap['shopee_name'] ?? '',
            name: storeMap['umkm_name'] ?? '',
            tokopediaName: storeMap['tokopedia_name'] ?? '',
            youtubeLink: storeMap['youtube_link'] ?? '',
            tags: List.from(storeMap['tag'] ?? []));
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
                              store.image,
                              store.name,
                              store.city,
                              store.province,
                              store.email ?? '',
                              store.phoneNumber ?? ''),
                          SizedBox(height: 5),
                          _videoPromotion(store.youtubeLink ?? ''),
                          SizedBox(height: 5),
                          _descriptionStore(
                              store.description ?? '',
                              store.address ?? '',
                              store.city,
                              store.province,
                              store.phoneNumber ?? '',
                              store.instagramAcc ?? '',
                              store.facebookAcc ?? '',
                              store.tokopediaName ?? '',
                              store.shopeeName ?? '',
                              store.bukalapakName ?? '',
                              store.name),
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
                    Navigator.pushNamed(context, StoreFormScreen.routeName,
                        arguments: {'store': store});
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

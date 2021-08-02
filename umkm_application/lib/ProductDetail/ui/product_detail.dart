import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/StoreDetail/ui/product_form_page_screen.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:whatsapp_share/whatsapp_share.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail(
      {Key? key,
      required this.context,
      required this.umkmid,
      required this.productid,
      required this.tokopedia,
      required this.shopee,
      required this.bukalapak})
      : super(key: key);
  late DocumentReference statistics;
  final BuildContext context;
  String umkmid;
  String productid;
  String tokopedia;
  String shopee;
  String bukalapak;

  @override
  _ProductDetailState createState() => _ProductDetailState(
      context: context,
      umkmid: umkmid,
      productid: productid,
      tokopedia: tokopedia,
      shopee: shopee,
      bukalapak: bukalapak);
}

// ignore: must_be_immutable
class _ProductDetailState extends State<ProductDetail> {
  late DocumentReference statistics;
  final BuildContext context;
  String umkmid;
  String productid;
  String tokopedia;
  String shopee;
  String bukalapak;
  _ProductDetailState(
      {required this.context,
      required this.umkmid,
      required this.productid,
      required this.tokopedia,
      required this.shopee,
      required this.bukalapak});
  late SharedPreferences prefs;
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

  Widget _productImage(String image, int price) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.contain),
                  border: Border.all(color: Color(0xfff7f7f7)),
                  borderRadius: BorderRadius.circular(16)))),
    );
  }

  Widget _productTitle(String name, int price) {
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
                                fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Rp. ' + price.toString(),
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                  ))),
        ));
  }

  Widget _productDescription(String description) {
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
                                fontSize: 16)),
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
                        Text('Dapatkan Produk',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  label: Text('',
                                      style: GoogleFonts.lato(
                                          color: Colors.black, fontSize: 14)),
                                  icon: Image.asset("assets/tokopedia.png",
                                      width: 30, height: 30),
                                  onPressed: () {
                                    statistics.update(
                                        {'tokopedia': FieldValue.increment(1)});
                                    openLink('https://www.tokopedia.com/' +
                                        tokopedia +
                                        '/');
                                  },
                                )),
                            Container(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  label: Text('',
                                      style: GoogleFonts.lato(
                                          color: Colors.black, fontSize: 14)),
                                  icon: Image.asset("assets/shopee.png",
                                      width: 30, height: 30),
                                  onPressed: () {
                                    statistics.update(
                                        {'shopee': FieldValue.increment(1)});
                                    openLink('https://www.shopee.co.id/' +
                                        shopee +
                                        '/');
                                  },
                                )),
                            Container(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  label: Text('',
                                      style: GoogleFonts.lato(
                                          color: Colors.black, fontSize: 14)),
                                  icon: Image.asset("assets/bukalapak.png",
                                      width: 30, height: 30),
                                  onPressed: () {
                                    statistics.update(
                                        {'bukalapak': FieldValue.increment(1)});
                                    openLink('https://www.bukalapak.com/' +
                                        bukalapak +
                                        '/');
                                  },
                                )),
                          ],
                        )
                      ],
                    ),
                  ))),
        ));
  }

  Future<void> initPreference() async {
    this.prefs = await SharedPreferences.getInstance();
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
    statistics =
        FirebaseFirestore.instance.collection('statistics').doc(umkmid);
    return StreamBuilder<DocumentSnapshot>(
      stream:
          users.doc(umkmid).collection('products').doc(productid).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }

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
                          _productImage(snapshot.data!.get('image'),
                              snapshot.data!.get('price')),
                          _productTitle(snapshot.data!.get('name'),
                              snapshot.data!.get('price')),
                          _productDescription(
                              snapshot.data!.get('description')),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      )))
            ]),
          ),
          floatingActionButton: this.prefs.getString("userid") == umkmid
              ? Column(
                  children: [
                    FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductFormScreen(
                                      umkmid: umkmid,
                                      productid: productid,
                                      name: snapshot.data!.get('name'),
                                      description:
                                          snapshot.data!.get('description'),
                                      image: snapshot.data!.get('image'),
                                      price: snapshot.data!.get('price'),
                                    )));
                      },
                      label: Text("Sunting Produk"),
                      icon: Icon(Icons.edit),
                      backgroundColor: ConstColor.sbmdarkBlue,
                    ),
                  ],
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
        scaffoldGeometry.textDirection == TextDirection.ltr ? 450 : -10;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }
}

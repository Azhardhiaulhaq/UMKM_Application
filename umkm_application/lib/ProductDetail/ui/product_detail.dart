import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:whatsapp_share/whatsapp_share.dart';

// ignore: must_be_immutable
class ProductDetail extends StatelessWidget {
    late DocumentReference statistics;
  final BuildContext context;
  String umkmid;
  String name;
  String description;
  String image;
  int price;
  String tokopedia;
  String shopee;
  String bukalapak;
  ProductDetail(
      {Key? key,
      required this.context,
      required this.umkmid,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.tokopedia,
      required this.shopee,
      required this.bukalapak})
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

  Widget _productTitle(String name) {
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
                                    statistics.update({'tokopedia':FieldValue.increment(1)});
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
                                    statistics.update({'shopee':FieldValue.increment(1)});
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
                                    statistics.update({'bukalapak':FieldValue.increment(1)});
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

  @override
  Widget build(BuildContext context) {
    statistics = FirebaseFirestore.instance.collection('statistics').doc(umkmid);
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
                        _productImage(image, price),
                        _productTitle(name),
                        _productDescription(description),
                        // SizedBox(height: 5),
                        // _videoPromotion(model),
                        // SizedBox(height: 5),
                        // _descriptionStore(model),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )))
          ]),
        ));
  }
}

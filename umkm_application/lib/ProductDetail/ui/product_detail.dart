import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/ecommerce_link.dart';
import 'package:umkm_application/Model/product.dart';
import 'package:umkm_application/StoreDetail/ui/product_form_page_screen.dart';
import 'package:umkm_application/data/repositories/pref_repositories.dart';
import 'package:umkm_application/data/repositories/statistic_repositories.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  static const routeName = '/product/detail';
  ProductDetail(
      {Key? key,
      required this.umkmid,
      required this.productid,
      required this.ecommerceName})
      : super(key: key);
  late DocumentReference statistics;
  String umkmid;
  String productid;
  EcommerceName ecommerceName;

  @override
  _ProductDetailState createState() => _ProductDetailState(
      umkmid: umkmid,
      productid: productid,
      ecommerceName: ecommerceName);
}

// ignore: must_be_immutable
class _ProductDetailState extends State<ProductDetail> {
  late DocumentReference statistics;
  String umkmid;
  String productid;
  EcommerceName ecommerceName;
  _ProductDetailState(
      {
      required this.umkmid,
      required this.productid,
      required this.ecommerceName});
  late String _userID;
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
                            style: GoogleFonts.lato(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Rp. ' + price.toString(),
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.lato(
                                color: ConstColor.textDatalab, fontSize: 14)),
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
                            style: GoogleFonts.lato(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(description,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                            textAlign: TextAlign.justify),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Dapatkan Produk',
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.lato(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
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
                                    StatisticRepository.updateStatistic(
                                        umkmid, 'tokopedia');
                                    openLink('https://www.tokopedia.com/' +
                                        ecommerceName.tokopediaLink +
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
                                    StatisticRepository.updateStatistic(
                                        umkmid, 'shopee');
                                    openLink('https://www.shopee.co.id/' +
                                        ecommerceName.shopeeLink +
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
                                    StatisticRepository.updateStatistic(
                                        umkmid, 'bukalapak');
                                    openLink('https://www.bukalapak.com/' +
                                        ecommerceName.bukalapakLink +
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
    statistics =
        FirebaseFirestore.instance.collection('statistics').doc(umkmid);
    return StreamBuilder<DocumentSnapshot>(
      stream:
          stores.doc(umkmid).collection('products').doc(productid).snapshots(),
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
        var mapProduct = snapshot.data!.data() as Map<String, dynamic>;
        Product product = Product(
            id: snapshot.data!.id,
            name: mapProduct['name'] ?? '',
            description: mapProduct['description'] ?? '',
            image: mapProduct['image'] ?? '',
            price: mapProduct['price'] ?? 0);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ConstColor.darkDatalab,
            elevation: 1,
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left,
                    color: ConstColor.secondaryTextDatalab),
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
                            ConstColor.backgroundDatalab,
                            ConstColor.backgroundDatalab,
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          _productImage(product.image, product.price),
                          _productTitle(product.name, product.price),
                          _productDescription(product.description),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      )))
            ]),
          ),
          floatingActionButton: _userID == umkmid
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
                                      product : product,
                                    )));
                      },
                      label: Text("Sunting Produk"),
                      icon: Icon(Icons.edit),
                      backgroundColor: ConstColor.darkDatalab,
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

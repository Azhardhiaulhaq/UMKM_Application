import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/StoreDetail/ui/product_form_page_screen.dart';
import 'package:umkm_application/widget/product_card.dart';

class StoreProduct extends StatefulWidget {
  StoreProduct(
      {Key? key,
      required this.context,
      required this.umkmid,
      required this.tokopedia,
      required this.shopee,
      required this.bukalapak})
      : super(key: key);
  final BuildContext context;
  final String umkmid;
  final String tokopedia;
  final String shopee;
  final String bukalapak;

  @override
  _StoreProductState createState() => _StoreProductState(
      context: context,
      umkmid: umkmid,
      tokopedia: tokopedia,
      shopee: shopee,
      bukalapak: bukalapak);
}

// ignore: must_be_immutable
class _StoreProductState extends State<StoreProduct> {
  String searchQuery = "";
  late CollectionReference products;
  final BuildContext context;
  final String umkmid;
  final String tokopedia;
  final String shopee;
  final String bukalapak;
  _StoreProductState(
      {Key? key,
      required this.context,
      required this.umkmid,
      required this.tokopedia,
      required this.shopee,
      required this.bukalapak});
  late SharedPreferences prefs;
  Widget _search() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xffE1E2E4),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toUpperCase();
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Cari produk yang diinginkan",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> productStream() {
    return searchQuery != ""
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(umkmid)
            .collection('products')
            .where(
              "name",
              isGreaterThanOrEqualTo: searchQuery,
              isLessThan: searchQuery.substring(0, searchQuery.length - 1) +
                  String.fromCharCode(
                      searchQuery.codeUnitAt(searchQuery.length - 1) + 1),
            )
            .snapshots()
        : FirebaseFirestore.instance
            .collection('users')
            .doc(umkmid)
            .collection('products')
            .snapshots();
  }

  Widget _productCard() {
    products = FirebaseFirestore.instance
        .collection('users')
        .doc(umkmid)
        .collection('products');
    return StreamBuilder<QuerySnapshot>(
      stream: productStream(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }
        return Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: GridView.builder(
                  itemCount: snapshot.data!.size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.75),
                  itemBuilder: (context, index) => ProductCard(
                      umkmid: umkmid,
                      productid: snapshot.data!.docs[index].id,
                      name: snapshot.data!.docs[index].get('name'),
                      description:
                          snapshot.data!.docs[index].get('description'),
                      image: snapshot.data!.docs[index].get('image'),
                      price: snapshot.data!.docs[index].get('price'),
                      tokopedia: tokopedia,
                      shopee: shopee,
                      bukalapak: bukalapak),
                )));
      },
    );
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5), child: _search()),
          SizedBox(
            height: 10,
          ),
          _productCard(),
          SizedBox(height: 100),
        ],
      ),
      floatingActionButton: this.prefs.getString("userid") == umkmid
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> ProductFormScreen(
                        umkmid: umkmid,
                        productid: "",
                        name: "",
                        description: "",
                        image: "",
                        price: 0)));
              },
              label: Text("Tambah Produk"),
              icon: Icon(Icons.add),
              backgroundColor: ConstColor.sbmdarkBlue,
            )
          : Container(),
      floatingActionButtonLocation: AlmostEndFloatFabLocation(),
    );
  }

  // Scaffold(
  //       body: SafeArea(
  //     child: Stack(fit: StackFit.expand, children: <Widget>[
  //       SingleChildScrollView(
  //           child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 5),
  //               decoration: BoxDecoration(
  //                   gradient: LinearGradient(colors: [
  //                 Color(0xfffbfbfb),
  //                 Color(0xfff7f7f7),
  //               ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   _search(),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   Container(
  //                     child: GridView.builder(
  //                       itemCount: AppData.productList.length,
  //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisCount: 2, childAspectRatio: 0.75),
  //                       itemBuilder: (context, index) => ProductCard(),
  //                     ),
  //                   )
  //                 ],
  //               )))
  //     ]),
  //   ));
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

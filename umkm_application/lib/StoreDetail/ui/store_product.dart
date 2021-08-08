import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/StoreDetail/ui/product_form_page_screen.dart';
import 'package:umkm_application/data/repositories/pref_repositories.dart';
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
    late String _userID;
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
                    hintStyle: GoogleFonts.lato(fontSize: 12, color:ConstColor.textDatalab),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: ConstColor.darkDatalab)),
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
          return Center(child: CircularProgressIndicator(color: ConstColor.darkDatalab,));
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
    _userID = await PrefRepository.getUserID()??'';
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
      backgroundColor: ConstColor.backgroundDatalab,
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
      floatingActionButton: _userID == umkmid
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
              backgroundColor: ConstColor.darkDatalab,
            )
          : Container(),
      floatingActionButtonLocation: AlmostEndFloatFabLocation(),
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

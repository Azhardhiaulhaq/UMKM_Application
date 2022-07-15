import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/ecommerce_link.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/StoreDetail/ui/description_form_page_screen.dart';
import 'package:umkm_application/StoreDetail/ui/store_description.dart';
import 'package:umkm_application/StoreDetail/ui/store_product.dart';
import 'package:umkm_application/data/repositories/shared_pref_repositories.dart';

class StoreDetail extends StatefulWidget {
  StoreDetail({required this.uid, Key? key}) : super(key: key);

  final String uid;
  static const routeName = '/store/detail';
  @override
  _StoreDetailState createState() {
    return _StoreDetailState(id: uid);
  }
}

// ignore: must_be_immutable
class _StoreDetailState extends State<StoreDetail> {
  CollectionReference stores = FirebaseFirestore.instance.collection('stores');
  String id;
  _StoreDetailState({
    required this.id,
  });

  Widget _registerShop(BuildContext context, Store store) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ConstColor.darkDatalab,ConstColor.darkDatalab])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              Navigator.pushNamed(context, StoreFormScreen.routeName,
                        arguments: {'store': store});
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Daftarkan Toko Anda',
                    style: TextStyle(fontSize: 20, color: ConstColor.secondaryTextDatalab))),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    print('----- STORE ------');
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: stores.doc(id).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: ConstColor.darkDatalab,
          ));
        }
        if (!snapshot.data!.exists) {
          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Segera Buka Toko Milik Anda!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: ConstColor.darkDatalab),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Segera buka toko milikmu dan bergabung dengan jaringan UMKM lainnya untuk meningkatkan bisnis anda!',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ConstColor.darkDatalab,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image(
                      image: AssetImage('assets/shop_open.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _registerShop(context, Store.emptyStore(sharedPrefs.userid, sharedPrefs.email))
                  ],
                ),
              ),
            ),
          );
        } else {
          var mapStore = snapshot.data!.data() as Map<String, dynamic>;
          EcommerceName ecommerce = EcommerceName(
              tokopediaLink: mapStore['tokopedia_name']??'',
              shopeeLink: mapStore['shopee_name']??'',
              bukalapakLink: mapStore['bukalapak_name']??'');
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                backgroundColor: Color(0xfffbfbfb),
                appBar: AppBar(
                  backgroundColor: ConstColor.darkDatalab,
                  elevation: 1,
                  leading: IconButton(
                      icon: Icon(Icons.keyboard_arrow_left,
                          color: ConstColor.secondaryTextDatalab),
                      onPressed: () => Navigator.pop(context)),
                  title: Text(snapshot.data!.get('umkm_name'),
                      style: GoogleFonts.lato(
                          color: ConstColor.secondaryTextDatalab,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  bottom: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ConstColor.darkDatalab),
                    labelColor: ConstColor.secondaryTextDatalab,
                    unselectedLabelColor: Colors.white,
                    tabs: [Tab(text: "Description"), Tab(text: "Products")],
                  ),
                ),
                body: TabBarView(
                  children: [
                    StoreDescription(context: context, id: id),
                    StoreProduct(
                        context: context, umkmid: id, ecommerceName: ecommerce)
                  ],
                )),
          );
        }
      },
    );
  }
}

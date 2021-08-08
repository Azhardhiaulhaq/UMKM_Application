import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/StoreDetail/ui/store_description.dart';
import 'package:umkm_application/StoreDetail/ui/store_product.dart';

class StoreDetail extends StatefulWidget {
  StoreDetail({required this.uid, Key? key}) : super(key: key);

  final String uid;

  @override
  _StoreDetailState createState() {
    return _StoreDetailState(id: uid);
  }
}

// ignore: must_be_immutable
class _StoreDetailState extends State<StoreDetail> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String id;
  _StoreDetailState({
    required this.id,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

        return DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: Color(0xfffbfbfb),
              appBar: AppBar(
                backgroundColor: ConstColor.darkDatalab,
                elevation: 1,
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: ConstColor.secondaryTextDatalab),
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
                    context: context,
                    umkmid: id,
                    tokopedia: snapshot.data!.get('tokopedia_name'),
                    shopee: snapshot.data!.get('shoope_name'),
                    bukalapak: snapshot.data!.get('bukalapak_name'),
                  )
                ],
              )),
        );
      },
    );
  }
}

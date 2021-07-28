import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:umkm_application/widget/product_card.dart';

// ignore: must_be_immutable
class StoreProduct extends StatelessWidget {
  late CollectionReference products;
  final BuildContext context;
  final String umkmid;
  final String tokopedia;
  final String shopee;
  final String bukalapak;
  StoreProduct({Key? key, required this.context, required this.umkmid, required this.tokopedia, required this.shopee, required this.bukalapak})
      : super(key: key);

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

  Widget _productCard() {
    products = FirebaseFirestore.instance
        .collection('users')
        .doc(umkmid)
        .collection('products');
    return StreamBuilder<QuerySnapshot>(
      stream: products.snapshots(),
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
                      umkmid : umkmid,
                      name: snapshot.data!.docs[index].get('name'),
                      description:
                          snapshot.data!.docs[index].get('description'),
                      image: snapshot.data!.docs[index].get('image'),
                      price: snapshot.data!.docs[index].get('price'),
                      tokopedia : tokopedia,
                      shopee : shopee,
                      bukalapak : bukalapak),
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: _search()),
        SizedBox(
          height: 10,
        ),
        _productCard(),
        SizedBox(height: 100),
      ],
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

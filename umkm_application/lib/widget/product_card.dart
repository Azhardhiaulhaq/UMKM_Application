import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Model/ecommerce_link.dart';
import 'package:umkm_application/Model/product.dart';
import 'package:umkm_application/ProductDetail/ui/product_detail.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  late DocumentReference statistics;
  String umkmid;
  Product product;
  EcommerceName ecommerceName;
  ProductCard(
      {Key? key,
      required this.umkmid,
      required this.product,
      required this.ecommerceName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    statistics = FirebaseFirestore.instance
        .collection('statistics')
        .doc(umkmid)
        .collection('products')
        .doc(product.id);
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          statistics.update(
              {'product': product.name, 'count': FieldValue.increment(1)});
          Navigator.pushNamed(context, ProductDetail.routeName, arguments: {
            'context': context,
            'umkmid': umkmid,
            'productid': product.id,
            'ecommerceName': ecommerceName
          });
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(15),
                    height: 180,
                    width: 160,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(product.image),
                            fit: BoxFit.contain),
                        borderRadius: BorderRadius.circular(16))),
                Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(product.name,
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Rp ' + product.price.toString(),
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ))
              ],
            )));
  }
}

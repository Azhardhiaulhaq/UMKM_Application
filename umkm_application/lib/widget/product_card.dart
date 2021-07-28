import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:umkm_application/ProductDetail/ui/product_detail.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  String umkmid;
  String name;
  String description;
  String image;
  int price;
  String tokopedia;
  String shopee;
  String bukalapak;
  ProductCard(
      {Key? key,
      required this.umkmid,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.tokopedia,
      required this.shopee,
      required this.bukalapak})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () => pushNewScreen(context,
            screen: ProductDetail(
                context: context,
                umkmid: umkmid,
                name: name,
                description: description,
                image: image,
                price: price,
                tokopedia: tokopedia,
                shopee : shopee,
                bukalapak:bukalapak)),
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
                            image: NetworkImage(image), fit: BoxFit.contain),
                        borderRadius: BorderRadius.circular(16))),
                Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(name,
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Rp ' + price.toString(),
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

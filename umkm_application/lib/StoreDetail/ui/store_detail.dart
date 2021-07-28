import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/StoreDetail/ui/store_description.dart';
import 'package:umkm_application/StoreDetail/ui/store_product.dart';

class StoreDetail extends StatelessWidget {
  final BuildContext context;
  String id;
  String name;
  String image;
  String city;
  String province;
  String address;
  List<String> tags;
  String bukalapak;
  String description;
  String email;
  String facebook;
  String instagram;
  String phone;
  String shoope;
  String tokopedia;
  String youtube_link;
  StoreDetail({
    Key? key,
    required this.context,
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.province,
    required this.address,
    required this.tags,
    required this.bukalapak,
    required this.description,
    required this.email,
    required this.facebook,
    required this.instagram,
    required this.phone,
    required this.shoope,
    required this.tokopedia,
    required this.youtube_link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xfffbfbfb),
        appBar: AppBar(
          backgroundColor: ConstColor.sbmdarkBlue,
          elevation: 1,
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          title: Text(name,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          bottom: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: ConstColor.sbmdarkBlue),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [Tab(text: "Description"), Tab(text: "Products")],
          ),
        ),
        body: TabBarView(children: [StoreDescription(context: context,
   id : id,
       name : name,
       image : image,
       city : city,
       province : province,
       address : address,
       tags : tags,
       bukalapak : bukalapak,
       description : description,
       email : email,
       facebook : facebook,
       instagram : instagram,
       phone : phone,
       shoope : shoope,
       tokopedia : tokopedia,
       youtube_link : youtube_link,), StoreProduct(context: context, umkmid : id, tokopedia:tokopedia,shopee: shoope,bukalapak: bukalapak,)],)
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/StoreDetail/ui/store_detail.dart';

// ignore: must_be_immutable
class StoreList extends StatelessWidget {
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
  // ignore: non_constant_identifier_names
  String youtube_link;

  StoreList({
    Key? key,
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
    // ignore: non_constant_identifier_names
    required this.youtube_link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return id == null
        ? Container(width: 5)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => pushNewScreen(context,
                  screen: StoreDetail(
                    context: context,
                    id: id,
                    name: name,
                    image: image,
                    city: city,
                    province: province,
                    address: address,
                    tags: tags,
                    bukalapak: bukalapak,
                    description: description,
                    email: email,
                    facebook: facebook,
                    instagram: instagram,
                    phone: phone,
                    shoope: shoope,
                    tokopedia: tokopedia,
                    youtube_link: youtube_link,
                  )),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(image),
                              minRadius: 30,
                              maxRadius: 50,
                            ),
                            SizedBox(width: 5),
                            VerticalDivider(),
                            SizedBox(width: 5),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(city + ', ' + province,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    SizedBox(height: 15),
                                    // _makeLabel("Food"),
                                    Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 5,
                                        children: tags
                                            .map(
                                              (label) => _makeLabel(label),
                                            )
                                            .toList())
                                  ],
                                ))
                          ],
                        ),
                      ))),
            ));
  }

  Widget _makeLabel(String labelCategory) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: ConstColor.sbmdarkBlue,
        border: Border.all(color: ConstColor.sbmdarkBlue, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xfffbf2ef),
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(labelCategory,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ],
      ),
    );
  }
}

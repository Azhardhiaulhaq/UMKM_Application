import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/StoreDetail/ui/store_detail.dart';
import 'package:umkm_application/data/repositories/statistic_repositories.dart';

// ignore: must_be_immutable
class StoreList extends StatelessWidget {
  late DocumentReference statistics;
  String id;
  Store store;

  StoreList({Key? key, required this.id, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    statistics = FirebaseFirestore.instance.collection('statistics').doc(id);
    // ignore: unnecessary_null_comparison
    return id == null
        ? Container(width: 5)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                StatisticRepository.updateStatistic(id, 'store');
                Navigator.pushNamed(context, StoreDetail.routeName,
                    arguments: {'uid': id});
              },
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
                              backgroundImage: NetworkImage(store.image != ''
                                  ? store.image
                                  : 'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
                              minRadius: 30,
                              maxRadius: 50,
                              backgroundColor: ConstColor.lightgreyBG,
                            ),
                            SizedBox(width: 5),
                            VerticalDivider(),
                            SizedBox(width: 5),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(store.name,
                                        overflow: TextOverflow.fade,
                                        style: GoogleFonts.lato(
                                            color: ConstColor.textDatalab,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        store.city != ''
                                            ? store.city + ', ' + store.province
                                            : 'Belum ada lokasi',
                                        overflow: TextOverflow.fade,
                                        style: GoogleFonts.lato(
                                            color: ConstColor.textDatalab,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14)),
                                    SizedBox(height: 15),
                                    // _makeLabel("Food"),
                                    Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 5,
                                        children: store.tags
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
        color: ConstColor.textDatalab,
        border: Border.all(color: ConstColor.textDatalab, width: 2),
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
              style: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ],
      ),
    );
  }
}

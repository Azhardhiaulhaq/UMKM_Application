import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/event.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/StoreDetail/ui/store_detail.dart';
import 'package:expansion_card/expansion_card.dart';

class EventCard extends StatelessWidget {
  final Event model;
  EventCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model.id == null
        ? Container(width: 5)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
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
                            Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.name,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    Divider(
                                      color: ConstColor.sbmdarkBlue,
                                      thickness: 2,
                                    ),
                                    SizedBox(
                                        height: 10,
                                      ),
                                    Row(children: <Widget>[
                                      Icon(Icons.access_time,
                                          color: Colors.yellow),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(model.date,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))
                                    ]),
                                    SizedBox(
                                        height: 5,
                                      ),
                                    Row(children: <Widget>[
                                      Icon(Icons.location_on,
                                          color: Colors.red),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(model.location,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))
                                    ]),
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

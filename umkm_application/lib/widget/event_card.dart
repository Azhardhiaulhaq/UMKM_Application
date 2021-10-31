import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Event/ui/event_detail.dart';
import 'package:intl/intl.dart';
import 'package:umkm_application/Model/event.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  Event event;
  bool isExpired;
  EventCard({Key? key, required this.event, required this.isExpired})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            isExpired
                ? print('expired')
                : Navigator.pushNamed(context, EventDetail.routeName,
                    arguments: {'eventID': event.id});
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  color: isExpired ? Color(0xffE7E7E7) : Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 3,
                            color: isExpired
                                ? Color(0xfffddd5c)
                                : Color(0xff779ecb),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(DateFormat.d().format(event.date),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    Text(DateFormat.yMMM().format(event.date),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text(event.name,
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
                              SizedBox(
                                height: 5,
                              ),
                              Row(children: <Widget>[
                                Icon(Icons.location_on, color: Colors.red),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(event.location,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))
                              ]),
                            ],
                          ),
                        ],
                      )))),
        ));
  }
}

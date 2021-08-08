import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Event/ui/event_detail.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  String eventID;
  String name;
  String author;
  String bannerImage;
  String contactPerson;
  DateTime date;
  String description;
  String link;
  String location;
  bool isExpired;
  EventCard(
      {Key? key,
      required this.eventID,
      required this.name,
      required this.author,
      required this.bannerImage,
      required this.contactPerson,
      required this.date,
      required this.description,
      required this.link,
      required this.location,
      required this.isExpired})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            isExpired ? print('expired') :Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetail(
                          context: context,
                          eventID : eventID,
                        )));
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
                                    Text(DateFormat.d().format(date),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    Text(DateFormat.yMMM().format(date),
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
                              Text(name,
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
                                Text(location,
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

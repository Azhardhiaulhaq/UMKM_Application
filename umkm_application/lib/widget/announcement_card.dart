import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Announcement/ui/announcement_detail.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Event/ui/event_detail.dart';
import 'package:intl/intl.dart';
import 'package:umkm_application/Model/announcement.dart';

// ignore: must_be_immutable
class AnnouncementCard extends StatelessWidget {
  Announcement announcement;
  bool isExpired;
  AnnouncementCard(
      {Key? key, required this.announcement, required this.isExpired})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pushNamed(context, AnnouncementDetail.routeName,
                arguments: {'announcementID': announcement.id});
            // StatisticRepository.updateStatistic(id, 'store');
            // Navigator.pushNamed(context, StoreDetail.routeName,
            //     arguments: {'uid': id});
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
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          color: ConstColor.darkDatalab,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      DateFormat.d()
                                          .format(announcement.deadlines),
                                      style: TextStyle(
                                          color: ConstColor.secondaryTextDatalab,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36)),
                                  Text(
                                      DateFormat.yMMM()
                                          .format(announcement.deadlines),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                ],
                              )),
                        ),
                        SizedBox(width: 5),
                        VerticalDivider(),
                        SizedBox(width: 5),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(announcement.title,
                                    overflow: TextOverflow.fade,
                                    maxLines: 4,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('By : ',
                                        overflow: TextOverflow.fade,
                                        maxLines: 4,
                                        style: TextStyle(
                                            color: ConstColor.darkDatalab,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(announcement.author,
                                        overflow: TextOverflow.fade,
                                        maxLines: 4,
                                        style: TextStyle(
                                            color: ConstColor.secondaryTextDatalab,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ))),
        ));
  }
}

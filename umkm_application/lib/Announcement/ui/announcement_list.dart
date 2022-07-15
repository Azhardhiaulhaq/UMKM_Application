import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Model/announcement.dart';
import 'package:umkm_application/data/repositories/shared_pref_repositories.dart';
import 'package:umkm_application/widget/announcement_card.dart';

class AnnouncementPage extends StatefulWidget {
  AnnouncementPage({Key? key}) : super(key: key);

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  CollectionReference announcements = FirebaseFirestore.instance.collection('announcements');

  Widget _title() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Announcements',
                        style: GoogleFonts.lato(
                            color: ConstColor.textDatalab,
                            fontSize: 24,
                            fontWeight: FontWeight.w700))
                  ])
            ]));
  }

  Widget _announcementList(bool isExpired) {
    var dateNow = DateTime.now();
    return StreamBuilder<QuerySnapshot>(
      stream: announcements
              .snapshots()
,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: ConstColor.darkDatalab,
          ));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }
        print('---------------------------');
        return Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: snapshot.data!.docs.map(
            (e) {
              var mapAnnc = e.data() as Map<String, dynamic>;
              Announcement annc = Announcement(
                  id: e.id,
                  content : mapAnnc['content'] ?? '',
                  createdAt : mapAnnc['createdAt'] .toDate() ?? DateTime.now(),
                  deadlines : mapAnnc['deadlines'].toDate() ?? DateTime.now(),
                  documents: List.from(mapAnnc['documents']??[]),
                  email : mapAnnc['email'] ?? '',
                  phoneNumber: mapAnnc['phoneNumber'] ?? '',
                  title : mapAnnc['title'] ?? '',
                  author: mapAnnc['author']?? '');
              return AnnouncementCard(
                announcement: annc,
                isExpired: isExpired,
              );
            },
          ).toList(),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _title(),
                      SizedBox(height: 10),
                      _announcementList(true),
                      SizedBox(height: 100)
                    ],
                  )))
        ]),
      ),
      floatingActionButton: sharedPrefs.isMaster
          ? FloatingActionButton.extended(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => EventFormScreen(
                //               event: Event.emptyEvent(),
                //             )));
              },
              label: Text("Tambah Pengumuman"),
              icon: Icon(Icons.event_outlined),
              backgroundColor: ConstColor.darkDatalab,
            )
          : Container(),
      floatingActionButtonLocation: AlmostEndFloatFabLocation(),
    );
  }
}

class AlmostEndFloatFabLocation extends StandardFabLocation
    with FabEndOffsetX, FabFloatOffsetY {
  @override
  double getOffsetX(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? 5.0 : 0;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }

  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? 500 : 20;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }
}

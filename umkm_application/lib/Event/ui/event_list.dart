import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Event/ui/event_form_page_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Model/event.dart';
import 'package:umkm_application/data/repositories/shared_pref_repositories.dart';
import 'package:umkm_application/widget/event_card.dart';

class EventPage extends StatefulWidget {
  EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  bool _upcomingVisible = false;
  bool _pastVisible = false;

  Widget _title() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Event List',
                        style: GoogleFonts.lato(
                            color: ConstColor.textDatalab,
                            fontSize: 24,
                            fontWeight: FontWeight.w700))
                  ])
            ]));
  }

  Widget _eventList(bool isExpired) {
    var dateNow = DateTime.now();
    return StreamBuilder<QuerySnapshot>(
      stream: isExpired
          ? events
              .where("date", isLessThan: dateNow)
              .orderBy("date", descending: true)
              .snapshots()
          : events
              .where("date", isGreaterThanOrEqualTo: dateNow)
              .orderBy("date", descending: false)
              .snapshots(),
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
        return Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: snapshot.data!.docs.map(
            (e) {
              var mapEvent = e.data() as Map<String, dynamic>;
              Event event = Event(
                  id: e.id,
                  author: mapEvent['author'] ?? '',
                  image: mapEvent['banner_image'] ?? '',
                  contactPerson: mapEvent['contact_person'] ?? '',
                  date: mapEvent['date'].toDate() ?? DateTime.now(),
                  description: mapEvent['description'] ?? '',
                  link: mapEvent['link'] ?? '',
                  name: mapEvent['name'] ?? '',
                  location: mapEvent['location'] ?? '');
              return EventCard(
                event: event,
                isExpired: isExpired,
              );
            },
          ).toList(),
        ));
      },
    );
  }

  Widget _upcomingEventTitle(String title) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                print(_upcomingVisible);
                _upcomingVisible = !_upcomingVisible;
              });
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          title,
                          style: GoogleFonts.lato(
                              color: ConstColor.textDatalab,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        )),
                    Container(
                        child: Icon(
                            _upcomingVisible
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down_rounded,
                            size: 30,
                            color: ConstColor.darkDatalab))
                  ],
                ))));
  }

  Widget _pastEventTitle(String title) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _pastVisible = !_pastVisible;
              });
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          title,
                          style: GoogleFonts.lato(
                              color: ConstColor.textDatalab,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        )),
                    Container(
                        child: Icon(
                            _pastVisible
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down_rounded,
                            size: 30,
                            color: ConstColor.darkDatalab))
                  ],
                ))));
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
                      _upcomingEventTitle("Event Berikutnya"),
                      Visibility(
                          visible: _upcomingVisible, child: _eventList(false)),
                      SizedBox(height: 20),
                      _pastEventTitle("Event Lalu"),
                      Visibility(
                          visible: _pastVisible, child: _eventList(true)),
                      SizedBox(height: 100)
                    ],
                  )))
        ]),
      ),
      floatingActionButton: sharedPrefs.isMaster
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventFormScreen(
                              event: Event.emptyEvent(),
                            )));
              },
              label: Text("Tambah Event"),
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

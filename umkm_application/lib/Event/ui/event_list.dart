import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/widget/event_card.dart';

class EventPage extends StatefulWidget {
  EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool _upcomingVisible = false;
  // bool _pastVisible = false;

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
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700))
                  ])
            ]));
  }

  Widget _upcomingEventList() {
    return Expanded(
        child: ListView(
      scrollDirection: Axis.vertical,
      children: AppData.eventList
          .map(
            (event) => EventCard(
              model: event,
            ),
          )
          .toList(),
    ));
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
                              color: Colors.black,
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
                            color: ConstColor.sbmdarkBlue))
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
                    _upcomingEventTitle("Upcoming Event"),
                    Visibility(
                        visible: _upcomingVisible, child: _upcomingEventList()),
                    SizedBox(height: 100)
                  ],
                )))
      ]),
    ));
  }
}

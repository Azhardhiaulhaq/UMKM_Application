import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Event/ui/event_form_page_screen.dart';
import 'package:umkm_application/Model/event.dart';
import 'package:umkm_application/data/repositories/shared_pref_repositories.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  EventDetail({Key? key, required this.eventID}) : super(key: key);
  String eventID;
  static const routeName = '/event/detail';
  @override
  _EventDetailState createState() => _EventDetailState(
        eventID: eventID,
      );
}

class _EventDetailState extends State<EventDetail> {
  CollectionReference events = FirebaseFirestore.instance.collection('events');

  String eventID;
  _EventDetailState({required this.eventID});

  Future<void> share(String phone, String message) async {
    var phoneNumber = '+' + phone;
    // ignore: non_constant_identifier_names
    var whatsappURl_android =
        "whatsapp://send?phone=" + phoneNumber + "&text=" + message;
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }

  void openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      print('There was a problem to open the url: $url');
    }
  }

  Widget _eventImage(String image) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fitWidth),
                  border: Border.all(color: Color(0xfff7f7f7)),
                  borderRadius: BorderRadius.circular(16)))),
    );
  }

  Widget _eventTitle(String name, String author, String date, String location) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            name != ''
                                ? name.toUpperCase()
                                : "Event belum mempunyai nama",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: <Widget>[
                          Icon(Icons.date_range_rounded,
                              color: Colors.blueAccent),
                          SizedBox(
                            width: 8,
                          ),
                          Text(date,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: ConstColor.textDatalab,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14))
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: <Widget>[
                          Icon(Icons.location_city, color: Colors.redAccent),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                              location != ''
                                  ? location
                                  : "Belum ada lokasi Event",
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: ConstColor.textDatalab,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14))
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            author != ''
                                ? 'Oleh : ' + author
                                : 'Belum ada author',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                  ))),
        ));
  }

  Widget _eventDescription(String description, String contactPerson) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deskripsi',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            description != ''
                                ? description
                                : 'Belum ada deskripsi event',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                            textAlign: TextAlign.justify),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Narahubung',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(
                                  contactPerson != ''
                                      ? '+62 ' + contactPerson
                                      : 'Belum ada narahubung',
                                  style: GoogleFonts.lato(
                                      color: ConstColor.textDatalab,
                                      fontSize: 14)),
                              icon: Icon(MdiIcons.whatsapp,
                                  color: Colors.green, size: 30),
                              onPressed: () {
                                contactPerson != ''
                                    ? share('62' + contactPerson, 'Halo')
                                    : print('Contact Person is null');
                              },
                            )),
                      ],
                    ),
                  ))),
        ));
  }

  Widget _linkButton(String link) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            link != '' ? openLink(link) : print(link);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                color: link != '' ? ConstColor.darkDatalab : Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                        height: 20,
                        child: Center(
                          child: Text(
                            link != ''
                                ? 'DAFTAR'
                                : 'BELUM ADA LINK PENDAFTARAN',
                            style: TextStyle(
                                color: link != ''
                                    ? ConstColor.secondaryTextDatalab
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ))),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: events.doc(eventID).snapshots(),
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
        var mapEvent = snapshot.data!.data() as Map<String, dynamic>;
        Event event = Event(
            id: eventID,
            author: mapEvent['author'] ?? '',
            image: mapEvent['banner_image'] ?? '',
            contactPerson: mapEvent['contact_person'] ?? '',
            date: mapEvent['date'].toDate() ?? DateTime.now(),
            description: mapEvent['description'] ?? '',
            link: mapEvent['link'] ?? '',
            name: mapEvent['name'] ?? '',
            location: mapEvent['location'] ?? '');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ConstColor.darkDatalab,
            elevation: 1,
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left,
                    color: ConstColor.secondaryTextDatalab),
                onPressed: () => Navigator.pop(context)),
          ),
          body: SafeArea(
            child: Stack(fit: StackFit.expand, children: <Widget>[
              SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            ConstColor.backgroundDatalab,
                            ConstColor.backgroundDatalab
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          event.image != ''
                              ? _eventImage(event.image)
                              : Container(),
                          _eventTitle(
                              event.name,
                              event.author,
                              DateFormat.yMMMMd().format(event.date),
                              event.location),
                          _eventDescription(
                              event.description, event.contactPerson),
                          SizedBox(
                            height: 10,
                          ),
                          _linkButton(event.link),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      )))
            ]),
          ),
          floatingActionButton: sharedPrefs.isMaster
              ? FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventFormScreen(
                                  event : event
                                )));
                  },
                  label: Text("Sunting Event"),
                  icon: Icon(Icons.edit),
                  backgroundColor: ConstColor.darkDatalab,
                )
              : Container(),
          floatingActionButtonLocation: AlmostEndFloatFabLocation(),
        );
      },
    );
  }
}

class AlmostEndFloatFabLocation extends StandardFabLocation
    with FabEndOffsetX, FabFloatOffsetY {
  @override
  double getOffsetX(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment = 5;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }

  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment = 500;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }
}

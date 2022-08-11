import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/announcement.dart';
import 'package:umkm_application/data/repositories/shared_pref_repositories.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';

class AnnouncementDetail extends StatefulWidget {
  AnnouncementDetail({Key? key, required this.announcementID})
      : super(key: key);
  String announcementID;
  static const routeName = '/announcement/detail';
  @override
  _AnnouncementDetailState createState() => _AnnouncementDetailState(
        announcementID: announcementID,
      );
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {
  CollectionReference announcementref =
      FirebaseFirestore.instance.collection('announcements');

  String announcementID;
  _AnnouncementDetailState({required this.announcementID});

  bool isLoading = false;
  bool isUploading = false;
  double percent = 0.0;

  // late final String path;
  late final String path;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = ""; //(await DownloadsPathProvider.downloadsDirectory)!.path;
  }

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

  Widget _anncTitle(String name, String author, String date) {
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
                        Text(name != '' ? name.toUpperCase() : "-",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Posted  : ',
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                style: TextStyle(
                                    color: ConstColor.darkDatalab,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(date,
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                style: TextStyle(
                                    color: ConstColor.greenText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('By  : ',
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                style: TextStyle(
                                    color: ConstColor.darkDatalab,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(author,
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                style: TextStyle(
                                    color: ConstColor.greenText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                  ))),
        ));
  }

  Widget _anncDescription(String description, String contactPerson,
      String email, String deadlines) {
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
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Deadline  : ',
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                style: TextStyle(
                                    color: ConstColor.darkDatalab,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(deadlines,
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                style: TextStyle(
                                    color: ConstColor.deadlineRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                        ),
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
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(email != '' ? email : '-',
                                  style: GoogleFonts.lato(
                                      color: ConstColor.textDatalab,
                                      fontSize: 14)),
                              icon: Icon(MdiIcons.email,
                                  color: ConstColor.darkDatalab, size: 30),
                              onPressed: () {},
                            )),
                      ],
                    ),
                  ))),
        ));
  }

  Widget _listFile(List<String> files) {
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
                        Text('Dokumen',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: ConstColor.textDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        for (var file in files) fileCard(file)
                      ],
                    ),
                  ))),
        ));
  }

  Widget fileCard(String url) {
    Reference storageReference = FirebaseStorage.instance.refFromURL(url);
    String name = storageReference.name;
    String type = name.split('.').last;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: Border.all(
              color: ConstColor.darkDatalab,
              width: 1,
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    type == 'pdf'
                        ? 'assets/icon_pdf.png'
                        : 'assets/icon_docx.png',
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        maxLines: 2,
                        style: GoogleFonts.roboto(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  File('$path/$name').existsSync()
                      ? InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            OpenFile.open('$path/$name');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.remove_red_eye_outlined,
                                color: ConstColor.darkDatalab),
                          ))
                      : InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            downloadFile(url, '$path/');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.download,
                                color: ConstColor.darkDatalab),
                          )),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )),
        ));
  }

  downloadFile(var link, String dir) async {
    print('---- DIR ----');
    final savedDir = Directory(dir);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        url: link,
        savedDir: dir,
        showNotification: true,
        openFileFromNotification: true,
      );
      print(_taskid);
    });
    // final taskId = await FlutterDownloader.enqueue(
    //   url: link,
    //   headers:{"downloading" : "Test Download"},
    //   savedDir: dir,
    //   showNotification:
    //       true, // show download progress in status bar (for Android)
    //   openFileFromNotification:
    //       true, // click on notification to open downloaded file (for Android)
    // );
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: announcementref.doc(announcementID).snapshots(),
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
        var mapAnnc = snapshot.data!.data() as Map<String, dynamic>;
        Announcement annc = Announcement(
            id: announcementID,
            content: mapAnnc['content'] ?? '',
            createdAt: mapAnnc['createdAt'].toDate() ?? DateTime.now(),
            deadlines: mapAnnc['deadlines'].toDate() ?? DateTime.now(),
            documents: List.from(mapAnnc['documents'] ?? []),
            email: mapAnnc['email'] ?? '',
            phoneNumber: mapAnnc['phoneNumber'] ?? '',
            title: mapAnnc['title'] ?? '',
            author: mapAnnc['author'] ?? '');
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
                          _anncTitle(annc.title, annc.author,
                              DateFormat.yMMMMd().format(annc.createdAt)),
                          _anncDescription(
                              annc.content!,
                              annc.phoneNumber!,
                              annc.email!,
                              DateFormat.yMMMMd().format(annc.deadlines)),
                          SizedBox(
                            height: 10,
                          ),
                          _listFile(annc.documents),
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => EventFormScreen(
                    //               event : event
                    //             )));
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

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
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

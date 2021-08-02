// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Event/bloc/bloc/event_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EventFormPage extends StatefulWidget {
  EventFormPage(
      {Key? key,
      required this.title,
      required this.date,
      required this.eventID,
      required this.name,
      required this.location,
      required this.description,
      required this.author,
      required this.link,
      required this.contactPerson,
      required this.linkImage})
      : super(key: key);

  final String title;
  final String eventID;
  final String name;
  final String location;
  final String description;
  final String author;
  final String link;
  final String contactPerson;
  final String linkImage;
  final DateTime date;
  @override
  _EventFormPageState createState() => _EventFormPageState(
      eventID: eventID,
      name: name,
      location: location,
      description: description,
      author: author,
      link: link,
      contactPerson: contactPerson,
      linkImage: linkImage,
      date: date);
}

class _EventFormPageState extends State<EventFormPage> {
  _EventFormPageState(
      {required this.date,
      required this.eventID,
      required this.name,
      required this.location,
      required this.description,
      required this.author,
      required this.link,
      required this.contactPerson,
      required this.linkImage});
  final String eventID;
  final String name;
  final String location;
  final String description;
  final String author;
  final String link;
  final String contactPerson;
  final String linkImage;
  final DateTime date;
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController locController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  TextEditingController authorController = TextEditingController(text: "");
  TextEditingController cpController = TextEditingController(text: "");
  TextEditingController linkController = TextEditingController(text: "");
  DateTime _selectedDate = DateTime.now();
  File _imageFile = File('');
  final ImagePicker picker = ImagePicker();
  late EventBloc _eventBloc;
  bool isLoading = false;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDate = args.value;
    });
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Kembali',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(
      String title, String hintText, TextEditingController controller,
      {bool isPassword = false, bool isCP = false, Icon? entryIcon = null}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          isCP
              ? InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  textFieldController: controller,
                )
              : TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: entryIcon,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ConstColor.sbmdarkBlue),
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      hintText: hintText))
        ],
      ),
    );
  }

  Widget _datePicker(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedRange: PickerDateRange(
                eventID != ""
                    ? date.subtract(const Duration(days: 4))
                    : DateTime.now().subtract(const Duration(days: 4)),
                eventID != ""
                    ? date.add(const Duration(days: 3))
                    : DateTime.now().add(const Duration(days: 3))),
          )
        ],
      ),
    );
  }

  Widget _imagePicker(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Text(_imageFile.path),
          SizedBox(
            height: 10,
          ),
          _imagePickerButton(context)
        ],
      ),
    );
  }

  Widget _imagePickerButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ConstColor.sbmlightBlue, ConstColor.sbmdarkBlue])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              setState(() {
                _imageFile = File(image!.path);
              });
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Upload Gambar',
                    style: TextStyle(fontSize: 14, color: Colors.white))),
          )),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ConstColor.sbmlightBlue, ConstColor.sbmdarkBlue])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              _eventBloc.add(addEventButtonPressed(
                  name: nameController.text,
                  location: locController.text,
                  description: descController.text,
                  author: authorController.text,
                  contactPerson: cpController.text,
                  link: linkController.text,
                  date: _selectedDate,
                  imageFile: _imageFile));
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(eventID != "" ? "Update Event" :'Tambahkan Event',
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          )),
    );
  }

  Widget _form() {
    return Column(
      children: <Widget>[
        _entryField("Nama Event", "Masukkan nama event", nameController,
            entryIcon: Icon(
              Icons.event_outlined,
              color: ConstColor.sbmdarkBlue,
            )),
        _entryField("Lokasi Event", "Masukkan tempat event diselenggarakan",
            locController,
            entryIcon: Icon(Icons.location_city_outlined,
                color: ConstColor.sbmdarkBlue)),
        _entryField("Deskripsi Event", "Deskripsi event yang diselenggarakan",
            descController,
            entryIcon: Icon(Icons.list_alt, color: ConstColor.sbmdarkBlue)),
        _entryField("Penyelenggara Event",
            "Masukkan instansi penyelenggara event", authorController,
            entryIcon:
                Icon(Icons.people_alt_outlined, color: ConstColor.sbmdarkBlue)),
        _entryField("Link Pendaftaran",
            "Masukkan link pendaftaran untuk event apabila ada", linkController,
            entryIcon:
                Icon(Icons.link_outlined, color: ConstColor.sbmdarkBlue)),
        _entryField("Kontak Panitia",
            "Masukkan Kontak Panitia yang dapat dihubungi", cpController,
            isCP: true),
        _datePicker("Tanggal Event"),
        _imagePicker("Gambar Event")
      ],
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void initVariable() {
    if (eventID != "") {
      setState(() {
        nameController.text = name;
        locController.text = location;
        descController.text = description;
        authorController.text = author;
        cpController.text = contactPerson;
        linkController.text = link;
        _selectedDate = date;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initVariable();
    _eventBloc = BlocProvider.of<EventBloc>(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    locController.dispose();
    descController.dispose();
    authorController.dispose();
    cpController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<EventBloc, EventState>(listener: (context, state) {
      if (state is EventFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: "Penambahan Event Gagal",
          titleColor: Colors.white,
          message: state.message,
          messageColor: Colors.white,
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xffffae88),
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }

      if (state is EventLoading) {
        print('loading');
        setState(() {
          isLoading = true;
        });
      }

      if (state is EventSucceed) {
        setState(() {
          isLoading = false;
        });

        Flushbar(
          title: "Penambahan Event Berhasil",
          titleColor: Colors.white,
          message: "Event Berhasil Ditambahkan.",
          messageColor: Colors.white,
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xff039487),
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context).then((r) => Navigator.pop(context));
      }
    }, child: BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(top: 40, left: 0, child: _backButton()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .1),
                        // _title(),
                        _form(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(context),
                        SizedBox(height: height * .15),
                      ],
                    ),
                  ),
                ),
                isLoading
                    ? Center(
                        child: Container(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator()),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    ));
  }
}

// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //


import 'package:another_flushbar/flushbar.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/StoreDetail/bloc/store_bloc.dart';

class StoreFormPage extends StatefulWidget {
  StoreFormPage(
      {required this.store,
      Key? key})
      : super(key: key);

  final Store store;

  @override
  _StoreFormPageState createState() => _StoreFormPageState(
      store : store
      );
}

class _StoreFormPageState extends State<StoreFormPage> {
  final Store store;

  _StoreFormPageState(
      {required this.store});
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController bukalapakController = TextEditingController(text: "");
  TextEditingController cityController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController facebookController = TextEditingController(text: "");
  TextEditingController instagramController = TextEditingController(text: "");
  TextEditingController phoneNumberController = TextEditingController(text: "");
  TextEditingController provinceController = TextEditingController(text: "");
  TextEditingController shopeeController = TextEditingController(text: "");
  TextEditingController tokopediaController = TextEditingController(text: "");
  TextEditingController umkmController = TextEditingController(text: "");
  TextEditingController youtubeController = TextEditingController(text: "");
  final ImagePicker picker = ImagePicker();
  late StoreBloc _storeBloc;
  bool isLoading = false;
  late List<String> selectedTag;

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
              child: Icon(Icons.keyboard_arrow_left, color: ConstColor.secondaryTextDatalab),
            ),
            Text('Kembali',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color:ConstColor.secondaryTextDatalab))
          ],
        ),
      ),
    );
  }

  Widget _entryField(
      String title, String hintText, TextEditingController controller,
      {bool isPassword = false, bool isCP = false, Icon? entryIcon}) {
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
                  selectorTextStyle: TextStyle(color: ConstColor.textDatalab),
                  textFieldController: controller,
                )
              : TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: entryIcon,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ConstColor.darkDatalab),
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      hintText: hintText))
        ],
      ),
    );
  }

  Widget _tagsField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Jenis UMKM',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color:ConstColor.textDatalab),
          ),
          SizedBox(
            height: 10,
          ),
          CustomCheckBoxGroup(
            buttonTextStyle: ButtonTextStyle(
              selectedColor: Colors.white,
              unSelectedColor: ConstColor.darkDatalab,
              textStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            unSelectedColor: Theme.of(context).canvasColor,
            buttonLables: [
              "Makanan",
              "Pakaian",
              "Kesenian",
            ],
            buttonValuesList: [
              "makanan",
              "pakaian",
              "kesenian",
            ],
            checkBoxButtonValues: (values) {
              setState(() {
                selectedTag = values.cast<String>();
              });
            },
            spacing: 5,
            defaultSelected: selectedTag,
            horizontal: false,
            enableButtonWrap: false,
            absoluteZeroSpacing: false,
            selectedColor: ConstColor.darkDatalab,
            padding: 10,
            unSelectedBorderColor: ConstColor.darkDatalab,
            selectedBorderColor: ConstColor.darkDatalab,
          )
        ],
      ),
    );
  }

  Widget _socialMediaField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Social Media',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ConstColor.textDatalab),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: facebookController,
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(MdiIcons.facebook,
                      color: Color(0xff4267B2), size: 30),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColor.darkDatalab),
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  hintText: 'Masukkan akun facebook')),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: instagramController,
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(MdiIcons.instagram,
                      color: Color(0xffE1306C), size: 30),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColor.darkDatalab),
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  hintText: 'Masukkan akun instagram')),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: youtubeController,
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(MdiIcons.youtube,
                      color: Color(0xffFF0000), size: 30),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColor.darkDatalab),
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  hintText: 'Masukkan link promosi di youtube'))
        ],
      ),
    );
  }

  Widget _marketPlaceField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Market Place',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color:ConstColor.textDatalab),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: tokopediaController,
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixText: 'Tokopedia : ',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColor.darkDatalab),
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  hintText: 'Masukkan akun Tokopedia')),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: shopeeController,
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixText: 'Shopee : ',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColor.darkDatalab),
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  hintText: 'Masukkan akun shopee')),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: bukalapakController,
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixText: 'Bukalapak : ',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColor.darkDatalab),
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  hintText: 'Masukkan link promosi di bukalapak'))
        ],
      ),
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
              colors: [ConstColor.darkDatalab,ConstColor.darkDatalab])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              _storeBloc.add(updateStore(
                  store: Store(id : store.id, address: addressController.text,
                               bukalapakName: bukalapakController.text, city: cityController.text,
                               description: descriptionController.text, facebookAcc: facebookController.text,
                               instagramAcc: instagramController.text, phoneNumber: phoneNumberController.text,
                               province: provinceController.text, shopeeName: shopeeController.text,
                               tags: selectedTag, tokopediaName: tokopediaController.text,
                               name: umkmController.text,youtubeLink: youtubeController.text, image: '',)));
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Simpan Data',
                    style: TextStyle(fontSize: 20, color: ConstColor.secondaryTextDatalab))),
          )),
    );
  }

  Widget _form() {
    return Column(
      children: <Widget>[
        _entryField("Nama UMKM", "Masukkan nama umkm", umkmController,
            entryIcon: Icon(
              Icons.account_box,
              color: ConstColor.darkDatalab,
            )),
        _entryField("Alamat UMKM", "Masukkan alamat umkm", addressController,
            entryIcon: Icon(Icons.location_on_outlined,
                color: ConstColor.darkDatalab)),
        _entryField("Kota UMKM", "Masukkan kota tempat UMKM", cityController,
            entryIcon: Icon(Icons.location_city_outlined,
                color: ConstColor.darkDatalab)),
        _entryField(
          "Provinsi UMKM",
          "Masukkan provinsi tempat UMKM",
          provinceController,
          entryIcon:
              Icon(Icons.location_city_outlined, color: ConstColor.darkDatalab),
        ),
        _entryField("Deskripsi UMKM", "Masukkan deskripsi detail mengenai UMKM",
            descriptionController,
            entryIcon: Icon(Icons.list_alt, color: ConstColor.darkDatalab)),
        _entryField("Nomor Telepon", "Masukkan nomor telepon UMKM",
            phoneNumberController,
            isCP: true),
        // _datePicker("Tanggal Event"),
        // _imagePicker("Gambar Event")
      ],
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(color: ConstColor.darkDatalab,),
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

  @override
  void initState() {
    super.initState();
    print("Login");
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    addressController.text = store.address??'';
    bukalapakController.text = store.bukalapakName??'';
    cityController.text = store.city;
    descriptionController.text = store.description??'';
    facebookController.text = store.facebookAcc??'';
    instagramController.text = store.instagramAcc??'';
    phoneNumberController.text = store.phoneNumber??'';
    provinceController.text = store.province;
    shopeeController.text = store.shopeeName??'';
    tokopediaController.text = store.tokopediaName??'';
    umkmController.text = store.name;
    youtubeController.text = store.youtubeLink??'';
    selectedTag = store.tags;
  }

  @override
  void dispose() {
    addressController.dispose();
    bukalapakController.dispose();
    cityController.dispose();
    descriptionController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    phoneNumberController.dispose();
    provinceController.dispose();
    shopeeController.dispose();
    tokopediaController.dispose();
    umkmController.dispose();
    youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<StoreBloc, StoreState>(listener: (context, state) {
      if (state is UpdateStoreFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: "Penyuntingan UMKM Gagal",
          titleColor: Colors.white,
          message: state.message,
          messageColor: Colors.white,
          duration: Duration(seconds: 2),
          backgroundColor: ConstColor.failedNotification,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }

      if (state is StoreLoading) {
        print('loading');
        setState(() {
          isLoading = true;
        });
      }

      if (state is UpdateStoreSucceed) {
        setState(() {
          isLoading = false;
        });

                Flushbar(
          title: "Penyuntingan UMKM Berhasil",
          titleColor: Colors.white,
          message: "Informasi Mngenai UMKM Berhasil Diubah.",
          messageColor: Colors.white,
          duration: Duration(seconds: 2),
          backgroundColor: ConstColor.successNotification,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context).then((r) => Navigator.pop(context));
      }
    }, child: BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ConstColor.backgroundDatalab,
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
                        _tagsField(),
                        _socialMediaField(),
                        _marketPlaceField(),
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
                            child: CircularProgressIndicator(color: ConstColor.darkDatalab,)),
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

// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umkm_application/StoreDetail/bloc/store_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:umkm_application/StoreDetail/ui/store_detail.dart';

class ProductFormPage extends StatefulWidget {
  ProductFormPage(
      {required this.umkmid,
      required this.productid,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      Key? key})
      : super(key: key);

  final String umkmid, productid, name, description, image;
  final int price;

  @override
  _ProductFormPageState createState() => _ProductFormPageState(
      umkmid: umkmid,
      productid: productid,
      name: name,
      description: description,
      image: image,
      price: price);
}

class _ProductFormPageState extends State<ProductFormPage> {
  final String umkmid, productid, name, description, image;
  final int price;
  _ProductFormPageState(
      {required this.umkmid,
      required this.productid,
      required this.name,
      required this.description,
      required this.image,
      required this.price});

  TextEditingController nameProductController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  File _imageFile = File('');
  final ImagePicker picker = ImagePicker();
  late StoreBloc _storeBloc;
  bool isLoading = false;

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

  Widget _priceEntryField(
    String title,
    String hintText,
    TextEditingController controller,
  ) {
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
          TextField(
              controller: controller,
              obscureText: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixText: 'Rp. ',
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
              productid == ""
                  ? _storeBloc.add(addProduct(
                      uid: umkmid,
                      name: nameProductController.text,
                      description: descriptionController.text,
                      price: int.parse(priceController.text),
                      image: _imageFile))
                  : _storeBloc.add(updateProduct(
                      uid: umkmid,
                      productid: productid,
                      name: nameProductController.text,
                      description: descriptionController.text,
                      price: int.parse(priceController.text),
                      image: _imageFile,
                      imageLink: image));
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(productid != "" ? 'Update Produk' : "Tambah Produk",
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          )),
    );
  }

  Widget _deleteButton(BuildContext context) {
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
              colors: [Colors.redAccent, Colors.redAccent])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              _storeBloc.add(deleteProduct(uid: umkmid, productid: productid));
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("Hapus Produk",
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          )),
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

  Widget _form() {
    return Column(
      children: <Widget>[
        _entryField(
            "Nama Produk", "Masukkan nama produk", nameProductController,
            entryIcon: Icon(
              Icons.window,
              color: ConstColor.sbmdarkBlue,
            )),
        _entryField("Deskripsi Produk", "Masukkan deskripsi produk",
            descriptionController,
            entryIcon: Icon(Icons.list_alt, color: ConstColor.sbmdarkBlue)),
        _priceEntryField(
          "Harga Produk",
          "Masukkan Harga Produk",
          priceController,
        ),
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

  setController() {
    nameProductController.text = name;
    priceController.text = price.toString();
    descriptionController.text = description;
  }

  @override
  void initState() {
    super.initState();
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    if (productid != "") {
      setController();
    }
  }

  @override
  void dispose() {
    nameProductController.dispose();
    descriptionController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<StoreBloc, StoreState>(listener: (context, state) {
      if (state is AddProductFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: "Penambahan Produk Gagal",
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

      if (state is AddProductSucceed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: "Penambahan Produk Berhasil",
          titleColor: Colors.white,
          message: "Produk Berhasil Ditambahkan.",
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

      if (state is UpdateProductFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: "Perbuahan Produk Gagal",
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

      if (state is UpdateProductSucceed) {
        setState(() {
          isLoading = false;
        });

        Flushbar(
          title: "Update Produk Berhasil",
          titleColor: Colors.white,
          message: "Produk Berhasil Diperbarui.",
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

      if (state is DeleteProductFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: "Penghapusan Produk Gagal",
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

      if (state is DeleteProductSucceed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: "Penghapusan Produk Berhasil",
          titleColor: Colors.white,
          message: "Produk Berhasil Dihapus.",
          messageColor: Colors.white,
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xffffae88),
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context).then((r) =>                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreDetail(
                              uid: umkmid,
                            ))));
      }

      if (state is StoreLoading) {
        setState(() {
          isLoading = true;
        });
      }
    }, child: BlocBuilder<StoreBloc, StoreState>(
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
                        SizedBox(
                          height: 10,
                        ),
                        productid != "" ? _deleteButton(context) : Container(),
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

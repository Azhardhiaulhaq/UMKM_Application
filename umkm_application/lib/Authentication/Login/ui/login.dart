// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:umkm_application/Authentication/Login/bloc/bloc/login_bloc.dart';
import 'package:umkm_application/Authentication/Signup/ui/signupscreen.dart';
import 'package:umkm_application/BottomNav/ui/bottomnav.dart';
import 'package:umkm_application/Const/const_color.dart';
import '../../../widget/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  // late DocumentReference statistics;
  late LoginBloc _loginBloc;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isLoading = false;

  String? validateEmail(String? value) {
    if (value == null) {
      setState(() {
        isEmailValid = false;
      });
      return 'Alamat email tidak boleh kosong';
    } else {
      if (!value.contains('@')) {
        setState(() {
          isEmailValid = false;
        });
        return 'Alamat email tidak valid';
      } else {
        setState(() {
          isEmailValid = true;
        });
        return null;
      }
    }
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
      {bool isPassword = false, Icon? entryIcon}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: ConstColor.textDatalab),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: entryIcon,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ConstColor.darkDatalab),
                    borderRadius: BorderRadius.circular(15)),
                fillColor: ConstColor.textfieldBG,
                filled: true,
                hintText: hintText,
              ))
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
              colors: [ConstColor.darkDatalab, ConstColor.darkDatalab])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              _loginBloc.add(SignInButtonPressed(
                  email: emailController.text,
                  password: passwordController.text));
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Masuk',
                    style: TextStyle(
                        fontSize: 20, color: ConstColor.secondaryTextDatalab))),
          )),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Belum punya akun ?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ConstColor.darkDatalab),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Daftar',
              style: TextStyle(
                  color: ConstColor.secondaryTextDatalab,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", "Masukkan alamat email", emailController,
            entryIcon: Icon(Icons.email, color: ConstColor.darkDatalab)),
        _entryField("Password", "Masukkan password", passwordController,
            isPassword: true,
            entryIcon: Icon(Icons.lock, color: ConstColor.darkDatalab)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: 'Login Gagal',
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
      if (state is LoginLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is LoginSucceed) {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation(
                      menuScreenContext: context,
                    )));
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
            body: Container(
          color: ConstColor.backgroundDatalab,
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      // _title(),
                      SizedBox(height: 100),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      _submitButton(context),
                      SizedBox(height: height * .055),
                      _createAccountLabel(),
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
                  : Container(),
            ],
          ),
        ));
      },
    ));
  }
}

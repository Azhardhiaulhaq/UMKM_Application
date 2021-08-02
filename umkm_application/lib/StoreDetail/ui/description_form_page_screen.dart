import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm_application/Event/ui/event_form_page.dart';
import 'package:umkm_application/StoreDetail/bloc/store_bloc.dart';
import 'package:umkm_application/StoreDetail/ui/description_form_page.dart';

class StoreFormScreen extends StatelessWidget {
  final String address,
      bukalapakName,
      city,
      description,
      email,
      facebookAcc,
      instagramAcc,
      phoneNumber,
      province,
      shoopeName,
      tokopediaName,
      umkmName,
      youtubeLink,
      uid;
  final List<String> tag;
  const StoreFormScreen({
    required this.address,
    required this.bukalapakName,
    required this.city,
    required this.description,
    required this.email,
    required this.facebookAcc,
    required this.instagramAcc,
    required this.phoneNumber,
    required this.province,
    required this.shoopeName,
    required this.tokopediaName,
    required this.umkmName,
    required this.youtubeLink,
    required this.uid,
    required this.tag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(),
          child: StoreFormPage(
            address: address,
            bukalapakName: bukalapakName,
            city: city,
            description: description,
            email: email,
            facebookAcc: facebookAcc,
            instagramAcc: instagramAcc,
            phoneNumber: phoneNumber,
            province: province,
            shoopeName: shoopeName,
            tag: tag,
            tokopediaName: tokopediaName,
            uid: uid,
            umkmName: umkmName,
            youtubeLink: youtubeLink,
          )),
    );
  }
}

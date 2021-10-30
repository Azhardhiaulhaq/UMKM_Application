import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm_application/Model/store.dart';

import 'package:umkm_application/StoreDetail/bloc/store_bloc.dart';
import 'package:umkm_application/StoreDetail/ui/description_form_page.dart';

class StoreFormScreen extends StatelessWidget {
  static const routeName = '/store/detail/form';
  final Store store;
  const StoreFormScreen({
    required this.store,
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
            store: store,
          )),
    );
  }
}

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm_application/Model/product.dart';
import 'package:umkm_application/StoreDetail/bloc/store_bloc.dart';
import 'package:umkm_application/StoreDetail/ui/product_form_page.dart';

class ProductFormScreen extends StatelessWidget {
  final String umkmid;
  final Product product;
  const ProductFormScreen({
    required this.umkmid,
    required this.product,
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
          child: ProductFormPage(umkmid : umkmid, product : product)),
    );
  }
}

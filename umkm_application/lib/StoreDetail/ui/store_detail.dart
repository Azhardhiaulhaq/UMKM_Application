import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/StoreDetail/ui/store_description.dart';

class StoreDetail extends StatelessWidget {
  final BuildContext context;
  final Store model;
  StoreDetail({Key? key, required this.context, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xfffbfbfb),
        appBar: AppBar(
            backgroundColor: ConstColor.sbmdarkBlue,
            elevation: 1,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context)),
            title: Text(model.name,
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            bottom: TabBar(
              indicator: BoxDecoration(borderRadius: BorderRadius.circular(25),color: ConstColor.sbmdarkBlue),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [Tab(text: "Description"), Tab(text: "Products")],
            ),),
            body: TabBarView(children: [StoreDescription(context: context, model:model), Text('Products')],)
      ),
    );
  }
}

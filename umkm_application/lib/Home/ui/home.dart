import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:umkm_application/Model/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/widget/category_tab.dart';
import 'package:umkm_application/widget/store_list.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<String> categorySelected = ["makanan", "pakaian", "kesenian"];
  TextEditingController searchController =
      TextEditingController(text: "");
  String searchQuery = "";
  Widget _title() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Daftar',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400)),
                    Text('Anggota UMKM',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700))
                  ])
            ]));
  }

  Widget _search() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xffE1E2E4),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                onChanged: (search){
                  setState(() {
                    searchQuery = search.toUpperCase();
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Cari UMKM yang diinginkan",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => CategoryTab(
                model: category,
                onSelected: (model) {
                  setState(() {
                    AppData.categoryList.forEach((item) {
                      item.isSelected = false;
                    });

                    categorySelected = [];
                    if (model.name.toLowerCase() == "semua") {
                      categorySelected = ["makanan", "pakaian", "kesenian"];
                    } else {
                      categorySelected.add(model.name.toLowerCase());
                    }
                    print(categorySelected);
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Stream<QuerySnapshot> homeStream() {
    return searchQuery != "" ? users.where(
        "umkm_name",
        isGreaterThanOrEqualTo: searchQuery,
        isLessThan: searchQuery.substring(0, searchQuery.length - 1) +
            String.fromCharCode(searchQuery.codeUnitAt(searchQuery.length - 1) + 1),
      ).where("tag", arrayContainsAny: categorySelected).snapshots() : users.where("tag", arrayContainsAny: categorySelected).snapshots();
  }

  Widget _storeCard() {
    return StreamBuilder<QuerySnapshot>(
      stream: homeStream(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }
        return Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: snapshot.data!.docs
              .map((e) => StoreList(
                  id: e.get('uid'),
                  name: e.get('umkm_name'),
                  image: e.get('image'),
                  city: e.get('city'),
                  province: e.get('province'),
                  bukalapak: e.get('bukalapak_name'),
                  description: e.get('description'),
                  phone: e.get('phone_number'),
                  email: e.get("email"),
                  address: e.get('address'),
                  youtube_link: e.get('youtube_link'),
                  instagram: e.get('instagram_acc'),
                  facebook: e.get('facebook_acc'),
                  shoope: e.get('shoope_name'),
                  tokopedia: e.get('tokopedia_name'),
                  tags: List.from(
                    e.get('tag'),
                  )))
              .toList(),
        ));
      },
    );
  }

  // Widget _makeLabel(String labelCategory) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //       color: ConstColor.sbmdarkBlue,
  //       border: Border.all(color: ConstColor.sbmdarkBlue, width: 2),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //           color: Color(0xfffbf2ef),
  //           blurRadius: 10,
  //           spreadRadius: 5,
  //           offset: Offset(5, 5),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Text(labelCategory,
  //             style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w700,
  //                 color: Colors.white)),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _title(),
                    _search(),
                    _categoryWidget(),
                    _storeCard(),
                    SizedBox(height: 100)
                  ],
                )))
      ]),
    ));
  }
}

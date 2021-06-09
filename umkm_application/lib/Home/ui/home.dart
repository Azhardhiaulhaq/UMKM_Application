import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/widget/category_tab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _title() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Our',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400)),
                    Text('UMKM Members',
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
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
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
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _storeCard() {
    return Flexible(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height:160,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://marketplace-images-production.s3-us-west-2.amazonaws.com/vault/items/preview-552e2ef3-5814-481c-8390-74360a141525-1180x660-DqZTZ.jpg"),
                      minRadius: 30,
                      maxRadius: 50,
                    ),
                    SizedBox(width: 5),
                    VerticalDivider(),
                    SizedBox(width: 5),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sepatu Murah Bandung ABCDEF',
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Bandung, Jawa Barat',
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            SizedBox(height: 15),
                            // _makeLabel("Food"),
                            Wrap(
                              direction: Axis.horizontal,
                              spacing: 5,
                              children: [_makeLabel("Food"),_makeLabel("Fashion"),_makeLabel("Art")]
                            )
                          ],
                        ))
                  ],
                ),
              ))),
    );
  }

// Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 const ListTile(
//                     leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             "https://marketplace-images-production.s3-us-west-2.amazonaws.com/vault/items/preview-552e2ef3-5814-481c-8390-74360a141525-1180x660-DqZTZ.jpg"),),
//                             title: Text('Sepatu Murah Bandung', style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 16)),
//                             subtitle: Text('Bandung, Jawa Barat', style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold)))
//               ],
//             )

  Widget _makeLabel(String labelCategory) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: ConstColor.sbmdarkBlue,
            border: Border.all(color: ConstColor.sbmdarkBlue, width: 2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xfffbf2ef),
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(labelCategory,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ],
          ),
        );
  }

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
                  ],
                )))
      ]),
    ));
  }
}
// Container(
//         decoration: BoxDecoration(color: ConstColor.lightgreyBG),
//         child: Center(child: Text('Home Screen')));

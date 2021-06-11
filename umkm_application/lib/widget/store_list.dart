import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/StoreDetail/ui/store_detail.dart';

class StoreList extends StatelessWidget {
  final Store model;
  StoreList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model.id == null
        ? Container(width: 5)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => pushNewScreen(context,
                screen: StoreDetail(context: context, model : model)),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
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
                              backgroundImage: NetworkImage(model.image),
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
                                    Text(model.name,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(model.city + ', ' + model.province,
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
                                        children: model.tags
                                            .map(
                                              (label) => _makeLabel(label),
                                            )
                                            .toList())
                                  ],
                                ))
                          ],
                        ),
                      ))),
            ));
  }

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
}

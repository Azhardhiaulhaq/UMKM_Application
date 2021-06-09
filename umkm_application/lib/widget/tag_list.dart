import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';

class TagLabel extends StatelessWidget {
  final String tag;
  TagLabel({Key? key, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: ConstColor.sbmdarkBlue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             ListTile(leading:Icon(Icons.label, color: Colors.white),title: Text(tag),)
          ],
        ));
  }
}

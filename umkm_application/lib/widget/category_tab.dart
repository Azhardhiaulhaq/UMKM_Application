import 'package:flutter/material.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/category.dart';

class CategoryTab extends StatelessWidget {
  final ValueChanged<Category> onSelected;
  final Category model;
  CategoryTab({Key? key, required this.model, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return model.id == null
        ? Container(width: 5)
        : Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => onSelected(model),
            child : Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical:15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: model.isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                    color: model.isSelected
                        ? ConstColor.sbmdarkBlue
                        : ConstColor.lightgreyBG,
                    width: model.isSelected ? 2 : 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: model.isSelected ? Color(0xfffbf2ef) : Colors.white,
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  model.icon != null
                      ? Icon(model.icon,
                          color: model.isSelected
                              ? ConstColor.sbmdarkBlue
                              : Colors.black)
                      : SizedBox(),
                  SizedBox(
                    width: 10,
                  ),
                  // ignore: unnecessary_null_comparison
                  model.name == null
                      ? Container()
                      : Container(
                          child: Text(model.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: model.isSelected
                                      ? ConstColor.sbmdarkBlue
                                      : Colors.black)),
                        ),
                ],
              ),
            ))
          ));
  }
}

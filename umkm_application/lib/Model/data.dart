import 'package:flutter/material.dart';
import 'package:umkm_application/Model/category.dart';
import 'package:umkm_application/Model/store.dart';

class AppData{
  static List<Category> categoryList = [
    Category(id:1,name:"All",isSelected:true,icon:Icons.store),
    Category(id:2,name:"Food",icon:Icons.fastfood),
    Category(id:3,name:"Fashion",icon:Icons.emoji_people),
    Category(id:4,name:"Art",icon:Icons.emoji_nature),
  ];

  static List<Store> storeList = [
    Store(id:1,name:"Sepatu Murah Bandung",city:"Bandung",province:"Jawa Barat",tags:["Fashion"]),
  ];
}

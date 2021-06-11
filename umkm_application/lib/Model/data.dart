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
    Store(id:1,name:"Sepatu Murah Bandung Jaya ABCDEFGH",image:"https://marketplace-images-production.s3-us-west-2.amazonaws.com/vault/items/preview-552e2ef3-5814-481c-8390-74360a141525-1180x660-DqZTZ.jpg", city:"Bandung",province:"Jawa Barat",tags:["Fashion"]),
    Store(id:2,name:"Sepatu Murah Surabaya",image:"https://marketplace-images-production.s3-us-west-2.amazonaws.com/vault/items/preview-552e2ef3-5814-481c-8390-74360a141525-1180x660-DqZTZ.jpg", city:"Bandung",province:"Jawa Barat",tags:["Fashion"]),
    Store(id:3,name:"Sepatu Murah Medan",image:"https://marketplace-images-production.s3-us-west-2.amazonaws.com/vault/items/preview-552e2ef3-5814-481c-8390-74360a141525-1180x660-DqZTZ.jpg", city:"Bandung",province:"Jawa Barat",tags:["Fashion"]),
    Store(id:4,name:"Seblak Jeletet",image:"https://marketplace-images-production.s3-us-west-2.amazonaws.com/vault/items/preview-552e2ef3-5814-481c-8390-74360a141525-1180x660-DqZTZ.jpg", city:"Bandung",province:"Jawa Barat",tags:["Fashion","Food"]),
  ];
}

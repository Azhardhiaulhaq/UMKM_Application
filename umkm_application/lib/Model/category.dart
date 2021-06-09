import 'package:flutter/material.dart';

class Category{
  int id;
  String name;
  bool isSelected;
  IconData? icon;
  Category({required this.id,required this.name, this.isSelected=false,this.icon});
}
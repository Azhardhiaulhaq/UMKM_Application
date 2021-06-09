import 'package:flutter/material.dart';

class Store{
  int id;
  String name;
  String? image;
  String city;
  String province;
  List<String>? tags;
  String? phoneNumber;
  String? email;
  Store({required this.id,required this.name, this.image, required this.city, required this.province, this.tags, this.phoneNumber, this.email});
}
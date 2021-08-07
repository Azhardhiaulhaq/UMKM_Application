part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class updateStore extends StoreEvent {
  String address,
      // ignore: non_constant_identifier_names
      bukalapak_name,
      city,
      description,
      email,
      facebook_acc,
      instagram_acc,
      phone_number,
      province,
      shoope_name,
      tokopedia_name,
      umkm_name,
      youtube_link,
      uid;
  List<String> tag;

  updateStore(
      {required this.uid,
      required this.address,
      required this.bukalapak_name,
      required this.city,
      required this.description,
      required this.email,
      required this.facebook_acc,
      required this.instagram_acc,
      required this.phone_number,
      required this.province,
      required this.shoope_name,
      required this.tag,
      required this.tokopedia_name,
      required this.umkm_name,
      required this.youtube_link});
}

class addProduct extends StoreEvent {
  String uid, name, description;
  File image;
  int price;

  addProduct(
      {required this.uid,
      required this.name,
      required this.description,
      required this.image,
      required this.price});
}

class updateProduct extends StoreEvent {
  String uid, productid, name, description, imageLink;
  File image;
  int price;

  updateProduct(
      {required this.uid,
      required this.productid,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.imageLink});
}

class deleteProduct extends StoreEvent {
  String uid, productid;


  deleteProduct(
      {required this.uid,
      required this.productid,});
}

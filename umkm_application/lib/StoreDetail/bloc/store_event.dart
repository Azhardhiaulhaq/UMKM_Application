part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class updateStore extends StoreEvent {
  Store store;
    updateStore(
      {required this.store});
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

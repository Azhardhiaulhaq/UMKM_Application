part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();
  
  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}
// ignore: must_be_immutable
class UpdateStoreSucceed extends StoreState {
  
}

// ignore: must_be_immutable
class UpdateStoreFailed extends StoreState {
  String message;
  UpdateStoreFailed({required this.message});
}

class AddProductSucceed extends StoreState {
  
}

class DeleteProductSucceed extends StoreState {
  
}

class UpdateProductSucceed extends StoreState {
  
}
// ignore: must_be_immutable
class DeleteProductFailed extends StoreState {
  String message;
  DeleteProductFailed({required this.message});
}

// ignore: must_be_immutable
class AddProductFailed extends StoreState {
  String message;
  AddProductFailed({required this.message});
}
// ignore: must_be_immutable
class UpdateProductFailed extends StoreState {
  String message;
  UpdateProductFailed({required this.message});
}
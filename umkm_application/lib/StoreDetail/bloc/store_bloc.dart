import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:umkm_application/data/repositories/store_repositories.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial());

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is updateStore) {
      yield StoreLoading();
      try {
        await StoreRepository.updateStore(
            event.address,
            event.bukalapak_name,
            event.city,
            event.description,
            event.email,
            event.facebook_acc,
            event.instagram_acc,
            event.phone_number,
            event.province,
            event.shoope_name,
            event.tokopedia_name,
            event.umkm_name,
            event.youtube_link,
            event.uid,
            event.tag);
        yield UpdateStoreSucceed();
      } catch (e) {
        yield UpdateStoreFailed(message: e.toString());
      }
    } else if (event is addProduct) {
      yield StoreLoading();
      try {
        await StoreRepository.addProduct(
            event.uid, event.name, event.description, event.image, event.price);
        yield AddProductSucceed();
      } catch (e) {
        yield AddProductFailed(message: e.toString());
      }
    } else if (event is updateProduct) {
      yield StoreLoading();
      try {
        await StoreRepository.updateProduct(
            event.uid,
            event.productid,
            event.name,
            event.description,
            event.image,
            event.price,
            event.imageLink);
        yield UpdateProductSucceed();
      } catch (e) {
        yield UpdateProductFailed(message: e.toString());
      }
    } else if(event is deleteProduct){
      yield StoreLoading();
      try{
        await StoreRepository.deleteProduct(event.uid, event.productid);
        yield DeleteProductSucceed();
      }catch (e){
        yield DeleteProductFailed(message: e.toString());
      }
    }
  }
}

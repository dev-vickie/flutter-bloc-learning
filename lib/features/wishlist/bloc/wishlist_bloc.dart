import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/data/wishlist_items.dart';
import 'package:learn_bloc/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveItemEvent>(wishlistRemoveItemEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(
      WishlistSuccessState(wishlistProducts: wishlistItems),
    );
  }

  FutureOr<void> wishlistRemoveItemEvent(
      WishlistRemoveItemEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.itemToRemove);
    emit(WishlistSuccessState(wishlistProducts: wishlistItems));
    emit(WishlistItemRemovedActionState());
  }
}

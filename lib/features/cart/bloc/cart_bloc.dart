import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/data/cart_items.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(CartLoadingSuccessState(cartProducts: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.itemToRemove);
    emit(CartItemRemovedActionState(removedItem: event.itemToRemove));

    emit(CartLoadingSuccessState(cartProducts: cartItems));
  }
}

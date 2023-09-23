import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/data/cart_items.dart';
import 'package:learn_bloc/data/grocery_list.dart';
import 'package:learn_bloc/data/wishlist_items.dart';
import 'package:learn_bloc/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //On this EVENT,I want this function to be called
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  //These functions are called when their respective events are added to the bloc
  //The functions emit a state - either a HomeState or HomeActionState
  //The emitted state is then listened in the UI
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    print("home initial event");
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(
      HomeLoadingSuccessState(
        products: GroceryData.groceryItems
            .map(
              (e) => ProductDataModel(
                id: e["id"],
                name: e["name"],
                price: e["price"],
                description: e["description"],
                imageUrl: e["imageUrl"],
              ),
            )
            .toList(),
      ),
    );
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("wishlist button clicked");
    emit(HomeNavigateToWishlistActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("cart button clicked");
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    wishlistItems.add(event.clickedProduct);
    print("Product wishlist button clicked");
    emit(HomeProductWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.clickedProduct);
    print("Product cart button clicked");
    emit(HomeProductCartedActionState());
  }
}

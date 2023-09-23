part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

@immutable
sealed class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadingSuccessState extends CartState {
  final List<ProductDataModel> cartProducts;

  CartLoadingSuccessState({required this.cartProducts});
}

class CartItemRemovedActionState extends CartActionState {
  final ProductDataModel removedItem;

  CartItemRemovedActionState({required this.removedItem});
}

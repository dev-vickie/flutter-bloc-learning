part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveFromCartEvent extends CartEvent {
  final ProductDataModel itemToRemove;

  CartRemoveFromCartEvent({required this.itemToRemove});
}

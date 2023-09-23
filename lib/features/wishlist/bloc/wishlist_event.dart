part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemoveItemEvent extends WishlistEvent {
  final ProductDataModel itemToRemove;

  WishlistRemoveItemEvent({required this.itemToRemove});
}

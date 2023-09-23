part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistProducts;

  WishlistSuccessState({required this.wishlistProducts});
}

class WishlistItemRemovedActionState extends WishlistActionState {}

part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

//Home states - when i get these states i want to SHOW something
//Action states - when i get these states i want to TAKE AN ACTION
abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadingSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistActionState extends HomeActionState {}

class HomeNavigateToCartActionState extends HomeActionState {}

class HomeProductCartedActionState extends HomeActionState{}

class HomeProductWishlistedActionState extends HomeActionState{}

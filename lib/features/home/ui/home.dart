import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/cart/ui/cart.dart';
import 'package:learn_bloc/features/home/bloc/home_bloc.dart';
import 'package:learn_bloc/features/home/ui/product_tile.dart';
import 'package:learn_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      //Listen when you get an ACTION state
      listenWhen: (previous, current) => current is HomeActionState,
      //Build when you don't get an action state(homestate)
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const Wishlist();
            }),
          );
        } else if (state is HomeNavigateToCartActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const Cart();
            }),
          );
        } else if (state is HomeProductWishlistedActionState) {
          final item = state.wishlistProduct;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${item.name} Wishlisted Successfully"),
            ),
          );
        } else if (state is HomeProductCartedActionState) {
          final item = state.cartProduct;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${item.name} Carted Successfully"),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            print("Loading state");
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadingSuccessState:
            print("Loading success state");
            final products = (state as HomeLoadingSuccessState).products;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Vic grocery"),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductTile(
                    product: products[index],
                    homeBloc: homeBloc,
                  );
                },
              ),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          default:
            return Offstage();
        }
      },
    );
  }
}

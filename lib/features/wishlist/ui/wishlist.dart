import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:learn_bloc/features/wishlist/ui/wishlist_product_tile.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listenWhen: (previous, current) => current is WishlistActionState,
        listener: (context, state) {
          if (state is WishlistItemRemovedActionState) {
            final removedProduct = state.removedProduct;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${removedProduct.name} removed from wishlist"),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case WishlistSuccessState:
              final wishlistItems =
                  (state as WishlistSuccessState).wishlistProducts;
              return ListView.builder(
                itemCount: wishlistItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return WishlistProductTile(
                    product: wishlistItems[index],
                    wishlistBloc: wishlistBloc,
                  );
                },
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learn_bloc/features/cart/ui/cart_product_tile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {
          if (state is CartItemRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Product removed from Cart"),
              ),
            );
          }
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case CartLoadingSuccessState:
              final cartProducts =
                  (state as CartLoadingSuccessState).cartProducts;
              return ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartProductTile(
                      product: cartProducts[index], cartBloc: cartBloc);
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

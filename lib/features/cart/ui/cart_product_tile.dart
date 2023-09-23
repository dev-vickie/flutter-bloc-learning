import 'package:flutter/material.dart';
import 'package:learn_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learn_bloc/features/home/models/home_product_data_model.dart';

class CartProductTile extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductDataModel product;
  const CartProductTile(
      {super.key, required this.product, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 120,
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("${product.name}"),
                  Text("${product.price}"),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      cartBloc.add(
                        CartRemoveFromCartEvent(itemToRemove: product),
                      );
                    },
                    icon: Icon(Icons.remove_circle),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

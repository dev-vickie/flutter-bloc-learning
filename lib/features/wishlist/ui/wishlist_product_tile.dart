import 'package:flutter/material.dart';
import 'package:learn_bloc/features/home/models/home_product_data_model.dart';
import 'package:learn_bloc/features/wishlist/bloc/wishlist_bloc.dart';

class WishlistProductTile extends StatelessWidget {
  final WishlistBloc wishlistBloc;
  final ProductDataModel product;
  const WishlistProductTile(
      {super.key, required this.product, required this.wishlistBloc});

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
                      wishlistBloc.add(
                        WishlistRemoveItemEvent(itemToRemove: product),
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

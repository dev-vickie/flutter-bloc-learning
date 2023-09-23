import 'package:flutter/material.dart';
import 'package:learn_bloc/features/home/bloc/home_bloc.dart';
import 'package:learn_bloc/features/home/models/home_product_data_model.dart';

class ProductTile extends StatelessWidget {
  final HomeBloc homeBloc;
  final ProductDataModel product;
  const ProductTile({super.key, required this.product, required this.homeBloc});

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
                    onPressed: () {
                      homeBloc.add(HomeProductWishlistButtonClickedEvent(clickedProduct: product));
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(clickedProduct: product));
                    },
                    icon: Icon(Icons.add_shopping_cart),
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

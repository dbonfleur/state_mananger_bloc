import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../blocs/wishlist/wishlist_event.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';

class WishlistItem extends StatelessWidget {
  final Product product;
  final WishlistBloc wishlistBloc;
  final CartBloc cartBloc; // Add the cartBloc here

  const WishlistItem({
    super.key,
    required this.product,
    required this.wishlistBloc,
    required this.cartBloc, // Add the cartBloc here
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(product.name),
        subtitle: Text('R\$${product.price.toString()}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
              onPressed: () {
                cartBloc.add(AddItemToCart(product));
                wishlistBloc.add(RemoveItemFromWishlist(product));
              },
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () {
                wishlistBloc.add(RemoveItemFromWishlist(product));
              },
            ),
          ],
        ),
      ),
    );
  }
}

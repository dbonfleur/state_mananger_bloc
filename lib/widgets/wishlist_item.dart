import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../blocs/wishlist/wishlist_event.dart';

class WishlistItem extends StatelessWidget {
  final Product product;
  final WishlistBloc wishlistBloc;

  const WishlistItem({
    super.key,
    required this.product,
    required this.wishlistBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(product.name),
        subtitle: Text('\$${product.price.toString()}'),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () {
            wishlistBloc.add(RemoveItemFromWishlist(product));
          },
        ),
      ),
    );
  }
}

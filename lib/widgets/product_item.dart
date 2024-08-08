import 'package:flutter/material.dart';
import '../blocs/cart/cart_state.dart';
import '../models/product_model.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../blocs/wishlist/wishlist_event.dart';
import '../blocs/wishlist/wishlist_state.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final CartBloc cartBloc;
  final WishlistBloc wishlistBloc;

  const ProductItem({
    super.key,
    required this.product,
    required this.cartBloc,
    required this.wishlistBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(product.description),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text('R\$${product.price.toString()}', style: const TextStyle(fontSize: 16)),
                Row(
                  children: [
                    // Bloc do carrinho de compras
                    StreamBuilder(
                      stream: cartBloc.stream,
                      initialData: cartBloc.state,
                      builder: (context, snapshot) {
                        final cartState = snapshot.data;
                        final isInCart = cartState is CartUpdated && cartState.cart.items.any((item) => item.product.id == product.id);
                        return IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: isInCart ? Colors.green : null,
                          ),
                          onPressed: () {
                            cartBloc.add(AddItemToCart(product));
                          },
                        );
                      },
                    ),
                    StreamBuilder<WishlistState>(
                      stream: wishlistBloc.stream,
                      initialData: wishlistBloc.state,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        final isInWishlist = state is WishlistUpdated && state.wishlist.contains(product);
                        return IconButton(
                          icon: Icon(
                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                            color: isInWishlist ? Colors.red : null,
                          ),
                          onPressed: () {
                            if (isInWishlist) {
                              wishlistBloc.add(RemoveItemFromWishlist(product));
                            } else {
                              wishlistBloc.add(AddItemToWishlist(product));
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

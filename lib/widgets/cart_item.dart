import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final CartBloc cartBloc;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.cartBloc,
  });

  void _updateQuantity(int quantity) {
    cartBloc.add(UpdateItemQuantity(cartItem.product, quantity));
  }

  void _removeItem() {
    cartBloc.add(RemoveItemFromCart(cartItem.product));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(cartItem.product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('Quantidade: '),
                      IconButton(
                        icon: Icon(Icons.remove, color: cartItem.quantity > 1 ? Colors.red : Colors.grey),
                        onPressed: cartItem.quantity > 1 ? () => _updateQuantity(cartItem.quantity - 1) : null,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.green),
                        onPressed: () => _updateQuantity(cartItem.quantity + 1),
                      ),
                    ],
                  ),
                  Text('Subtotal: R\$${(cartItem.quantity * cartItem.product.price).toStringAsFixed(2)}'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _removeItem,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../models/cart_model.dart';
import '../repositories/cart_repository.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  final CartBloc cartBloc;
  final CartRepository cartRepository;

  const CartScreen({
    super.key,
    required this.cartBloc,
    required this.cartRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: ValueListenableBuilder<Cart>(
        valueListenable: cartRepository.cartNotifier,
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.items[index];
                    return CartItemWidget(cartItem: cartItem, cartBloc: cartBloc);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Total: R\$${cart.total.toStringAsFixed(2)}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        cartBloc.add(ConfirmPurchase());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Compra confirmada!')),
                        );
                      },
                      child: const Text('Confirmar Compra'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

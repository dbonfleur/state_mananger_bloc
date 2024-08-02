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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total: R\$${cart.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 42, 41, 41),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        cartBloc.add(ConfirmPurchase());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Compra confirmada!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Confirmar Compra!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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

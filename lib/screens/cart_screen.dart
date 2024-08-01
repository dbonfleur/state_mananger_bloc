import 'package:flutter/material.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../models/cart_model.dart';
import '../repositories/cart_repository.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  final CartBloc cartBloc;
  final CartRepository cartRepository;

  const CartScreen({super.key, required this.cartBloc, required this.cartRepository});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    widget.cartBloc.add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: ValueListenableBuilder<Cart>(
        valueListenable: widget.cartRepository.cartNotifier,
        builder: (context, cart, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(
                      cartItem: cart.items[index],
                      cartBloc: widget.cartBloc,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Total: \$${cart.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Implement checkout functionality
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
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

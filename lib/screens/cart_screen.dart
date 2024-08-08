import 'package:flutter/material.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  final CartBloc cartBloc;

  const CartScreen({
    super.key,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      // Bluilder para exibir o carrinho de compras
      body: StreamBuilder<CartState>(
        stream: cartBloc.stream,
        initialData: cartBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state is CartUpdated) {
            final cart = state.cart;

            if (cart.items.isEmpty) {
              return const Center(child: Text('Seu carrinho está vazio.'));
            }

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
                        onPressed: cart.items.isEmpty
                            ? null
                            : () {
                                cartBloc.add(ConfirmPurchase());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Compra confirmada!')),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: cart.items.isEmpty ? Colors.grey : Colors.green[700],
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

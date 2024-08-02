import 'package:flutter/material.dart';
import 'package:state_mananger_bloc/blocs/cart/cart_bloc.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../blocs/wishlist/wishlist_state.dart';
import '../widgets/wishlist_item.dart';

class WishlistScreen extends StatelessWidget {
  final WishlistBloc wishlistBloc;
  final CartBloc cartBloc;

  const WishlistScreen({super.key, required this.wishlistBloc, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Desejos'),
      ),
      body: StreamBuilder<WishlistState>(
        stream: wishlistBloc.stream,
        initialData: wishlistBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is WishlistUpdated) {
            if (state.wishlist.isEmpty) {
              return const Center(
                child: Text(
                  'Não há itens na lista de desejos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.wishlist.length,
              itemBuilder: (context, index) {
                return WishlistItem(
                  product: state.wishlist[index],
                  wishlistBloc: wishlistBloc,
                  cartBloc: cartBloc,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

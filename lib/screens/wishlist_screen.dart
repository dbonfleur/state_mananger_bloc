import 'package:flutter/material.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../blocs/wishlist/wishlist_state.dart';
import '../widgets/wishlist_item.dart';

class WishlistScreen extends StatelessWidget {
  final WishlistBloc wishlistBloc;

  const WishlistScreen({super.key, required this.wishlistBloc});

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
            return ListView.builder(
              itemCount: state.wishlist.length,
              itemBuilder: (context, index) {
                return WishlistItem(
                  product: state.wishlist[index],
                  wishlistBloc: wishlistBloc,
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

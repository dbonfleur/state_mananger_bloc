import 'package:flutter/material.dart';
import '../blocs/order/order_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_event.dart';
import '../blocs/product/product_state.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../blocs/wishlist/wishlist_state.dart';
import '../models/cart_model.dart';
import '../repositories/product_repository.dart';
import '../repositories/cart_repository.dart';
import '../repositories/wishlist_repository.dart';
import '../repositories/order_repository.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'order_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductBloc _productBloc;
  late CartBloc _cartBloc;
  late WishlistBloc _wishlistBloc;
  late OrderBloc _orderBloc;
  late CartRepository _cartRepository;

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(ProductRepository());
    _cartRepository = CartRepository();
    _orderBloc = OrderBloc(OrderRepository());
    _cartBloc = CartBloc(_cartRepository, _orderBloc);
    _wishlistBloc = WishlistBloc(WishlistRepository());
    _productBloc.add(LoadProducts());
  }

  @override
  void dispose() {
    _productBloc.close();
    _cartBloc.close();
    _wishlistBloc.close();
    _orderBloc.close();
    super.dispose();
  }

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen(cartBloc: _cartBloc, cartRepository: _cartRepository)),
    );
  }

  void _navigateToWishlist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WishlistScreen(wishlistBloc: _wishlistBloc)),
    );
  }

  void _navigateToOrderHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderHistoryScreen(orderBloc: _orderBloc)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              _navigateToOrderHistory(context);
            },
          ),
          ValueListenableBuilder<Cart>(
            valueListenable: _cartRepository.cartNotifier,
            builder: (context, cart, child) {
              final itemCount = cart.items.fold(0, (total, item) => total + item.quantity);
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      _navigateToCart(context);
                    },
                  ),
                  if (itemCount > 0)
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '$itemCount',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  _navigateToWishlist(context);
                },
              ),
              Positioned(
                right: 0,
                child: StreamBuilder<WishlistState>(
                  stream: _wishlistBloc.stream,
                  initialData: _wishlistBloc.state,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final itemCount = state is WishlistUpdated ? state.wishlist.length : 0;
                    return itemCount > 0
                        ? CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              '$itemCount',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<ProductState>(
        stream: _productBloc.stream,
        initialData: _productBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: state.products[index],
                  cartBloc: _cartBloc,
                  wishlistBloc: _wishlistBloc,
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text('Failed to load products: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

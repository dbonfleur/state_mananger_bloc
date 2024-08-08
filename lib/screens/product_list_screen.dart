import 'package:flutter/material.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../blocs/order/order_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_event.dart';
import '../blocs/product/product_state.dart';
import '../blocs/wishlist/wishlist_bloc.dart';
import '../blocs/wishlist/wishlist_state.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(ProductRepository());
    _orderBloc = OrderBloc(OrderRepository());
    _cartBloc = CartBloc(CartRepository(), _orderBloc);
    _wishlistBloc = WishlistBloc(WishlistRepository());
    _productBloc.add(LoadProducts());
    _searchController.addListener(() {
      _productBloc.add(UpdateSearchQuery(_searchController.text));
    });
  }

  @override
  void dispose() {
    _productBloc.close();
    _cartBloc.close();
    _wishlistBloc.close();
    _orderBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen(cartBloc: _cartBloc)),
    );
  }

  void _navigateToWishlist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WishlistScreen(
          wishlistBloc: _wishlistBloc,
          cartBloc: _cartBloc,
        ),
      ),
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
          // Bloc responsável por atualizar o ícone do carrinho de compras
          StreamBuilder<CartState>(
            // Stream que escuta as mudanças de estado do carrinho
            stream: _cartBloc.stream,
            // Estado inicial do stream
            initialData: _cartBloc.state,
            builder: (context, snapshot) {
              if (snapshot.data is CartUpdated) {
                final cart = (snapshot.data as CartUpdated).cart;
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
              } else {
                return IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    _navigateToCart(context);
                  },
                );
              }
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
                // Bloc responsável por atualizar o ícone da lista de desejos
                child: StreamBuilder<WishlistState>(
                  // Stream que escuta as mudanças de estado da lista de desejos
                  stream: _wishlistBloc.stream,
                  // Estado inicial do stream
                  initialData: _wishlistBloc.state,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    // Se o estado atual do stream for WishlistUpdated exibe o número de itens na lista de desejos
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            // Bloc responsável por atualizar as categorias selecionadas
            child: StreamBuilder<ProductState>(
              stream: _productBloc.stream,
              initialData: _productBloc.state,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state is ProductLoaded) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['Frutas', 'Legumes', 'Bebidas', 'Lanches', 'Produtos Higiênicos', 'Cereais']
                        .map((category) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                label: Text(
                                  category,
                                  style: TextStyle(
                                    color: state.selectedCategories.contains(category) ? Colors.green : Colors.black,
                                  ),
                                ),
                                selected: state.selectedCategories.contains(category),
                                onSelected: (selected) {
                                  _productBloc.add(ToggleCategory(category));
                                },
                                backgroundColor: Colors.white,
                                selectedColor: Colors.transparent,
                                side: BorderSide(
                                  color: state.selectedCategories.contains(category) ? Colors.green : Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Expanded(
            // Bloc responsável por atualizar a lista de produtos
            child: StreamBuilder<ProductState>(
              stream: _productBloc.stream,
              initialData: _productBloc.state,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final filteredProducts = state.products.where((product) {
                    final matchesName = product.name.toLowerCase().startsWith(state.searchQuery.toLowerCase());
                    final matchesCategory = state.selectedCategories.isEmpty || state.selectedCategories.contains(product.category);
                    return matchesName && matchesCategory;
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        product: filteredProducts[index],
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
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartRepository {
  final Cart _cart = Cart(items: []);
  final ValueNotifier<Cart> cartNotifier = ValueNotifier<Cart>(Cart(items: []));

  Cart get cart => _cart;

  void addItemToCart(Product product) {
    final cartItem = _cart.items.firstWhere((item) => item.product.id == product.id, orElse: () => CartItem(product: product, quantity: 0));
    if (cartItem.quantity == 0) {
      _cart.items.add(cartItem);
    }
    cartItem.quantity++;
    _updateCart();
  }

  void removeItemFromCart(Product product) {
    final cartItem = _cart.items.firstWhere((item) => item.product.id == product.id);
    _cart.items.remove(cartItem);
    _updateCart();
  }

  void updateItemQuantity(Product product, int quantity) {
    final cartItem = _cart.items.firstWhere((item) => item.product.id == product.id);
    cartItem.quantity = quantity;
    _updateCart();
  }

  void _updateCart() {
    _cart.calculateTotal();
    cartNotifier.value = Cart(items: List.from(_cart.items), total: _cart.total);
  }
}

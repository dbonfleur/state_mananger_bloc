import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class Cart {
  List<CartItem> items;
  double total;

  Cart({required this.items, this.total = 0.0});

  void calculateTotal() {
    total = items.fold(0, (previousValue, item) => previousValue + (item.product.price * item.quantity));
  }
}

import '../models/cart_model.dart';
import '../models/order_model.dart';

class OrderRepository {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void placeOrder(Cart cart) {
    final newOrder = Order(
      id: DateTime.now().toString(),
      date: DateTime.now(),
      total: cart.total,
      items: cart.items,
    );
    _orders.add(newOrder);
  }
}

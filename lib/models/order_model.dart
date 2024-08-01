import 'cart_model.dart';

class Order {
  final String id;
  final DateTime date;
  final double total;
  final List<CartItem> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });
}

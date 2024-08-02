import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;

  const OrderItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Order ID: ${order.id}'),
        subtitle: Text('Date: ${order.date.toString()}'),
        trailing: Text('Total: R\$${order.total.toString()}'),
      ),
    );
  }
}

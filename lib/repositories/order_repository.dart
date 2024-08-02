import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderRepository {
  final List<Order> _orders = [];
  final ValueNotifier<List<Order>> _orderNotifier = ValueNotifier([]);

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    _orderNotifier.value = List.from(_orders);
  }

  ValueNotifier<List<Order>> get orderNotifier => _orderNotifier;
}

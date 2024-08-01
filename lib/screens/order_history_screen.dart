// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../blocs/order_history/order_history_bloc.dart';
import '../blocs/order_history/order_history_event.dart';
import '../blocs/order_history/order_history_state.dart';
import '../repositories/order_repository.dart';
import '../widgets/order_item.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late OrderHistoryBloc _orderHistoryBloc;

  @override
  void initState() {
    super.initState();
    _orderHistoryBloc = OrderHistoryBloc(OrderRepository());
    _orderHistoryBloc.add(LoadOrders());
  }

  @override
  void dispose() {
    _orderHistoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pedidos'),
      ),
      body: StreamBuilder<OrderHistoryState>(
        stream: _orderHistoryBloc.stream,
        initialData: _orderHistoryBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is OrderHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderHistoryLoaded) {
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return OrderItemWidget(order: state.orders[index]);
              },
            );
          } else if (state is OrderHistoryError) {
            return Center(child: Text('Failed to load orders: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

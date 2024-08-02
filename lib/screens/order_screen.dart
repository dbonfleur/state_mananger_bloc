import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../blocs/order/order_bloc.dart';
import '../blocs/order/order_event.dart';
import '../blocs/order/order_state.dart';

class OrderHistoryScreen extends StatefulWidget {
  final OrderBloc orderBloc;

  const OrderHistoryScreen({super.key, required this.orderBloc});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    widget.orderBloc.add(LoadOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pedidos'),
      ),
      body: StreamBuilder<OrderState>(
        stream: widget.orderBloc.stream,
        initialData: widget.orderBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            if (state.orders.isEmpty) {
              return const Center(
                child: Text(
                  'Não há históricos de pedidos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                final date = DateFormat('dd/MM/yyyy - HH:mm').format(order.date);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pedido em $date', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ...order.items.map((item) {
                          return Text('${item.quantity} x ${item.product.name} - R\$${item.product.price}');
                        }),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Total: R\$${order.total.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is OrderError) {
            return Center(child: Text('Erro ao carregar pedidos: ${state.message}'));
          } else {
            return const Center(
              child: Text(
                'Não há históricos de pedidos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }
}

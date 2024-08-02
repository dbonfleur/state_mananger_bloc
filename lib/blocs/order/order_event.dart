import 'package:equatable/equatable.dart';
import '../../models/order_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {}

class AddOrder extends OrderEvent {
  final Order order;

  const AddOrder(this.order);

  @override
  List<Object> get props => [order];
}

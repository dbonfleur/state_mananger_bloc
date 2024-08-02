import 'package:bloc/bloc.dart';
import 'order_event.dart';
import 'order_state.dart';
import '../../repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc(this.orderRepository) : super(OrderLoading()) {
    on<LoadOrders>((event, emit) {
      emit(OrderLoaded(orderRepository.orders));
    });

    on<AddOrder>((event, emit) {
      orderRepository.addOrder(event.order);
      emit(OrderLoaded(orderRepository.orders));
    });
  }
}

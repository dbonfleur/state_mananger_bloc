import 'package:bloc/bloc.dart';

import '../../repositories/order_repository.dart';
import 'order_history_event.dart';
import 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderRepository orderRepository;

  OrderHistoryBloc(this.orderRepository) : super(OrderHistoryInitial()) {
    on<LoadOrders>(_onLoadOrders);
  }

  void _onLoadOrders(LoadOrders event, Emitter<OrderHistoryState> emit) async {
    emit(OrderHistoryLoading());
    try {
      final orders = orderRepository.orders;
      emit(OrderHistoryLoaded(orders));
    } catch (e) {
      emit(OrderHistoryError(e.toString()));
    }
  }
}

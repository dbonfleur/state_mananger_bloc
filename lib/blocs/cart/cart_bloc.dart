import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../models/order_model.dart';
import '../../repositories/cart_repository.dart';
import '../order/order_bloc.dart';
import '../order/order_event.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  final OrderBloc orderBloc;
  
  ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);

  CartBloc(this.cartRepository, this.orderBloc) : super(CartInitial()) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<LoadCart>(_onLoadCart);
    on<ConfirmPurchase>(_onConfirmPurchase);
    cartRepository.cartNotifier.addListener(() {
      add(LoadCart());
    });
  }

  void _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    cartRepository.addItemToCart(event.product);
    _updateItemCount();
    emit(CartUpdated(cartRepository.cartNotifier.value));
  }

  void _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    cartRepository.removeItemFromCart(event.product);
    _updateItemCount();
    emit(CartUpdated(cartRepository.cartNotifier.value));
  }

  void _onUpdateItemQuantity(UpdateItemQuantity event, Emitter<CartState> emit) {
    cartRepository.updateItemQuantity(event.product, event.quantity);
    _updateItemCount();
    emit(CartUpdated(cartRepository.cartNotifier.value));
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(CartUpdated(cartRepository.cartNotifier.value));
  }

  void _updateItemCount() {
    final itemCount = cartRepository.cart.items.fold(0, (total, item) => total + item.quantity);
    itemCountNotifier.value = itemCount;
  }

  void _onConfirmPurchase(event, emit) {
    final order = Order(
        id: DateTime.now().toString(),
        items: List.from(cartRepository.cart.items),
        total: cartRepository.cart.total,
        date: DateTime.now(),
      );
      orderBloc.add(AddOrder(order));
      cartRepository.clearCart();
      emit(CartUpdated(cartRepository.cart));
  }

  @override
  Future<void> close() {
    itemCountNotifier.dispose();
    return super.close();
  }
}

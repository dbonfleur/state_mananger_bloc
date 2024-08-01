import 'package:equatable/equatable.dart';

import '../../models/cart_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final Cart cart;

  const CartUpdated(this.cart);

  @override
  List<Object> get props => [cart];
}

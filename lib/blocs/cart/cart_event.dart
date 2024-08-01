import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartEvent {
  final Product product;

  const AddItemToCart(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveItemFromCart extends CartEvent {
  final Product product;

  const RemoveItemFromCart(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateItemQuantity extends CartEvent {
  final Product product;
  final int quantity;

  const UpdateItemQuantity(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];
}

class LoadCart extends CartEvent {}

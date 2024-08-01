import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class AddItemToWishlist extends WishlistEvent {
  final Product product;

  const AddItemToWishlist(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveItemFromWishlist extends WishlistEvent {
  final Product product;

  const RemoveItemFromWishlist(this.product);

  @override
  List<Object> get props => [product];
}

import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistUpdated extends WishlistState {
  final List<Product> wishlist;

  const WishlistUpdated(this.wishlist);

  @override
  List<Object> get props => [wishlist];
}

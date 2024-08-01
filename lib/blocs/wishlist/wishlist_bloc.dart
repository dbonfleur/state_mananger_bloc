import 'package:bloc/bloc.dart';

import '../../repositories/wishlist_repository.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository wishlistRepository;

  WishlistBloc(this.wishlistRepository) : super(WishlistInitial()) {
    on<AddItemToWishlist>(_onAddItemToWishlist);
    on<RemoveItemFromWishlist>(_onRemoveItemFromWishlist);
  }

  void _onAddItemToWishlist(AddItemToWishlist event, Emitter<WishlistState> emit) {
    wishlistRepository.addItemToWishlist(event.product);
    emit(WishlistUpdated(List.from(wishlistRepository.wishlist)));
  }

  void _onRemoveItemFromWishlist(RemoveItemFromWishlist event, Emitter<WishlistState> emit) {
    wishlistRepository.removeItemFromWishlist(event.product);
    emit(WishlistUpdated(List.from(wishlistRepository.wishlist)));
  }

  int get totalItemsInWishlist {
    return wishlistRepository.wishlist.length;
  }
}

import '../models/product_model.dart';

class WishlistRepository {
  final List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  void addItemToWishlist(Product product) {
    if (!_wishlist.contains(product)) {
      _wishlist.add(product);
    }
  }

  void removeItemFromWishlist(Product product) {
    _wishlist.remove(product);
  }
}

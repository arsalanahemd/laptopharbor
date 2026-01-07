import 'package:flutter/material.dart';
import '../models/wishlist_model.dart';
import '../services/wishlist_service.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistService _service = WishlistService();

  void addWishlist(WishlistModel product) async {
    await _service.addToWishlist(product);
    notifyListeners();
  }

  void removeWishlist(String productId) async {
    await _service.removeFromWishlist(productId);
    notifyListeners();
  }
  Future<bool> checkWishlist(String productId) async {
  return await _service.isInWishlist(productId);
}

Future<void> toggleWishlist(WishlistModel product) async {
  bool exists = await _service.isInWishlist(product.id);

  if (exists) {
    await _service.removeFromWishlist(product.id);
  } else {
    await _service.addToWishlist(product);
  }

  notifyListeners();
}


  Stream get wishlistStream => _service.getWishlist();
}

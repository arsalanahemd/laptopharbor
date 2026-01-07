import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/wishlist_model.dart';

class WishlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser!.uid;

  /// ADD TO WISHLIST
  Future<void> addToWishlist(WishlistModel product) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(product.id)
        .set(product.toMap());
  }

  /// REMOVE FROM WISHLIST
  Future<void> removeFromWishlist(String productId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(productId)
        .delete();
  }

  /// GET WISHLIST
  Stream<QuerySnapshot> getWishlist() {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots();
  }
  Future<bool> isInWishlist(String productId) async {
  final doc = await _firestore
      .collection('users')
      .doc(userId)
      .collection('wishlist')
      .doc(productId)
      .get();

  return doc.exists;
}
}

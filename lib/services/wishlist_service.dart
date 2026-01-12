// lib/services/wishlist_service.dart

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_harbor/models/laptop_model.dart';

class WishlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  /// Get wishlist collection reference
  CollectionReference get _wishlistCollection => _firestore.collection('wishlist');

  /// Add to wishlist
  Future<bool> addToWishlist(String laptopId) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        print('❌ User not logged in');
        return false;
      }

      print('❤️ Adding to wishlist for user: ${user.uid}');

      // Check if already in wishlist
      final existing = await _wishlistCollection
          .where('userId', isEqualTo: user.uid)
          .where('laptopId', isEqualTo: laptopId)
          .get();

      if (existing.docs.isEmpty) {
        await _wishlistCollection.add({
          'userId': user.uid,
          'laptopId': laptopId,
          'addedAt': FieldValue.serverTimestamp(),
        });

        print('✅ Added to wishlist');
        return true;
      }

      print('ℹ️ Already in wishlist');
      return false;
    } catch (e) {
      print('❌ Error adding to wishlist: $e');
      return false;
    }
  }

  /// Remove from wishlist
  Future<bool> removeFromWishlist(String laptopId) async {
    if (_userId == null) return false;

    try {
      final snapshot = await _wishlistCollection
          .where('userId', isEqualTo: _userId)
          .where('laptopId', isEqualTo: laptopId)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('✅ Removed from wishlist');
      return true;
    } catch (e) {
      print('❌ Error removing from wishlist: $e');
      return false;
    }
  }

  /// Toggle wishlist
  Future<bool> toggleWishlist(String laptopId) async {
    final isInWishlist = await this.isInWishlist(laptopId);
    
    if (isInWishlist) {
      return await removeFromWishlist(laptopId);
    } else {
      return await addToWishlist(laptopId);
    }
  }

  /// Check if in wishlist
  Future<bool> isInWishlist(String laptopId) async {
    if (_userId == null) return false;

    try {
      final snapshot = await _wishlistCollection
          .where('userId', isEqualTo: _userId)
          .where('laptopId', isEqualTo: laptopId)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get wishlist stream
  Stream<List<String>> getWishlistIdsStream() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _wishlistCollection
        .where('userId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['laptopId'] as String)
          .toList();
    });
  }

  /// Get wishlist items with laptop details
  Stream<List<LaptopModel>> getWishlistItemsStream() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _wishlistCollection
        .where('userId', isEqualTo: _userId)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<LaptopModel> items = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final laptopId = data['laptopId'] as String;

        final laptopDoc = await _firestore.collection('laptops').doc(laptopId).get();
        
        if (laptopDoc.exists) {
          final laptop = LaptopModel.fromMap(
            laptopDoc.data() as Map<String, dynamic>,
            laptopDoc.id,
          );
          items.add(laptop);
        }
      }

      return items;
    });
  }

  /// Get wishlist items (one-time fetch)
  Future<List<LaptopModel>> getWishlistItems() async {
    if (_userId == null) return [];

    try {
      final snapshot = await _wishlistCollection
          .where('userId', isEqualTo: _userId)
          .orderBy('addedAt', descending: true)
          .get();

      List<LaptopModel> items = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final laptopId = data['laptopId'] as String;

        final laptopDoc = await _firestore.collection('laptops').doc(laptopId).get();
        
        if (laptopDoc.exists) {
          final laptop = LaptopModel.fromMap(
            laptopDoc.data() as Map<String, dynamic>,
            laptopDoc.id,
          );
          items.add(laptop);
        }
      }

      return items;
    } catch (e) {
      print('❌ Error getting wishlist items: $e');
      return [];
    }
  }

  /// Get wishlist count
  Future<int> getWishlistCount() async {
    if (_userId == null) return 0;

    try {
      final snapshot = await _wishlistCollection
          .where('userId', isEqualTo: _userId)
          .get();

      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  /// Get wishlist count stream
  Stream<int> getWishlistCountStream() {
    if (_userId == null) {
      return Stream.value(0);
    }

    return _wishlistCollection
        .where('userId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// Clear wishlist
  Future<bool> clearWishlist() async {
    if (_userId == null) return false;

    try {
      final snapshot = await _wishlistCollection
          .where('userId', isEqualTo: _userId)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('✅ Wishlist cleared');
      return true;
    } catch (e) {
      print('❌ Error clearing wishlist: $e');
      return false;
    }
  }
}
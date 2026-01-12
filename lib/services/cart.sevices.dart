// // lib/services/cart_service.dart

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:laptop_harbor/models/cart_item_model.dart';
// // import 'package:laptop_harbor/models/cart_model.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:laptop_harbor/services/firestore_service.dart';

// class CartService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirestoreService _firestoreService = FirestoreService();

//   String? get _userId => _auth.currentUser?.uid;

//   /// Get cart collection reference
//   CollectionReference get _cartCollection => _firestore.collection('cart');

//   /// Add item to cart
//   Future<bool> addToCart(LaptopModel laptop, {int quantity = 1}) async {
//     if (_userId == null) {
//       print('❌ User not logged in');
//       return false;
//     }

//     try {
//       // Check if item already exists in cart
//       final existingQuery = await _cartCollection
//           .where('userId', isEqualTo: _userId)
//           .where('laptopId', isEqualTo: laptop.id)
//           .get();

//       if (existingQuery.docs.isNotEmpty) {
//         // Update quantity
//         final doc = existingQuery.docs.first;
//         final currentQty = (doc.data() as Map<String, dynamic>)['quantity'] ?? 0;
        
//         await doc.reference.update({
//           'quantity': currentQty + quantity,
//           'updatedAt': FieldValue.serverTimestamp(),
//         });
        
//         print('✅ Cart quantity updated');
//       } else {
//         // Add new item
//         await _cartCollection.add({
//           'userId': _userId,
//           'laptopId': laptop.id,
//           'quantity': quantity,
//           'price': laptop.price,
//           'addedAt': FieldValue.serverTimestamp(),
//           'updatedAt': FieldValue.serverTimestamp(),
//         });
        
//         print('✅ Item added to cart');
//       }

//       return true;
//     } catch (e) {
//       print('❌ Error adding to cart: $e');
//       return false;
//     }
//   }

//   /// Get cart items stream
//   Stream<List<CartItem>> getCartStream() {
//     if (_userId == null) {
//       return Stream.value([]);
//     }

//     return _cartCollection
//         .where('userId', isEqualTo: _userId)
//         .orderBy('addedAt', descending: true)
//         .snapshots()
//         .asyncMap((snapshot) async {
//       List<CartItem> items = [];

//       for (var doc in snapshot.docs) {
//         final data = doc.data() as Map<String, dynamic>;
//         final laptopId = data['laptopId'] as String;

//         // Fetch laptop details
//         final laptopDoc = await _firestore.collection('laptops').doc(laptopId).get();
        
//         if (laptopDoc.exists) {
//           final laptop = LaptopModel.fromMap(
//             laptopDoc.data() as Map<String, dynamic>,
//             laptopDoc.id,
//           );
          
//           items.add(CartItem.fromFirestore(doc, laptop));
//         }
//       }

//       return items;
//     });
//   }

//   /// Get cart items (one-time fetch)
//   Future<List<CartItem>> getCartItems() async {
//     if (_userId == null) return [];

//     try {
//       final snapshot = await _cartCollection
//           .where('userId', isEqualTo: _userId)
//           .orderBy('addedAt', descending: true)
//           .get();

//       List<CartItem> items = [];

//       for (var doc in snapshot.docs) {
//         final data = doc.data() as Map<String, dynamic>;
//         final laptopId = data['laptopId'] as String;

//         final laptopDoc = await _firestore.collection('laptops').doc(laptopId).get();
        
//         if (laptopDoc.exists) {
//           final laptop = LaptopModel.fromMap(
//             laptopDoc.data() as Map<String, dynamic>,
//             laptopDoc.id,
//           );
          
//           items.add(CartItem.fromFirestore(doc, laptop));
//         }
//       }

//       return items;
//     } catch (e) {
//       print('❌ Error getting cart items: $e');
//       return [];
//     }
//   }

//   /// Update quantity
//   Future<bool> updateQuantity(String cartItemId, int quantity) async {
//     if (_userId == null) return false;

//     try {
//       if (quantity <= 0) {
//         return await removeFromCart(cartItemId);
//       }

//       await _cartCollection.doc(cartItemId).update({
//         'quantity': quantity,
//         'updatedAt': FieldValue.serverTimestamp(),
//       });

//       print('✅ Quantity updated');
//       return true;
//     } catch (e) {
//       print('❌ Error updating quantity: $e');
//       return false;
//     }
//   }

//   /// Remove item from cart
//   Future<bool> removeFromCart(String cartItemId) async {
//     if (_userId == null) return false;

//     try {
//       await _cartCollection.doc(cartItemId).delete();
//       print('✅ Item removed from cart');
//       return true;
//     } catch (e) {
//       print('❌ Error removing from cart: $e');
//       return false;
//     }
//   }

//   /// Clear entire cart
//   Future<bool> clearCart() async {
//     if (_userId == null) return false;

//     try {
//       final snapshot = await _cartCollection
//           .where('userId', isEqualTo: _userId)
//           .get();

//       for (var doc in snapshot.docs) {
//         await doc.reference.delete();
//       }

//       print('✅ Cart cleared');
//       return true;
//     } catch (e) {
//       print('❌ Error clearing cart: $e');
//       return false;
//     }
//   }

//   /// Get cart count
//   Future<int> getCartCount() async {
//     if (_userId == null) return 0;

//     try {
//       final snapshot = await _cartCollection
//           .where('userId', isEqualTo: _userId)
//           .get();

//       return snapshot.docs.length;
//     } catch (e) {
//       print('❌ Error getting cart count: $e');
//       return 0;
//     }
//   }

//   /// Get cart count stream
//   Stream<int> getCartCountStream() {
//     if (_userId == null) {
//       return Stream.value(0);
//     }

//     return _cartCollection
//         .where('userId', isEqualTo: _userId)
//         .snapshots()
//         .map((snapshot) => snapshot.docs.length);
//   }

//   /// Calculate total
//   Future<double> getCartTotal() async {
//     final items = await getCartItems();
//     // ignore: avoid_types_as_parameter_names
//     return items.fold(0.0, (sum, item) => sum = item.totalPrice);
//   }

//   /// Check if item is in cart
//   Future<bool> isInCart(String laptopId) async {
//     if (_userId == null) return false;

//     try {
//       final snapshot = await _cartCollection
//           .where('userId', isEqualTo: _userId)
//           .where('laptopId', isEqualTo: laptopId)
//           .get();

//       return snapshot.docs.isNotEmpty;
//     } catch (e) {
//       return false;
//     }
//   }
// }

// extension on FutureOr<double> {
//   // FutureOr<double> operator + (double other) {}
// }

// lib/services/cart_service.dart

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_harbor/models/laptop_model.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Add item to cart - COMPLETELY FIXED
  Future<bool> addToCart(LaptopModel laptop, {int quantity = 1}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('❌ No user logged in');
        return false;
      }

      // ✅ VALIDATE laptop data
      if (laptop.id.isEmpty) {
        print('❌ Laptop ID is empty!');
        return false;
      }

      if (laptop.price <= 0) {
        print('❌ Invalid laptop price: ${laptop.price}');
        return false;
      }

      print('🛒 ADDING TO CART:');
      print('   User: ${user.uid}');
      print('   Laptop ID: ${laptop.id}');
      print('   Laptop Name: ${laptop.name}');
      print('   Price: ${laptop.price}');

      // Create cart data
      final cartData = {
        'userId': user.uid,
        'laptopId': laptop.id,
        'quantity': quantity,
        'price': laptop.price,
        'addedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      print('📦 Cart Data to save: $cartData');

      // Save to Firestore
      await _firestore.collection('cart').add(cartData);
      
      print('✅ SUCCESS: Item added to cart');
      return true;
      
    } catch (e) {
      print('❌ FATAL ERROR adding to cart: $e');
      return false;
    }
  }

  /// Get cart items - SIMPLIFIED
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    try {
      final snapshot = await _firestore
          .collection('cart')
          .where('userId', isEqualTo: user.uid)
          .get();

      List<Map<String, dynamic>> items = [];
      
      for (var doc in snapshot.docs) {
        final data = doc.data();
        items.add({
          'id': doc.id,
          ...data,
        });
      }
      
      return items;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
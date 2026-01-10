// // lib/services/firestore_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'dart:io';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   // Collection reference
//   CollectionReference get laptopsCollection => _firestore.collection('laptops');

//   // ✅ CREATE - New Product Add
//   Future<String> addProduct(LaptopModel laptop, {File? imageFile}) async {
//     debugPrint('🚀 Starting product upload...');
//     debugPrint('📝 Product Name: ${laptop.name}');
//     debugPrint('💰 Price: ₹${laptop.price}');
    
//     try {
//       // Upload image if exists
//       String? imageUrl = laptop.imageUrl;
//       if (imageFile != null) {
//         debugPrint('🖼️ Uploading image...');
//         imageUrl = await uploadImage(imageFile);
//         debugPrint('✅ Image uploaded: $imageUrl');
//       }

//       final laptopWithImage = laptop.copyWith(imageUrl: imageUrl);
      
//       // Convert to map with createdAt timestamp
//       final laptopData = laptopWithImage.toMap();
//       laptopData['createdAt'] = FieldValue.serverTimestamp();
      
//       debugPrint('📤 Adding to Firestore...');
//       final docRef = await laptopsCollection.add(laptopData);
//       debugPrint('✅ Document created with ID: ${docRef.id}');
      
//       // Update with document ID
//       await laptopsCollection.doc(docRef.id).update({'id': docRef.id});
//       debugPrint('🆔 Document ID updated');
      
//       debugPrint('🎉 Product uploaded successfully!');
//       return docRef.id;
//     } catch (e) {
//       debugPrint('❌ Error uploading product: $e');
//       debugPrint('🔍 Error details: $e');
//       throw Exception('Failed to add product: $e');
//     }
//   }

//   // ✅ READ - Get All Products
//   Stream<List<LaptopModel>> getProducts() {
//     debugPrint('📖 Fetching products from database...');
//     return laptopsCollection
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//           debugPrint('📊 Total documents: ${snapshot.docs.length}');
//           return snapshot.docs
//               .map((doc) => LaptopModel.fromFirestore(doc))
//               .toList();
//         });
//   }

//   // ✅ READ - Get Single Product
//   Future<LaptopModel?> getProduct(String id) async {
//     try {
//       final doc = await laptopsCollection.doc(id).get();
//       if (doc.exists) {
//         return LaptopModel.fromFirestore(doc);
//       }
//       return null;
//     } catch (e) {
//       debugPrint('❌ Error getting product: $e');
//       return null;
//     }
//   }

//   // ✅ UPDATE - Edit Product
//   Future<void> updateProduct(String id, LaptopModel laptop, {File? imageFile}) async {
//     debugPrint('🔄 Updating product: $id');
//     debugPrint('📝 Product Name: ${laptop.name}');
    
//     try {
//       String? imageUrl = laptop.imageUrl;
//       if (imageFile != null) {
//         debugPrint('🖼️ Uploading new image...');
//         imageUrl = await uploadImage(imageFile);
//         debugPrint('✅ New image uploaded: $imageUrl');
//       }

//       final laptopWithImage = laptop.copyWith(
//         id: id,
//         imageUrl: imageUrl,
//       );

//       final updateData = laptopWithImage.toMap();
//       updateData['updatedAt'] = FieldValue.serverTimestamp();
      
//       await laptopsCollection.doc(id).update(updateData);
//       debugPrint('✅ Product updated successfully!');
//     } catch (e) {
//       debugPrint('❌ Error updating product: $e');
//       throw Exception('Failed to update product: $e');
//     }
//   }

//   // ✅ DELETE - Remove Product
//   Future<void> deleteProduct(String id) async {
//     debugPrint('🗑️ Deleting product: $id');
    
//     try {
//       await laptopsCollection.doc(id).delete();
//       debugPrint('✅ Product deleted successfully!');
//     } catch (e) {
//       debugPrint('❌ Error deleting product: $e');
//       throw Exception('Failed to delete product: $e');
//     }
//   }

//   // Upload Image to Firebase Storage
//   Future<String> uploadImage(File imageFile) async {
//     try {
//       final fileName = 'products/${DateTime.now().millisecondsSinceEpoch}.jpg';
//       final ref = _storage.ref().child(fileName);
//       await ref.putFile(imageFile);
//       final downloadUrl = await ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       debugPrint('❌ Error uploading image: $e');
//       throw Exception('Failed to upload image: $e');
//     }
//   }

//   // Get Products by Category
//   Stream<List<LaptopModel>> getProductsByCategory(String category) {
//     return laptopsCollection
//         .where('category', isEqualTo: category)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => LaptopModel.fromFirestore(doc))
//             .toList());
//   }

//   // Get Hot Deals
//   Stream<List<LaptopModel>> getHotDeals() {
//     return laptopsCollection
//         .where('isHotDeal', isEqualTo: true)
//         .limit(6)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => LaptopModel.fromFirestore(doc))
//             .toList());
//   }

//   // Get New Arrivals
//   Stream<List<LaptopModel>> getNewArrivals() {
//     return laptopsCollection
//         .where('isNewArrival', isEqualTo: true)
//         .limit(6)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => LaptopModel.fromFirestore(doc))
//             .toList());
//   }

//   // Get Most Sale Products
//   Stream<List<LaptopModel>> getMostSale() {
//     return laptopsCollection
//         .where('isMostSale', isEqualTo: true)
//         .limit(6)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => LaptopModel.fromFirestore(doc))
//             .toList());
//   }

//   // Get Products Count
//   Future<int> getProductsCount() async {
//     try {
//       final snapshot = await laptopsCollection.count().get();
//       return snapshot.count ?? 0; // ✅ Fixed: provide default value
//     } catch (e) {
//       debugPrint('❌ Error getting products count: $e');
//       return 0;
//     }
//   }

//   // Check if product exists
//   Future<bool> productExists(String id) async {
//     try {
//       final doc = await laptopsCollection.doc(id).get();
//       return doc.exists;
//     } catch (e) {
//       debugPrint('❌ Error checking product existence: $e');
//       return false;
//     }
//   }

//   // Search Products by name
//   Stream<List<LaptopModel>> searchProducts(String query) {
//     if (query.isEmpty) {
//       return getProducts();
//     }
    
//     return laptopsCollection
//         .where('name', isGreaterThanOrEqualTo: query)
//         .where('name', isLessThanOrEqualTo: '$query\uf8ff')
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => LaptopModel.fromFirestore(doc))
//             .toList());
//   }

//   // Get Featured Products
//   Stream<List<LaptopModel>> getFeaturedProducts() {
//     return laptopsCollection
//         .where('isHotDeal', isEqualTo: true)
//         .or(
//           where('isNewArrival', isEqualTo: true),
//           where('isMostSale', isEqualTo: true),
//         )
//         .limit(10)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => LaptopModel.fromFirestore(doc))
//             .toList());
//   }

//   // Bulk operations
//   Future<void> addMultipleProducts(List<LaptopModel> products) async {
//     final batch = _firestore.batch();
    
//     for (var laptop in products) {
//       final docRef = laptopsCollection.doc();
//       final laptopData = laptop.toMap();
//       laptopData['id'] = docRef.id;
//       laptopData['createdAt'] = FieldValue.serverTimestamp();
      
//       batch.set(docRef, laptopData);
//     }
    
//     await batch.commit();
//     debugPrint('✅ ${products.length} products added successfully!');
//   }

//   // Clear all products (use with caution)
//   Future<void> clearAllProducts() async {
//     final snapshot = await laptopsCollection.get();
//     final batch = _firestore.batch();
    
//     for (var doc in snapshot.docs) {
//       batch.delete(doc.reference);
//     }
    
//     await batch.commit();
//     debugPrint('🗑️ All products cleared!');
//   }
// }

// extension on Query<Object?> {
//   or(where, where2) {}
// }

// where(String s, {required bool isEqualTo}) {
// }
// lib/services/firestore_service.dart








// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:uuid/uuid.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final String collectionName = 'laptops';

//   /// Add Product
//   /// If [imageFile] is provided, upload it to Firebase Storage
//   Future<String> addProduct(LaptopModel laptop, {File? imageFile}) async {
//     try {
//       String productId = const Uuid().v4();

//       String imageUrl = laptop.imageUrl;

//       if (imageFile != null) {
//         final ref = _storage.ref().child('products/$productId.jpg');
//         await ref.putFile(imageFile);
//         imageUrl = await ref.getDownloadURL();
//       }

//       final laptopData = laptop.copyWith(id: productId, imageUrl: imageUrl).toMap();

//       await _firestore.collection(collectionName).doc(productId).set(laptopData);

//       return productId;
//     } catch (e) {
//       throw Exception('Failed to add product: $e');
//     }
//   }

//   /// Update Product
//   /// If [imageFile] is provided, replace existing image in Storage
//   Future<void> updateProduct(String productId, LaptopModel laptop,
//       {File? imageFile}) async {
//     try {
//       String imageUrl = laptop.imageUrl;

//       if (imageFile != null) {
//         // Delete old image if exists
//         if (laptop.imageUrl.isNotEmpty &&
//             !laptop.imageUrl.contains('placeholder.com')) {
//           try {
//             final oldRef = _storage.refFromURL(laptop.imageUrl);
//             await oldRef.delete();
//           } catch (_) {}
//         }

//         final ref = _storage.ref().child('products/$productId.jpg');
//         await ref.putFile(imageFile);
//         imageUrl = await ref.getDownloadURL();
//       }

//       final laptopData = laptop.copyWith(imageUrl: imageUrl, id: '').toMap();

//       await _firestore.collection(collectionName).doc(productId).update(laptopData);
//     } catch (e) {
//       throw Exception('Failed to update product: $e');
//     }
//   }

//   /// Delete Product
//   /// Also deletes image from Storage if exists
//   Future<void> deleteProduct(String productId) async {
//     try {
//       final doc = await _firestore.collection(collectionName).doc(productId).get();

//       if (doc.exists) {
//         final data = doc.data()!;
//         final imageUrl = data['imageUrl'] as String? ?? '';

//         if (imageUrl.isNotEmpty && !imageUrl.contains('placeholder.com')) {
//           try {
//             final ref = _storage.refFromURL(imageUrl);
//             await ref.delete();
//           } catch (_) {}
//         }

//         await _firestore.collection(collectionName).doc(productId).delete();
//       }
//     } catch (e) {
//       throw Exception('Failed to delete product: $e');
//     }
//   }

//   /// Fetch all products
//   Future<List<LaptopModel>> getProducts() async {
//     try {
//       final snapshot = await _firestore.collection(collectionName).get();
//       return snapshot.docs
//           .map((doc) => LaptopModel.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to fetch products: $e');
//     }
//   }

//   /// Fetch single product by ID
//   Future<LaptopModel?> getProductById(String productId) async {
//     try {
//       final doc = await _firestore.collection(collectionName).doc(productId).get();
//       if (doc.exists) {
//         return LaptopModel.fromMap(doc.data()!);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Failed to fetch product: $e');
//     }
//   }
// }
// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/laptop_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get laptops collection reference
  CollectionReference get _laptopsCollection => _firestore.collection('laptops');

  // ==================== FETCH ALL LAPTOPS ====================
  /// Fetch all laptops from Firestore (Real-time Stream)
  Stream<List<LaptopModel>> getLaptopsStream() {
    return _laptopsCollection
        .snapshots(includeMetadataChanges: false) // Force server data
        .map((snapshot) => snapshot.docs
            .map((doc) => LaptopModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ))
            .toList());
  }

  /// Fetch all laptops (One-time fetch from SERVER)
  Future<List<LaptopModel>> getAllLaptops() async {
    try {
      // Force fetch from server, not cache
      final snapshot = await _laptopsCollection
          .get(const GetOptions(source: Source.server));
      
      print('🔥 Fetched ${snapshot.docs.length} laptops from SERVER');
      
      return snapshot.docs
          .map((doc) => LaptopModel.fromMap(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();
    } catch (e) {
      print('❌ Error fetching laptops: $e');
      return [];
    }
  }

  // ==================== FETCH BY CATEGORY ====================
  Stream<List<LaptopModel>> getLaptopsByCategory(String category) {
    return _laptopsCollection
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LaptopModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ))
            .toList());
  }

  // ==================== FETCH FEATURED LAPTOPS ====================
  Stream<List<LaptopModel>> getFeaturedLaptops() {
    return _laptopsCollection
        .where('isHotDeal', isEqualTo: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LaptopModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ))
            .toList());
  }

  // ==================== FETCH HOT DEALS ====================
  Stream<List<LaptopModel>> getHotDeals() {
    return _laptopsCollection
        .where('isHotDeal', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LaptopModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ))
            .toList());
  }

  // ==================== FETCH MOST SALE ====================
  Stream<List<LaptopModel>> getMostSale() {
    return _laptopsCollection
        .where('isMostSale', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LaptopModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ))
            .toList());
  }

  // ==================== FETCH NEW ARRIVALS ====================
  Stream<List<LaptopModel>> getNewArrivals() {
    return _laptopsCollection
        .where('isNewArrival', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LaptopModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ))
            .toList());
  }

  // ==================== SEARCH LAPTOPS ====================
  Future<List<LaptopModel>> searchLaptops(String query) async {
    try {
      final snapshot = await _laptopsCollection
          .get(const GetOptions(source: Source.server));
      
      final lowercaseQuery = query.toLowerCase();
      
      return snapshot.docs
          .map((doc) => LaptopModel.fromMap(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .where((laptop) =>
              laptop.name.toLowerCase().contains(lowercaseQuery) ||
              laptop.brand.toLowerCase().contains(lowercaseQuery) ||
              laptop.processor.toLowerCase().contains(lowercaseQuery))
          .toList();
    } catch (e) {
      print('❌ Error searching laptops: $e');
      return [];
    }
  }

  // ==================== ADD LAPTOP ====================
  Future<String?> addLaptop(LaptopModel laptop) async {
    try {
      final docRef = await _laptopsCollection.add(laptop.toMap());
      print('✅ Laptop added successfully with ID: ${docRef.id}');
      
      // Clear cache after adding
      await _firestore.clearPersistence();
      
      return docRef.id;
    } catch (e) {
      print('❌ Error adding laptop: $e');
      return null;
    }
  }

  // ==================== UPDATE LAPTOP ====================
  Future<bool> updateLaptop(String id, LaptopModel laptop) async {
    try {
      await _laptopsCollection.doc(id).update(laptop.toMap());
      print('✅ Laptop updated successfully');
      
      // Clear cache after updating
      await _firestore.clearPersistence();
      
      return true;
    } catch (e) {
      print('❌ Error updating laptop: $e');
      return false;
    }
  }

  // ==================== DELETE LAPTOP ====================
  Future<bool> deleteLaptop(String id) async {
    try {
      await _laptopsCollection.doc(id).delete();
      print('✅ Laptop deleted successfully');
      
      // Clear cache after deleting
      await _firestore.clearPersistence();
      
      return true;
    } catch (e) {
      print('❌ Error deleting laptop: $e');
      return false;
    }
  }

  // ==================== CLEAR CACHE ====================
  Future<void> clearCache() async {
    try {
      await _firestore.clearPersistence();
      print('✅ Firestore cache cleared');
    } catch (e) {
      print('❌ Error clearing cache: $e');
    }
  }

  // ==================== FORCE REFRESH ====================
  Future<void> forceRefresh() async {
    try {
      await _firestore.terminate();
      await _firestore.clearPersistence();
      print('✅ Firestore refreshed');
    } catch (e) {
      print('❌ Error refreshing Firestore: $e');
    }
  }
}
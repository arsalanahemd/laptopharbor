// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/wishlist_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/laptop_model.dart';

// class WishlistProvider with ChangeNotifier {
//   List<WishlistItem> _items = [];
  
//   List<WishlistItem> get items => List.unmodifiable(_items);
//   int get wishlistCount => _items.length;

//   static const String _storageKey = 'wishlist_data';

//   WishlistProvider() {
//     _loadFromStorage();
//   }

//   Future<void> _loadFromStorage() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final jsonString = prefs.getString(_storageKey);
      
//       if (jsonString != null && jsonString.isNotEmpty) {
//         final List<dynamic> jsonList = json.decode(jsonString);
//         _items = jsonList.map((json) => WishlistItem.fromJson(json)).toList();
//         notifyListeners();
//       }
//     } catch (e) {
//       print('Error loading wishlist: $e');
//     }
//   }

//   Future<void> _saveToStorage() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final jsonString = json.encode(_items.map((item) => item.toJson()).toList());
//       await prefs.setString(_storageKey, jsonString);
//     } catch (e) {
//       print('Error saving wishlist: $e');
//     }
//   }

//   Future<void> toggleWishlist(LaptopModel laptop) async {
//     try {
//       final existingIndex = _items.indexWhere((item) => item.laptop.id == laptop.id);
      
//       if (existingIndex >= 0) {
//         // Remove from wishlist
//         _items.removeAt(existingIndex);
//         print('✅ Removed from wishlist: ${laptop.name}');
//       } else {
//         // Add to wishlist
//         final newItem = WishlistItem(
//           id: DateTime.now().millisecondsSinceEpoch.toString(),
//           laptopId: laptop.id,
//           userId: 'current_user',
//           laptop: laptop,
//           addedAt: DateTime.now(),
//         );
        
//         _items.add(newItem);
//         print('✅ Added to wishlist: ${laptop.name}');
//       }
      
//       await _saveToStorage();
//       notifyListeners();
      
//     } catch (e) {
//       print('❌ Error toggling wishlist: $e');
//     }
//   }

//   bool isInWishlist(String laptopId) {
//     return _items.any((item) => item.laptop.id == laptopId);
//   }

//   Future<void> removeFromWishlist(String laptopId) async {
//     _items.removeWhere((item) => item.laptop.id == laptopId);
//     await _saveToStorage();
//     notifyListeners();
//   }

//   Future<void> clearWishlist() async {
//     _items.clear();
//     await _saveToStorage();
//     notifyListeners();
//   }
// }
// lib/providers/wishlist_provider.dart

// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/services/wishlist_service.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();
  List<String> _wishlistIds = [];
  bool _isLoading = false;
  StreamSubscription<List<String>>? _wishlistSubscription;

  List<String> get wishlistIds => List.unmodifiable(_wishlistIds);
  bool get isLoading => _isLoading;
  int get count => _wishlistIds.length;

  WishlistProvider() {
    _loadWishlistIds();
  }

  @override
  void dispose() {
    _wishlistSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadWishlistIds() async {
    _isLoading = true;
    notifyListeners();

    try {
      _wishlistSubscription?.cancel();
      
      _wishlistSubscription = _wishlistService.getWishlistIdsStream().listen(
        (List<String> ids) {
          _wishlistIds = ids; // ✅ NULL CHECK
          _isLoading = false;
          notifyListeners();
        },
        onError: (error) {
          print('❌ Error in wishlist stream: $error');
          _wishlistIds = [];
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      print('❌ Error loading wishlist: $e');
      _wishlistIds = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleWishlist(String laptopId) async {
    try {
      if (laptopId.isEmpty) return false; // ✅ NULL/EMPTY CHECK
      
      bool success = await _wishlistService.toggleWishlist(laptopId);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      print('❌ Error toggling wishlist: $e');
      return false;
    }
  }

  Future<bool> addToWishlist(String laptopId) async {
    try {
      if (laptopId.isEmpty) return false; // ✅ NULL/EMPTY CHECK
      
      bool success = await _wishlistService.addToWishlist(laptopId);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      print('❌ Error adding to wishlist: $e');
      return false;
    }
  }

  Future<bool> removeFromWishlist(String laptopId) async {
    try {
      if (laptopId.isEmpty) return false; // ✅ NULL/EMPTY CHECK
      
      bool success = await _wishlistService.removeFromWishlist(laptopId);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      print('❌ Error removing from wishlist: $e');
      return false;
    }
  }

  bool isInWishlist(String laptopId) {
    if (laptopId.isEmpty) return false; // ✅ NULL/EMPTY CHECK
    return _wishlistIds.contains(laptopId);
  }

  Future<void> clearWishlist() async {
    try {
      await _wishlistService.clearWishlist();
      _wishlistIds = [];
      notifyListeners();
    } catch (e) {
      print('❌ Error clearing wishlist: $e');
    }
  }

  Stream<List<LaptopModel>> get wishlistItemsStream {
    return _wishlistService.getWishlistItemsStream();
  }

  Null get items => null;

  Future<List<LaptopModel>> getWishlistItems() async {
    try {
      return await _wishlistService.getWishlistItems();
    } catch (e) {
      print('❌ Error getting wishlist items: $e');
      return [];
    }
  }
}
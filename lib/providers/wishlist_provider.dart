// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/wishlist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/laptop_model.dart';

class WishlistProvider with ChangeNotifier {
  List<WishlistItem> _items = [];
  
  List<WishlistItem> get items => List.unmodifiable(_items);
  int get wishlistCount => _items.length;

  static const String _storageKey = 'wishlist_data';

  WishlistProvider() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        _items = jsonList.map((json) => WishlistItem.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading wishlist: $e');
    }
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(_items.map((item) => item.toJson()).toList());
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      print('Error saving wishlist: $e');
    }
  }

  Future<void> toggleWishlist(LaptopModel laptop) async {
    try {
      final existingIndex = _items.indexWhere((item) => item.laptop.id == laptop.id);
      
      if (existingIndex >= 0) {
        // Remove from wishlist
        _items.removeAt(existingIndex);
        print('✅ Removed from wishlist: ${laptop.name}');
      } else {
        // Add to wishlist
        final newItem = WishlistItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          laptopId: laptop.id,
          userId: 'current_user',
          laptop: laptop,
          addedAt: DateTime.now(),
        );
        
        _items.add(newItem);
        print('✅ Added to wishlist: ${laptop.name}');
      }
      
      await _saveToStorage();
      notifyListeners();
      
    } catch (e) {
      print('❌ Error toggling wishlist: $e');
    }
  }

  bool isInWishlist(String laptopId) {
    return _items.any((item) => item.laptop.id == laptopId);
  }

  Future<void> removeFromWishlist(String laptopId) async {
    _items.removeWhere((item) => item.laptop.id == laptopId);
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> clearWishlist() async {
    _items.clear();
    await _saveToStorage();
    notifyListeners();
  }
}
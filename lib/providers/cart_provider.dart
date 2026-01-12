// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';
import '../models/laptop_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  
  List<CartItem> get items => List.unmodifiable(_items);
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  int get cartCount => _items.length;

  static const String _storageKey = 'cart_data';

  CartProvider() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        _items = jsonList.map((json) => CartItem.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(_items.map((item) => item.toJson()).toList());
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  Future<void> addToCart(LaptopModel laptop, {int quantity = 1}) async {
    try {
      print('🛒 Adding to cart: ${laptop.name} (${laptop.id})');
      
      final existingIndex = _items.indexWhere((item) => item.laptop.id == laptop.id);
      
      if (existingIndex >= 0) {
        // Update quantity
        final oldItem = _items[existingIndex];
        _items[existingIndex] = oldItem.copyWith(
          quantity: oldItem.quantity + quantity,
        );
        print('✅ Updated quantity to ${_items[existingIndex].quantity}');
      } else {
        // Add new item
        final newItem = CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          laptopId: laptop.id,
          userId: 'current_user', // Replace with actual user ID if needed
          laptop: laptop,
          quantity: quantity,
          price: laptop.price,
          addedAt: DateTime.now(),
        );
        
        _items.add(newItem);
        print('✅ Added new item. Total items: ${_items.length}');
      }
      
      await _saveToStorage();
      notifyListeners();
      
    } catch (e) {
      print('❌ Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(String laptopId) async {
    _items.removeWhere((item) => item.laptop.id == laptopId);
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> updateQuantity(String laptopId, int quantity) async {
    final index = _items.indexWhere((item) => item.laptop.id == laptopId);
    
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        final oldItem = _items[index];
        _items[index] = oldItem.copyWith(quantity: quantity);
      }
      
      await _saveToStorage();
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    _items.clear();
    await _saveToStorage();
    notifyListeners();
  }

  bool isInCart(String laptopId) {
    return _items.any((item) => item.laptop.id == laptopId);
  }

  int getQuantity(String laptopId) {
    final index = _items.indexWhere((item) => item.laptop.id == laptopId);
    return index >= 0 ? _items[index].quantity : 0;
  }
}
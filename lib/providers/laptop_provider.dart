// lib/providers/laptop_provider.dart

import 'package:flutter/material.dart';
import '../models/laptop_model.dart';
import '../services/firestore_service.dart';

class LaptopProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<LaptopModel> _laptops = [];
  List<LaptopModel> _filteredLaptops = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<LaptopModel> get laptops => _laptops;
  List<LaptopModel> get filteredLaptops => _filteredLaptops;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // ==================== FETCH ALL LAPTOPS ====================
  Future<void> fetchLaptops() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Force fetch from server, not cache
      _laptops = await _firestoreService.getAllLaptops();
      _filteredLaptops = _laptops;
      
      print('✅ Fetched ${_laptops.length} laptops');
    } catch (e) {
      _errorMessage = 'Error fetching laptops: $e';
      print('❌ $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==================== FORCE REFRESH ====================
  Future<void> forceRefresh() async {
    print('🔄 Force refreshing data...');
    
    // Clear cache first
    await _firestoreService.clearCache();
    
    // Then fetch fresh data
    await fetchLaptops();
  }

  // ==================== FILTER BY CATEGORY ====================
  void filterByCategory(String category) {
    if (category.isEmpty || category.toLowerCase() == 'all') {
      _filteredLaptops = _laptops;
    } else {
      _filteredLaptops = _laptops
          .where((laptop) => laptop.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    notifyListeners();
  }

  // ==================== SEARCH LAPTOPS ====================
  void searchLaptops(String query) {
    if (query.isEmpty) {
      _filteredLaptops = _laptops;
    } else {
      final lowercaseQuery = query.toLowerCase();
      _filteredLaptops = _laptops.where((laptop) {
        return laptop.name.toLowerCase().contains(lowercaseQuery) ||
            laptop.brand.toLowerCase().contains(lowercaseQuery) ||
            laptop.processor.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }
    notifyListeners();
  }

  // ==================== GET HOT DEALS ====================
  List<LaptopModel> getHotDeals() {
    return _laptops.where((laptop) => laptop.isHotDeal).toList();
  }

  // ==================== GET MOST SALE ====================
  List<LaptopModel> getMostSale() {
    return _laptops.where((laptop) => laptop.isMostSale).toList();
  }

  // ==================== GET NEW ARRIVALS ====================
  List<LaptopModel> getNewArrivals() {
    return _laptops.where((laptop) => laptop.isNewArrival).toList();
  }

  // ==================== ADD LAPTOP ====================
  Future<bool> addLaptop(LaptopModel laptop) async {
    try {
      final id = await _firestoreService.addLaptop(laptop);
      if (id != null) {
        // Force refresh after adding
        await forceRefresh();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = 'Error adding laptop: $e';
      print('❌ $_errorMessage');
      return false;
    }
  }

  // ==================== UPDATE LAPTOP ====================
  Future<bool> updateLaptop(String id, LaptopModel laptop) async {
    try {
      final success = await _firestoreService.updateLaptop(id, laptop);
      if (success) {
        // Force refresh after updating
        await forceRefresh();
      }
      return success;
    } catch (e) {
      _errorMessage = 'Error updating laptop: $e';
      print('❌ $_errorMessage');
      return false;
    }
  }

  // ==================== DELETE LAPTOP ====================
  Future<bool> deleteLaptop(String id) async {
    try {
      final success = await _firestoreService.deleteLaptop(id);
      if (success) {
        // Force refresh after deleting
        await forceRefresh();
      }
      return success;
    } catch (e) {
      _errorMessage = 'Error deleting laptop: $e';
      print('❌ $_errorMessage');
      return false;
    }
  }
}
 
// lib/pages/CategoriesPage.dart

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/services/firestore_service.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final FirestoreService _firestoreService = FirestoreService();
  
  String _selectedCategory = 'All';
  List<LaptopModel> _laptops = [];
  List<LaptopModel> _filteredLaptops = [];
  bool _isLoading = true;
  String _errorMessage = '';
  
  // Wishlist management
  final Set<String> _wishlist = {};

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.laptop},
    {'name': 'Gaming', 'icon': Icons.sports_esports},
    {'name': 'Business', 'icon': Icons.business_center},
    {'name': 'Student', 'icon': Icons.school},
    {'name': 'Premium', 'icon': Icons.diamond},
    {'name': 'Budget', 'icon': Icons.savings},
    {'name': 'Workstation', 'icon': Icons.work},
    {'name': 'Ultrabook', 'icon': Icons.laptop_chromebook},
  ];

  @override
  void initState() {
    super.initState();
    _loadLaptops();
  }

  Future<void> _loadLaptops() async {
    if (!mounted) return; // Check if widget is still mounted
    
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final laptops = await _firestoreService.getAllLaptops();
      
      if (!mounted) return; // Check again before setState
      
      setState(() {
        _laptops = laptops;
        _filterByCategory(_selectedCategory);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return; // Check again before setState
      
      setState(() {
        _errorMessage = 'Failed to load laptops: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    if (!mounted) return;
    
    await _firestoreService.clearCache();
    await _loadLaptops();
  }

  void _filterByCategory(String category) {
    if (!mounted) return; // Safety check
    
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredLaptops = _laptops;
      } else {
        _filteredLaptops = _laptops
            .where((laptop) => laptop.category == category)
            .toList();
      }
    });
  }

  void _toggleWishlist(String laptopId) {
    if (!mounted) return; // Safety check
    
    setState(() {
      if (_wishlist.contains(laptopId)) {
        _wishlist.remove(laptopId);
      } else {
        _wishlist.add(laptopId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _handleRefresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories Tabs
          Container(
            height: 100,
            color: Colors.grey[100],
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category['name'];
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () => _filterByCategory(category['name'] as String),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            color: isSelected ? Colors.white : Colors.grey[700],
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Products Grid
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading laptops...'),
          ],
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(_errorMessage),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _handleRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_filteredLaptops.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.laptop_chromebook,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No laptops in $_selectedCategory',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _filterByCategory('All'),
              child: const Text('View All Categories'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _filteredLaptops.length,
        itemBuilder: (context, index) {
          final laptop = _filteredLaptops[index];
          return LaptopCard(
            laptop: laptop,
            onFavorite: () {
              _toggleWishlist(laptop.id);
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaptopDetailScreen(laptop: laptop),
                ),
              );
            },
            // ✅ Required parameters
            isInWishlist: _wishlist.contains(laptop.id),
            showWishlistButton: true,
            onWishlistToggle: () {
              _toggleWishlist(laptop.id);
            },
          );
        },
      ),
    );
  }
}
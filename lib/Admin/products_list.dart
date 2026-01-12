// // lib/screens/admin/products_list.dart
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/Admin/product_form.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// // import 'package:laptop_harbor/screens/admin/product_form.dart';
// import 'package:laptop_harbor/services/firestore_service.dart';

// class ProductsListScreen extends StatelessWidget {
//   const ProductsListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final firestoreService = FirestoreService();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manage Products'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ProductFormScreen(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: StreamBuilder<List<LaptopModel>>(
//         stream: firestoreService.productsStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final products = snapshot.data ?? [];

//           if (products.isEmpty) {
//             return const Center(
//               child: Text('No products found. Add your first product!'),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: ListTile(
//                   leading: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       image: DecorationImage(
//                         image: NetworkImage(product.imageUrl),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   title: Text(product.name),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('₹${product.price.toStringAsFixed(0)}'),
//                       Row(
//                         children: [
//                           Chip(
//                             label: Text(product.category),
//                             backgroundColor: Colors.blue[50],
//                           ),
//                           if (product.isHotDeal)
//                             Padding(
//                               padding: const EdgeInsets.only(left: 4),
//                               child: Chip(
//                                 label: const Text('Hot Deal'),
//                                 backgroundColor: Colors.red[50],
//                                 labelStyle: const TextStyle(color: Colors.red),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   trailing: PopupMenuButton(
//                     itemBuilder: (context) => [
//                       const PopupMenuItem(
//                         value: 'edit',
//                         child: Row(
//                           children: [
//                             Icon(Icons.edit, size: 20),
//                             SizedBox(width: 8),
//                             Text('Edit'),
//                           ],
//                         ),
//                       ),
//                       const PopupMenuItem(
//                         value: 'delete',
//                         child: Row(
//                           children: [
//                             Icon(Icons.delete, size: 20, color: Colors.red),
//                             SizedBox(width: 8),
//                             Text('Delete', style: TextStyle(color: Colors.red)),
//                           ],
//                         ),
//                       ),
//                     ],
//                     onSelected: (value) async {
//                       if (value == 'edit') {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductFormScreen(
//                               product: product,
//                               isEditing: true,
//                             ),
//                           ),
//                         );
//                       } else if (value == 'delete') {
//                         final confirmed = await showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: const Text('Confirm Delete'),
//                             content: const Text(
//                                 'Are you sure you want to delete this product?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, false),
//                                 child: const Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, true),
//                                 child: const Text('Delete',
//                                     style: TextStyle(color: Colors.red)),
//                               ),
//                             ],
//                           ),
//                         );

//                         if (confirmed == true) {
//                           try {
//                             await firestoreService.deleteProduct(product.id);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Product deleted!')),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Error: ${e.toString()}')),
//                             );
//                           }
//                         }
//                       }
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// lib/Admin/products_list.dart

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:laptop_harbor/Admin/product_form.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/services/firestore_service.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<LaptopModel> _laptops = [];
  List<LaptopModel> _filteredLaptops = [];
  bool _isLoading = true;
  String _errorMessage = '';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadLaptops();
  }

  Future<void> _loadLaptops() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final laptops = await _firestoreService.getAllLaptops();
      setState(() {
        _laptops = laptops;
        _filteredLaptops = laptops;
        _isLoading = false;
      });
      
      print('✅ Loaded ${laptops.length} products');
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load products: $e';
        _isLoading = false;
      });
      print('❌ Error: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await _firestoreService.clearCache();
    await _loadLaptops();
  }

  void _searchProducts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredLaptops = _laptops;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredLaptops = _laptops.where((laptop) {
          return laptop.name.toLowerCase().contains(lowerQuery) ||
              laptop.brand.toLowerCase().contains(lowerQuery) ||
              laptop.category.toLowerCase().contains(lowerQuery);
        }).toList();
      }
    });
  }

  Future<void> _deleteLaptop(LaptopModel laptop) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${laptop.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await _firestoreService.deleteLaptop(laptop.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Product deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        _loadLaptops();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Failed to delete product'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _editLaptop(LaptopModel laptop) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductFormScreen(laptop: laptop),
      ),
    );

    if (result == true) {
      _loadLaptops();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
        actions: [
          IconButton(
            onPressed: _handleRefresh,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchProducts,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchProducts(''),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductFormScreen(),
            ),
          );
          
          if (result == true) {
            _loadLaptops();
          }
        },
        child: const Icon(Icons.add),
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
            Text('Loading products...'),
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
              _searchQuery.isEmpty ? Icons.inventory : Icons.search_off,
              size: 60,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No products found'
                  : 'No results for "$_searchQuery"',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductFormScreen(),
                  ),
                );
                
                if (result == true) {
                  _loadLaptops();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add First Product'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _filteredLaptops.length,
        itemBuilder: (context, index) {
          final laptop = _filteredLaptops[index];
          return _buildProductCard(laptop);
        },
      ),
    );
  }

  Widget _buildProductCard(LaptopModel laptop) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            laptop.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: const Icon(Icons.laptop, size: 30),
              );
            },
          ),
        ),
        title: Text(
          laptop.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${laptop.brand} • ${laptop.category}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '₹${laptop.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                if (laptop.discount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${laptop.discount.toStringAsFixed(0)}% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: [
                if (laptop.isHotDeal) _buildChip('🔥 Hot', Colors.orange),
                if (laptop.isMostSale) _buildChip('💰 Sale', Colors.green),
                if (laptop.isNewArrival) _buildChip('✨ New', Colors.blue),
                if (!laptop.inStock) _buildChip('Out', Colors.red),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              _editLaptop(laptop);
            } else if (value == 'delete') {
              _deleteLaptop(laptop);
            }
          },
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 10, color: Colors.white),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
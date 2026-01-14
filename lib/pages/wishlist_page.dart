// // lib/pages/wishlist_page.dart

// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// import 'package:laptop_harbor/services/cart.sevices.dart';
// // import 'package:laptop_harbor/services/cart_service.dart';
// import 'package:laptop_harbor/services/wishlist_service.dart';

// class WishlistPage extends StatefulWidget {
//   const WishlistPage({super.key});

//   @override
//   State<WishlistPage> createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage> {
//   final WishlistService _wishlistService = WishlistService();
//   final CartService _cartService = CartService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Wishlist'),
//         actions: [
//           StreamBuilder<int>(
//             stream: _wishlistService.getWishlistCountStream(),
//             builder: (context, snapshot) {
//               final count = snapshot.data ?? 0;
//               if (count == 0) return const SizedBox();
              
//               return TextButton.icon(
//                 onPressed: _showClearWishlistDialog,
//                 icon: const Icon(Icons.delete_outline, color: Colors.red),
//                 label: const Text('Clear', style: TextStyle(color: Colors.red)),
//               );
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder<List<LaptopModel>>(
//         stream: _wishlistService.getWishlistItemsStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 60, color: Colors.red),
//                   const SizedBox(height: 16),
//                   Text('Error: ${snapshot.error}'),
//                 ],
//               ),
//             );
//           }

//           final wishlistItems = snapshot.data ?? [];

//           if (wishlistItems.isEmpty) {
//             return _buildEmptyWishlist();
//           }

//           return GridView.builder(
//             padding: const EdgeInsets.all(16),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.65,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//             ),
//             itemCount: wishlistItems.length,
//             itemBuilder: (context, index) {
//               return _buildWishlistCard(wishlistItems[index]);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildEmptyWishlist() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
//           const SizedBox(height: 16),
//           Text(
//             'Your wishlist is empty',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Add items you love',
//             style: TextStyle(color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: () => Navigator.pop(context),
//             icon: const Icon(Icons.shopping_bag),
//             label: const Text('Start Shopping'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWishlistCard(LaptopModel laptop) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => LaptopDetailScreen(laptop: laptop),
//             ),
//           );
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image with remove button
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(12),
//                   ),
//                   child: Image.network(
//                     laptop.imageUrl,
//                     width: double.infinity,
//                     height: 140,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         width: double.infinity,
//                         height: 140,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.laptop, size: 50),
//                       );
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: 18,
//                     child: IconButton(
//                       icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
//                       onPressed: () => _removeFromWishlist(laptop),
//                       padding: EdgeInsets.zero,
//                     ),
//                   ),
//                 ),
//                 if (laptop.discount > 0)
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Text(
//                         '${laptop.discount.toStringAsFixed(0)}% OFF',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),

//             // Details
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       laptop.name,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       laptop.brand,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const Spacer(),
//                     Row(
//                       children: [
//                         Text(
//                           '₹${laptop.price.toStringAsFixed(0)}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                         if (laptop.originalPrice > laptop.price) ...[
//                           const SizedBox(width: 4),
//                           Text(
//                             '₹${laptop.originalPrice.toStringAsFixed(0)}',
//                             style: TextStyle(
//                               fontSize: 12,
//                               decoration: TextDecoration.lineThrough,
//                               color: Colors.grey[500],
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         onPressed: () => _addToCart(laptop),
//                         icon: const Icon(Icons.shopping_cart, size: 16),
//                         label: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _removeFromWishlist(LaptopModel laptop) async {
//     final success = await _wishlistService.removeFromWishlist(laptop.id);
    
//     if (success && mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('✅ ${laptop.name} removed from wishlist'),
//           backgroundColor: Colors.green,
//           action: SnackBarAction(
//             label: 'Undo',
//             textColor: Colors.white,
//             onPressed: () {
//               _wishlistService.addToWishlist(laptop.id);
//             },
//           ),
//         ),
//       );
//     }
//   }

//   Future<void> _addToCart(LaptopModel laptop) async {
//     final success = await _cartService.addToCart(laptop);
    
//     if (success && mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('✅ ${laptop.name} added to cart'),
//           backgroundColor: Colors.green,
//           action: SnackBarAction(
//             label: 'View Cart',
//             textColor: Colors.white,
//             onPressed: () {
//               // Navigate to cart
//             },
//           ),
//         ),
//       );
//     }
//   }

//   void _showClearWishlistDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Clear Wishlist'),
//         content: const Text('Are you sure you want to clear your wishlist?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               final success = await _wishlistService.clearWishlist();
              
//               if (success && mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('✅ Wishlist cleared'),
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: const Text('Clear'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// lib/pages/wishlist_page.dart
// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
import 'package:laptop_harbor/services/cart.sevices.dart';
import 'package:laptop_harbor/services/wishlist_service.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistService _wishlistService = WishlistService();
  final CartService _cartService = CartService();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  
  // Local state for immediate UI updates
  List<LaptopModel> _wishlistItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWishlistItems();
  }

  Future<void> _loadWishlistItems() async {
    setState(() => _isLoading = true);
    
    try {
      final items = await _wishlistService.getWishlistItems();
      setState(() {
        _wishlistItems = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackbar('Error loading wishlist: $e', backgroundColor: Colors.red);
    }
  }

  void _showSnackbar(String message, {Color backgroundColor = Colors.green}) {
    if (!mounted) return;
    
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Wishlist'),
          actions: [
            if (_wishlistItems.isNotEmpty)
              TextButton.icon(
                onPressed: _showClearWishlistDialog,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text('Clear', style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_wishlistItems.isEmpty) {
      return _buildEmptyWishlist();
    }

    return RefreshIndicator(
      onRefresh: _loadWishlistItems,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _wishlistItems.length,
        itemBuilder: (context, index) {
          return _buildWishlistCard(_wishlistItems[index]);
        },
      ),
    );
  }

  Widget _buildWishlistCard(LaptopModel laptop) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LaptopDetailScreen(laptop: laptop),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with remove button
            Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    laptop.imageUrl,
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 140,
                        color: Colors.grey[300],
                        child: const Icon(Icons.laptop, size: 50),
                      );
                    },
                  ),
                ),
                
                // FIXED: Remove button with proper state update
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                      onPressed: () => _removeFromWishlistWithUndo(laptop),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
                
                // Discount badge
                if (laptop.discount > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
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
                  ),
              ],
            ),

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      laptop.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      laptop.brand,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '₹${laptop.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        if (laptop.originalPrice > laptop.price) ...[
                          const SizedBox(width: 4),
                          Text(
                            '₹${laptop.originalPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _addToCart(laptop),
                        icon: const Icon(Icons.shopping_cart, size: 16),
                        label: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FIXED: Proper removal with undo functionality
  Future<void> _removeFromWishlistWithUndo(LaptopModel laptop) async {
    // Pehle local state se remove karein for instant UI update
    final removedItem = laptop;
    final removedIndex = _wishlistItems.indexOf(laptop);
    
    setState(() {
      _wishlistItems.remove(laptop);
    });
    
    // Snackbar with undo
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('✅ ${laptop.name} removed from wishlist'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () async {
            // Undo: Add back to UI
            setState(() {
              _wishlistItems.insert(removedIndex, removedItem);
            });
            
            // Undo: Add back to database
            await _wishlistService.addToWishlist(laptop.id);
          },
        ),
      ),
    );
    
    // Background mein database se remove karein
    try {
      await _wishlistService.removeFromWishlist(laptop.id);
    } catch (e) {
      // Agar database mein error aaye to automatically undo
      if (mounted) {
        setState(() {
          _wishlistItems.insert(removedIndex, removedItem);
        });
        _showSnackbar('Failed to remove from wishlist', backgroundColor: Colors.red);
      }
    }
  }

  // FIXED: Simple removal without undo
  Future<void> _removeFromWishlist(LaptopModel laptop) async {
    // Local state update
    setState(() {
      _wishlistItems.remove(laptop);
    });
    
    // Database update
    final success = await _wishlistService.removeFromWishlist(laptop.id);
    
    if (success && mounted) {
      _showSnackbar('✅ ${laptop.name} removed from wishlist');
    } else if (!success && mounted) {
      // Rollback
      setState(() {
        _wishlistItems.add(laptop);
      });
      _showSnackbar('❌ Failed to remove item', backgroundColor: Colors.red);
    }
  }

  Future<void> _addToCart(LaptopModel laptop) async {
    try {
      final success = await _cartService.addToCart(laptop);
      
      if (success) {
        _showSnackbar('✅ ${laptop.name} added to cart');
      } else {
        _showSnackbar('❌ Failed to add to cart', backgroundColor: Colors.red);
      }
    } catch (e) {
      _showSnackbar('❌ Error: ${e.toString()}', backgroundColor: Colors.red);
    }
  }

  void _showClearWishlistDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Wishlist'),
        content: const Text('Are you sure you want to clear your wishlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              
              // Pehle local state clear
              final oldItems = List<LaptopModel>.from(_wishlistItems);
              setState(() {
                _wishlistItems.clear();
              });
              
              _showSnackbar('✅ Wishlist cleared');
              
              // Background mein database clear
              try {
                await _wishlistService.clearWishlist();
              } catch (e) {
                // Rollback on error
                setState(() {
                  _wishlistItems = oldItems;
                });
                _showSnackbar('❌ Failed to clear wishlist', backgroundColor: Colors.red);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items you love',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.shopping_bag),
            label: const Text('Start Shopping'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
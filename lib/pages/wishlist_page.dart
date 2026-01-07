// import 'package:flutter/material.dart';

// class WishlistPage extends StatefulWidget {
//   const WishlistPage({super.key});

//   @override
//   State<WishlistPage> createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage> {
//   List<WishlistItem> wishlistItems = [
//     WishlistItem(
//       id: '1',
//       name: 'MacBook Pro M3',
//       brand: 'Apple',
//       price: 1999,
//       image: 'assets/images/macbook.png',
//       rating: 4.9,
//       specs: '16GB RAM, 512GB SSD',
//       inStock: true,
//     ),
//     WishlistItem(
//       id: '2',
//       name: 'ThinkPad X1 Carbon',
//       brand: 'Lenovo',
//       price: 1299,
//       image: 'assets/images/thinkpad.png',
//       rating: 4.8,
//       specs: '16GB RAM, 1TB SSD',
//       inStock: false,
//     ),
//     WishlistItem(
//       id: '3',
//       name: 'ROG Zephyrus G14',
//       brand: 'ASUS',
//       price: 1699,
//       image: 'assets/images/asus.png',
//       rating: 4.6,
//       specs: '32GB RAM, 1TB SSD',
//       inStock: true,
//     ),
//   ];

//   void removeItem(String id) {
//     setState(() {
//       wishlistItems.removeWhere((item) => item.id == id);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Removed from wishlist'),
//         backgroundColor: Colors.blue[700],
//         behavior: SnackBarBehavior.floating,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void moveToCart(WishlistItem item) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${item.name} added to cart!'),
//         backgroundColor: Colors.green[700],
//         behavior: SnackBarBehavior.floating,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Header with count
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.grey[50]!, Colors.blue[50]!],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'My Wishlist (${wishlistItems.length})',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               if (wishlistItems.isNotEmpty)
//                 TextButton.icon(
//                   onPressed: () {
//                     setState(() => wishlistItems.clear());
//                   },
//                   icon: Icon(Icons.delete_outline, size: 18),
//                   label: Text('Clear All'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.red,
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         // Content
//         Expanded(
//           child: wishlistItems.isEmpty
//               ? _buildEmptyWishlist()
//               : _buildWishlistContent(),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmptyWishlist() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.favorite_border, size: 120, color: Colors.grey[400]),
//           SizedBox(height: 24),
//           Text(
//             'Your Wishlist is Empty',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 12),
//           Text(
//             'Save your favorite laptops here!',
//             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//           ),
//           SizedBox(height: 32),
//           ElevatedButton.icon(
//             onPressed: () {
//               // Navigate back or to home
//             },
//             icon: Icon(Icons.laptop),
//             label: Text('Explore Laptops'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue[700],
//               foregroundColor: Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWishlistContent() {
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: wishlistItems.length,
//       itemBuilder: (context, index) {
//         return WishlistItemCard(
//           item: wishlistItems[index],
//           onRemove: () => removeItem(wishlistItems[index].id),
//           onAddToCart: () => moveToCart(wishlistItems[index]),
//         );
//       },
//     );
//   }
// }

// // Wishlist Item Card Component
// class WishlistItemCard extends StatelessWidget {
//   final WishlistItem item;
//   final VoidCallback onRemove;
//   final VoidCallback onAddToCart;

//   const WishlistItemCard({
//     required this.item,
//     required this.onRemove,
//     required this.onAddToCart,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 // Product Image
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.grey[100]!, Colors.blue[50]!],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Stack(
//                     children: [
//                       Center(
//                         child: Icon(
//                           Icons.laptop_mac,
//                           size: 60,
//                           color: Colors.blue[700],
//                         ),
//                       ),
//                       if (!item.inStock)
//                         Positioned(
//                           top: 8,
//                           right: 8,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               'Out of Stock',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 // Product Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               item.name,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey[800],
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.favorite, color: Colors.red, size: 24),
//                             onPressed: onRemove,
//                             padding: EdgeInsets.zero,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         item.brand,
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         item.specs,
//                         style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                       ),
//                       SizedBox(height: 8),
//                       // Rating
//                       Row(
//                         children: [
//                           Icon(Icons.star, size: 16, color: Colors.amber),
//                           SizedBox(width: 4),
//                           Text(
//                             '${item.rating}',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '\$${item.price}',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Action Buttons
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: onRemove,
//                     icon: Icon(Icons.delete_outline, size: 18),
//                     label: Text('Remove'),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.red,
//                       side: BorderSide(color: Colors.red[300]!),
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   flex: 2,
//                   child: ElevatedButton.icon(
//                     onPressed: item.inStock ? onAddToCart : null,
//                     icon: Icon(Icons.shopping_cart, size: 18),
//                     label: Text(item.inStock ? 'Add to Cart' : 'Out of Stock'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: item.inStock ? Colors.blue[700] : Colors.grey[400],
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Wishlist Item Model
// class WishlistItem {
//   final String id;
//   final String name;
//   final String brand;
//   final double price;
//   final String image;
//   final double rating;
//   final String specs;
//   final bool inStock;

//   WishlistItem({
//     required this.id,
//     required this.name,
//     required this.brand,
//     required this.price,
//     required this.image,
//     required this.rating,
//     required this.specs,
//     required this.inStock,
//   });
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),
      body: StreamBuilder(
        stream: wishlistProvider.wishlistStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("Wishlist empty 😢"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];

              return ListTile(
                leading: Image.network(data['image']),
                title: Text(data['title']),
                subtitle: Text("Rs ${data['price']}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    wishlistProvider.removeWishlist(data.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

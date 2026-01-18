// // import 'package:flutter/material.dart';
// // import 'package:laptop_harbor/models/wishlist_model.dart';
// // import '../providers/wishlist_provider.dart';
// // import '../providers/cart_provider.dart';
// // import 'package:provider/provider.dart';

// // class WishlistItemCard extends StatelessWidget {
// //   final WishlistItem item;

// //   const WishlistItemCard({
// //     super.key,
// //     required this.item,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       child: Padding(
// //         padding: const EdgeInsets.all(12),
// //         child: Row(
// //           children: [
// //             // Image
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(8),
// //               child: Image.network(
// //                 item.laptop.imageUrl,
// //                 width: 80,
// //                 height: 80,
// //                 fit: BoxFit.cover,
// //                 errorBuilder: (_, __, ___) => Container(
// //                   width: 80,
// //                   height: 80,
// //                   color: Colors.grey[200],
// //                   child: const Icon(Icons.laptop, color: Colors.grey),
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(width: 12),

// //             // Details
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     item.laptop.name,
// //                     style: const TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),

// //                   const SizedBox(height: 4),

// //                   Text(
// //                     item.laptop.brand,
// //                     style: TextStyle(color: Colors.grey[600]),
// //                   ),

// //                   const SizedBox(height: 4),

// //                   Text(
// //                     '₹${item.laptop.price.toStringAsFixed(0)}',
// //                     style: const TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.green,
// //                     ),
// //                   ),

// //                   const SizedBox(height: 8),

// //                   // Buttons
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: ElevatedButton.icon(
// //                           onPressed: () {
// //                             Provider.of<WishlistProvider>(context, listen: false)
// //                                 .removeFromWishlist(item.laptop.id);
// //                           },
// //                           icon: const Icon(Icons.delete_outline, size: 18),
// //                           label: const Text('Remove'),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.grey[200],
// //                             foregroundColor: Colors.grey[800],
// //                             padding: const EdgeInsets.symmetric(vertical: 8),
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Expanded(
// //                         child: ElevatedButton.icon(
// //                           onPressed: () {
// //                             Provider.of<CartProvider>(context, listen: false)
// //                                 .addToCart(item.laptop);
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(
// //                                 content: Text('Added ${item.laptop.name} to cart'),
// //                                 backgroundColor: Colors.green,
// //                               ),
// //                             );
// //                           },
// //                           icon: const Icon(Icons.add_shopping_cart, size: 18),
// //                           label: const Text('Add to Cart'),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.blue,
// //                             foregroundColor: Colors.white,
// //                             padding: const EdgeInsets.symmetric(vertical: 8),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/wishlist_model.dart';
// import '../providers/wishlist_provider.dart';
// import '../providers/cart_provider.dart';
// import 'package:provider/provider.dart';

// class WishlistItemCard extends StatefulWidget {
//   final WishlistItem item;

//   const WishlistItemCard({
//     super.key,
//     required this.item,
//   });

//   @override
//   State<WishlistItemCard> createState() => _WishlistItemCardState();
// }

// class _WishlistItemCardState extends State<WishlistItemCard> {
//   bool _isUpdating = false;
//   bool _isAddingToCart = false;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final laptop = widget.item.laptop;
        
//         // ✅ Fully Responsive Sizing
//         final width = constraints.maxWidth;
//         final height = constraints.maxHeight;

//         final bool isTiny = width < 140;
//         final bool isSmall = width < 180 && !isTiny;
//         final bool isMedium = width >= 180 && width < 220;
//         final bool isLarge = width >= 220;

//         // Dynamic sizing based on screen size
//         final imageHeightRatio = isTiny
//             ? 0.40
//             : isSmall
//             ? 0.42
//             : 0.45;
//         final imageHeight = height * imageHeightRatio;

//         final padding = isTiny
//             ? 6.0
//             : isSmall
//             ? 8.0
//             : isMedium
//             ? 10.0
//             : 12.0;
//         final brandFontSize = isTiny
//             ? 7.0
//             : isSmall
//             ? 8.0
//             : isMedium
//             ? 9.0
//             : 10.0;
//         final nameFontSize = isTiny
//             ? 11.0
//             : isSmall
//             ? 12.0
//             : isMedium
//             ? 13.0
//             : 14.0;
//         final priceFontSize = isTiny
//             ? 12.0
//             : isSmall
//             ? 13.0
//             : isMedium
//             ? 14.0
//             : 16.0;
//         final specFontSize = isTiny
//             ? 6.0
//             : isSmall
//             ? 7.0
//             : isMedium
//             ? 8.0
//             : 9.0;
//         final iconSize = isTiny
//             ? 8.0
//             : isSmall
//             ? 9.0
//             : isMedium
//             ? 10.0
//             : 11.0;

//         return Card(
//           elevation: 4,
//           shadowColor: Colors.black.withOpacity(0.2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: InkWell(
//             onTap: () {
//               // Tum yahan laptop detail page pe navigate kar sakte ho
//             },
//             borderRadius: BorderRadius.circular(16),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.white, Colors.grey[50]!],
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Image Section with Gradient Overlay
//                   SizedBox(
//                     height: imageHeight,
//                     child: Stack(
//                       children: [
//                         // Image with gradient overlay
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(16),
//                           ),
//                           child: Stack(
//                             children: [
//                               Image.network(
//                                 laptop.imageUrl,
//                                 height: imageHeight,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) => Container(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.grey[200]!,
//                                         Colors.grey[100]!,
//                                       ],
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Icon(
//                                       Icons.laptop_mac,
//                                       size: isTiny
//                                           ? 30
//                                           : isSmall
//                                           ? 40
//                                           : 50,
//                                       color: Colors.grey[400],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // Subtle gradient overlay
//                               Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     colors: [
//                                       Colors.transparent,
//                                       Colors.black.withOpacity(0.03),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // Badges
//                         Positioned(
//                           top: isTiny ? 6 : 8,
//                           left: 0,
//                           right: 0,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: isTiny
//                                   ? 6
//                                   : isSmall
//                                   ? 8
//                                   : 10,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 // Discount Badge with Gradient
//                                 if (laptop.discount > 0)
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: isTiny
//                                           ? 5
//                                           : isSmall
//                                           ? 6
//                                           : 8,
//                                       vertical: isTiny ? 2 : 3,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       gradient: const LinearGradient(
//                                         colors: [
//                                           Color(0xFFFF416C),
//                                           Color(0xFFFF4B2B),
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.circular(6),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.red.withOpacity(0.3),
//                                           blurRadius: 4,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Text(
//                                       '-${laptop.discount.toStringAsFixed(0)}%',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: isTiny
//                                             ? 8
//                                             : isSmall
//                                             ? 9
//                                             : 11,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   )
//                                 else
//                                   const SizedBox(),

//                                 // ❤️ REMOVE FROM WISHLIST Button
//                                 GestureDetector(
//                                   onTap: _isUpdating
//                                       ? null
//                                       : () async {
//                                           setState(() {
//                                             _isUpdating = true;
//                                           });

//                                           try {
//                                             final wishlistProvider =
//                                                 Provider.of<WishlistProvider>(
//                                                   context,
//                                                   listen: false,
//                                                 );
//                                             await wishlistProvider
//                                                 .removeFromWishlist(laptop.id);

//                                             // Show feedback
//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: const Text(
//                                                   'Removed from wishlist',
//                                                 ),
//                                                 duration: const Duration(
//                                                   milliseconds: 800,
//                                                 ),
//                                                 backgroundColor: Colors.red,
//                                               ),
//                                             );
//                                           } finally {
//                                             if (mounted) {
//                                               setState(() {
//                                                 _isUpdating = false;
//                                               });
//                                             }
//                                           }
//                                         },
//                                   child: Container(
//                                     padding: EdgeInsets.all(
//                                       isTiny
//                                           ? 4
//                                           : isSmall
//                                           ? 5
//                                           : 6,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       shape: BoxShape.circle,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(
//                                             0.15,
//                                           ),
//                                           blurRadius: 8,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: _isUpdating
//                                         ? SizedBox(
//                                             width: isTiny
//                                                 ? 12
//                                                 : isSmall
//                                                 ? 14
//                                                 : 18,
//                                             height: isTiny
//                                                 ? 12
//                                                 : isSmall
//                                                 ? 14
//                                                 : 18,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               color: Colors.red,
//                                             ),
//                                           )
//                                         : Icon(
//                                             Icons.favorite,
//                                             color: Colors.red,
//                                             size: isTiny
//                                                 ? 12
//                                                 : isSmall
//                                                 ? 14
//                                                 : 18,
//                                           ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         // Out of Stock Badge
//                         if (!laptop.inStock)
//                           Positioned(
//                             bottom: isTiny ? 6 : 8,
//                             left: isTiny ? 6 : 8,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: isTiny
//                                     ? 5
//                                     : isSmall
//                                     ? 6
//                                     : 8,
//                                 vertical: isTiny ? 2 : 3,
//                               ),
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.grey[800]!,
//                                     Colors.grey[900]!,
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text(
//                                 'Out of Stock',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: isTiny
//                                       ? 7
//                                       : isSmall
//                                       ? 8
//                                       : 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),

//                   // Content Section with Gradient Background
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.all(padding),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Colors.white,
//                             Colors.grey[50]!.withOpacity(0.5),
//                           ],
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Brand & Category
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   laptop.brand.toUpperCase(),
//                                   style: TextStyle(
//                                     color: Colors.blue[700],
//                                     fontSize: brandFontSize,
//                                     fontWeight: FontWeight.w600,
//                                     letterSpacing: 0.3,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: isTiny
//                                       ? 3
//                                       : isSmall
//                                       ? 4
//                                       : 6,
//                                   vertical: isTiny ? 1 : 2,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       _getCategoryColor(
//                                         laptop.category,
//                                       ).withOpacity(0.15),
//                                       _getCategoryColor(
//                                         laptop.category,
//                                       ).withOpacity(0.05),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(4),
//                                   border: Border.all(
//                                     color: _getCategoryColor(
//                                       laptop.category,
//                                     ).withOpacity(0.3),
//                                     width: 0.5,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   laptop.category,
//                                   style: TextStyle(
//                                     color: _getCategoryColor(
//                                       laptop.category,
//                                     ),
//                                     fontSize: isTiny
//                                         ? 6
//                                         : isSmall
//                                         ? 7
//                                         : 9,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: isTiny
//                                 ? 2
//                                 : isSmall
//                                 ? 3
//                                 : 4,
//                           ),

//                           // Name
//                           Text(
//                             laptop.name,
//                             style: TextStyle(
//                               fontSize: nameFontSize,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey[900],
//                               height: 1.1,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(
//                             height: isTiny
//                                 ? 3
//                                 : isSmall
//                                 ? 4
//                                 : 6,
//                           ),

//                           // Specs
//                           Wrap(
//                             spacing: isTiny ? 2 : 3,
//                             runSpacing: isTiny ? 2 : 3,
//                             children: [
//                               _buildSpec(
//                                 Icons.memory,
//                                 laptop.processor.split(' ').first,
//                                 specFontSize,
//                                 iconSize,
//                               ),
//                               _buildSpec(
//                                 Icons.storage,
//                                 '${laptop.ram}GB',
//                                 specFontSize,
//                                 iconSize,
//                               ),
//                               if (!isTiny)
//                                 _buildSpec(
//                                   Icons.sd_storage,
//                                   '${laptop.storage}GB',
//                                   specFontSize,
//                                   iconSize,
//                                 ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: isTiny
//                                 ? 3
//                                 : isSmall
//                                 ? 4
//                                 : 6,
//                           ),

//                           // Rating
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.amber[600],
//                                 size: isTiny
//                                     ? 10
//                                     : isSmall
//                                     ? 11
//                                     : 14,
//                               ),
//                               SizedBox(
//                                 width: isTiny
//                                     ? 1
//                                     : isSmall
//                                     ? 2
//                                     : 3,
//                               ),
//                               Text(
//                                 laptop.rating.toString(),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: isTiny
//                                       ? 9
//                                       : isSmall
//                                       ? 10
//                                       : 12,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: isTiny
//                                     ? 1
//                                     : isSmall
//                                     ? 2
//                                     : 3,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   '(${laptop.reviews})',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: isTiny
//                                         ? 7
//                                         : isSmall
//                                         ? 8
//                                         : 10,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Spacer(),

//                           // Price Section with ADD TO CART Button
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     if (laptop.discount > 0)
//                                       Text(
//                                         'Rs ${laptop.originalPrice.toStringAsFixed(0)}',
//                                         style: TextStyle(
//                                           fontSize: isTiny
//                                               ? 7
//                                               : isSmall
//                                               ? 8
//                                               : 10,
//                                           color: Colors.grey[500],
//                                           decoration:
//                                               TextDecoration.lineThrough,
//                                         ),
//                                         maxLines: 1,
//                                       ),
//                                     Text(
//                                       'Rs ${laptop.price.toStringAsFixed(0)}',
//                                       style: TextStyle(
//                                         fontSize: priceFontSize,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.blue[700],
//                                       ),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // ✅ ADD TO CART Button - Same logic as home page
//                               GestureDetector(
//                                 onTap: !laptop.inStock || _isAddingToCart
//                                     ? null
//                                     : () async {
//                                         setState(() {
//                                           _isAddingToCart = true;
//                                         });

//                                         try {
//                                           await Future.delayed(
//                                               const Duration(milliseconds: 300));

//                                           final cartProvider =
//                                               Provider.of<CartProvider>(
//                                             context,
//                                             listen: false,
//                                           );
//                                           await cartProvider.addToCart(laptop);

//                                           // Show success snackbar
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             SnackBar(
//                                               content: Text(
//                                                 '✅ ${laptop.name} added to cart',
//                                               ),
//                                               backgroundColor: Colors.green,
//                                               duration:
//                                                   const Duration(seconds: 1),
//                                               behavior: SnackBarBehavior.floating,
//                                             ),
//                                           );
//                                         } catch (e) {
//                                           // Show error snackbar
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             SnackBar(
//                                               content: const Text(
//                                                 '❌ Failed to add to cart',
//                                               ),
//                                               backgroundColor: Colors.red,
//                                               duration:
//                                                   const Duration(seconds: 1),
//                                             ),
//                                           );
//                                         } finally {
//                                           if (mounted) {
//                                             setState(() {
//                                               _isAddingToCart = false;
//                                             });
//                                           }
//                                         }
//                                       },
//                                 child: Container(
//                                   padding: EdgeInsets.all(
//                                     isTiny
//                                         ? 5
//                                         : isSmall
//                                         ? 6
//                                         : 8,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     gradient: !laptop.inStock
//                                         ? LinearGradient(
//                                             colors: [
//                                               Colors.grey[400]!,
//                                               Colors.grey[500]!,
//                                             ],
//                                           )
//                                         : LinearGradient(
//                                             colors: [
//                                               Colors.blue[700]!,
//                                               Colors.blue[600]!,
//                                             ],
//                                           ),
//                                     borderRadius: BorderRadius.circular(8),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: (!laptop.inStock
//                                                 ? Colors.grey
//                                                 : Colors.blue)
//                                             .withOpacity(0.3),
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: _isAddingToCart
//                                       ? SizedBox(
//                                           width: isTiny
//                                               ? 10
//                                               : isSmall
//                                               ? 12
//                                               : 16,
//                                           height: isTiny
//                                               ? 10
//                                               : isSmall
//                                               ? 12
//                                               : 16,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                             color: Colors.white,
//                                           ),
//                                         )
//                                       : Icon(
//                                           !laptop.inStock
//                                               ? Icons.block
//                                               : Icons.shopping_cart_outlined,
//                                           color: Colors.white,
//                                           size: isTiny
//                                               ? 10
//                                               : isSmall
//                                               ? 12
//                                               : 16,
//                                         ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSpec(
//     IconData icon,
//     String text,
//     double fontSize,
//     double iconSize,
//   ) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [Colors.grey[100]!, Colors.grey[50]!]),
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(color: Colors.grey[200]!, width: 0.5),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: iconSize, color: Colors.grey[700]),
//           const SizedBox(width: 2),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: fontSize,
//               color: Colors.grey[700],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getCategoryColor(String category) {
//     switch (category.toLowerCase()) {
//       case 'premium':
//         return Colors.purple;
//       case 'gaming':
//         return Colors.red;
//       case 'business':
//         return Colors.blue;
//       case 'budget':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// // 
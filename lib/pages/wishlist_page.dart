// // lib/pages/wishlist_page.dart
// // ignore_for_file: use_build_context_synchronously, unused_element

// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:laptop_harbor/pages/CategoriesPage.dart';
// import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// import 'package:laptop_harbor/pages/laptop_home_page.dart';
// import 'package:laptop_harbor/services/cart.sevices.dart';
// import 'package:laptop_harbor/services/wishlist_service.dart';
// import 'dart:math' as math;

// import 'package:shimmer/main.dart';

// class WishlistPage extends StatefulWidget {
//   const WishlistPage({super.key});

//   @override
//   State<WishlistPage> createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage>
//     with TickerProviderStateMixin {
//   final WishlistService _wishlistService = WishlistService();
//   final CartService _cartService = CartService();
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();

//   List<LaptopModel> _wishlistItems = [];
//   bool _isLoading = true;

//   // Animation controllers
//   late AnimationController _floatingController;
//   late AnimationController _heartbeatController;
//   late Animation<double> _floatingAnimation;
//   late Animation<double> _heartbeatAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     _loadWishlistItems();
//   }

//   void _setupAnimations() {
//     _floatingController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     )..repeat(reverse: true);

//     _heartbeatController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     )..repeat(reverse: true);

//     _floatingAnimation = Tween<double>(begin: -5, end: 5).animate(
//       CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
//     );

//     _heartbeatAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
//       CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _floatingController.dispose();
//     _heartbeatController.dispose();
//     super.dispose();
//   }

//   Widget _buildFloatingParticle(int index) {
//     final random = math.Random(index);
//     final size = 3.0 + random.nextDouble() * 6;
//     final initialX = random.nextDouble() * 400;
//     final initialY = random.nextDouble() * 600;

//     return AnimatedBuilder(
//       animation: _floatingController,
//       builder: (context, child) {
//         return Positioned(
//           left: initialX + (_floatingAnimation.value * (index % 3)),
//           top: initialY + (_floatingAnimation.value * (index % 4)),
//           child: Container(
//             width: size,
//             height: size,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.pink[300]!.withOpacity(0.1 + (index % 3) * 0.05),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.pink[300]!.withOpacity(0.15),
//                   blurRadius: 6,
//                   spreadRadius: 1,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _loadWishlistItems() async {
//     setState(() => _isLoading = true);

//     try {
//       final items = await _wishlistService.getWishlistItems();
//       if (mounted) {
//         setState(() {
//           _wishlistItems = items;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoading = false);
//         _showSnackbar(
//           'Error loading wishlist: $e',
//           backgroundColor: Colors.red,
//         );
//       }
//     }
//   }

//   void _showSnackbar(String message, {Color backgroundColor = Colors.green}) {
//     if (!mounted) return;

//     _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
//     _scaffoldMessengerKey.currentState?.showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               backgroundColor == Colors.green
//                   ? Icons.check_circle
//                   : Icons.error,
//               color: Colors.white,
//             ),
//             const SizedBox(width: 12),
//             Expanded(child: Text(message)),
//           ],
//         ),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldMessenger(
//       key: _scaffoldMessengerKey,
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // Gradient Background
//             Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFFFF5F7), Color(0xFFFCE7F3)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//             // Floating particles
//             ...List.generate(10, (index) => _buildFloatingParticle(index)),
//             // Main content
//             SafeArea(
//               child: Column(
//                 children: [
//                   _buildCustomAppBar(),
//                   Expanded(child: _buildBody()),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCustomAppBar() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pink[400]!, Colors.pink[600]!],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.pink.withOpacity(0.3),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Fixed Back Button - Works correctly
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () {
//                 // Simple back navigation - previous page par jayega
//                 // Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LaptopHomePage()),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'My Wishlist',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 Text(
//                   '${_wishlistItems.length} ${_wishlistItems.length == 1 ? 'item' : 'items'}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white.withOpacity(0.9),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_wishlistItems.isNotEmpty)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.delete_outline, color: Colors.white),
//                 onPressed: _showClearWishlistDialog,
//               ),
//             ),
//           const SizedBox(width: 8),
//           AnimatedBuilder(
//             animation: _heartbeatAnimation,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _heartbeatAnimation.value,
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.favorite,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBody() {
//     // Beautiful Loading Animation - Same as Home & Categories
//     if (_isLoading) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.0, end: 1.0),
//               duration: const Duration(seconds: 2),
//               builder: (context, value, child) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Outer rotating circle
//                     Transform.rotate(
//                       angle: value * 2 * 3.14159,
//                       child: Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Colors.pink[300]!,
//                             width: 3,
//                           ),
//                           gradient: LinearGradient(
//                             colors: [Colors.pink[400]!, Colors.transparent],
//                             stops: const [0.5, 0.5],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Inner pulsing circle
//                     Container(
//                       width: 60 + (value * 10),
//                       height: 60 + (value * 10),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.pink[400]!.withOpacity(1 - value * 0.3),
//                             Colors.pink[600]!.withOpacity(1 - value * 0.3),
//                           ],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.pink.withOpacity(0.3),
//                             blurRadius: 20 * value,
//                             spreadRadius: 5 * value,
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.favorite,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               onEnd: () {
//                 if (mounted) {
//                   setState(() {});
//                 }
//               },
//             ),
//             const SizedBox(height: 32),
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 1500),
//               builder: (context, value, child) {
//                 return Opacity(
//                   opacity: value,
//                   child: const Text(
//                     'Loading wishlist...',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF64748B),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     if (_wishlistItems.isEmpty) {
//       return _buildEmptyWishlist();
//     }

//     return RefreshIndicator(
//       onRefresh: _loadWishlistItems,
//       color: Colors.pink[600],
//       child: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.65,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         itemCount: _wishlistItems.length,
//         itemBuilder: (context, index) {
//           return _buildWishlistCard(_wishlistItems[index], index);
//         },
//       ),
//     );
//   }

//   Widget _buildWishlistCard(LaptopModel laptop, int index) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 300 + (index * 100)),
//       tween: Tween(begin: 0.0, end: 1.0),
//       builder: (context, value, child) {
//         return Transform.scale(
//           scale: value,
//           child: Opacity(
//             opacity: value,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.pink.withOpacity(0.1),
//                     blurRadius: 16,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             LaptopDetailScreen(laptop: laptop),
//                       ),
//                     );
//                   },
//                   borderRadius: BorderRadius.circular(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Image Section
//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(20),
//                             ),
//                             child: Image.network(
//                               laptop.imageUrl,
//                               width: double.infinity,
//                               height: 140,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   width: double.infinity,
//                                   height: 140,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.grey[200]!,
//                                         Colors.grey[300]!,
//                                       ],
//                                     ),
//                                   ),
//                                   child: Icon(
//                                     Icons.laptop_mac,
//                                     size: 50,
//                                     color: Colors.grey[400],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),

//                           // Favorite Button with animation
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: AnimatedBuilder(
//                               animation: _heartbeatController,
//                               builder: (context, child) {
//                                 return Transform.scale(
//                                   scale: _heartbeatAnimation.value,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Colors.pink[400]!,
//                                           Colors.red[600]!,
//                                         ],
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.pink.withOpacity(0.4),
//                                           blurRadius: 8,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Material(
//                                       color: Colors.transparent,
//                                       child: InkWell(
//                                         borderRadius: BorderRadius.circular(50),
//                                         onTap: () =>
//                                             _removeFromWishlistWithUndo(laptop),
//                                         child: const Padding(
//                                           padding: EdgeInsets.all(8),
//                                           child: Icon(
//                                             Icons.favorite,
//                                             color: Colors.white,
//                                             size: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),

//                           // Discount Badge
//                           if (laptop.discount > 0)
//                             Positioned(
//                               top: 8,
//                               left: 8,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Colors.red[400]!,
//                                       Colors.red[700]!,
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(8),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.red.withOpacity(0.3),
//                                       blurRadius: 6,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Text(
//                                   '${laptop.discount.toStringAsFixed(0)}% OFF',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),

//                       // Details Section
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 laptop.name,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 8,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[100],
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 child: Text(
//                                   laptop.brand,
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.grey[700],
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               const Spacer(),

//                               // Price Section
//                               Row(
//                                 children: [
//                                   Text(
//                                     '₹${laptop.price.toStringAsFixed(0)}',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.green[700],
//                                     ),
//                                   ),
//                                   if (laptop.originalPrice > laptop.price) ...[
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       '₹${laptop.originalPrice.toStringAsFixed(0)}',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         decoration: TextDecoration.lineThrough,
//                                         color: Colors.grey[500],
//                                       ),
//                                     ),
//                                   ],
//                                 ],
//                               ),
//                               const SizedBox(height: 10),

//                               // Add to Cart Button
//                               Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Colors.blue[500]!,
//                                       Colors.blue[700]!,
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.blue.withOpacity(0.3),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     borderRadius: BorderRadius.circular(10),
//                                     onTap: () => _addToCart(laptop),
//                                     child: const Padding(
//                                       padding: EdgeInsets.symmetric(
//                                         vertical: 10,
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Icon(
//                                             Icons.shopping_cart,
//                                             size: 16,
//                                             color: Colors.white,
//                                           ),
//                                           SizedBox(width: 6),
//                                           Text(
//                                             'Add to Cart',
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildEmptyWishlist() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AnimatedBuilder(
//             animation: _heartbeatController,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _heartbeatAnimation.value,
//                 child: Container(
//                   padding: const EdgeInsets.all(40),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [Colors.pink[100]!, Colors.pink[50]!],
//                     ),
//                   ),
//                   child: Icon(
//                     Icons.favorite_border,
//                     size: 80,
//                     color: Colors.pink[300],
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 32),
//           Text(
//             'Your wishlist is empty',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'Add items you love',
//             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 40),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               gradient: LinearGradient(
//                 colors: [Colors.pink[400]!, Colors.pink[600]!],
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.pink.withOpacity(0.3),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(12),
//                 onTap: () =>
//                     Navigator.pop(context), // Simple back to previous page
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.shopping_bag, color: Colors.white),
//                       SizedBox(width: 12),
//                       Text(
//                         'Start Shopping',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _removeFromWishlistWithUndo(LaptopModel laptop) async {
//     final removedItem = laptop;
//     final removedIndex = _wishlistItems.indexOf(laptop);

//     setState(() {
//       _wishlistItems.remove(laptop);
//     });

//     _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
//     _scaffoldMessengerKey.currentState?.showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.check_circle, color: Colors.white),
//             const SizedBox(width: 12),
//             Expanded(child: Text('${laptop.name} removed from wishlist')),
//           ],
//         ),
//         backgroundColor: Colors.green[600],
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//         duration: const Duration(seconds: 4),
//         action: SnackBarAction(
//           label: 'Undo',
//           textColor: Colors.white,
//           onPressed: () async {
//             setState(() {
//               _wishlistItems.insert(removedIndex, removedItem);
//             });
//             await _wishlistService.addToWishlist(laptop.id);
//           },
//         ),
//       ),
//     );

//     try {
//       await _wishlistService.removeFromWishlist(laptop.id);
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _wishlistItems.insert(removedIndex, removedItem);
//         });
//         _showSnackbar(
//           'Failed to remove from wishlist',
//           backgroundColor: Colors.red,
//         );
//       }
//     }
//   }

//   Future<void> _addToCart(LaptopModel laptop) async {
//     try {
//       final success = await _cartService.addToCart(laptop);

//       if (success) {
//         _showSnackbar('✅ ${laptop.name} added to cart');
//       } else {
//         _showSnackbar('❌ Failed to add to cart', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       _showSnackbar('❌ Error: ${e.toString()}', backgroundColor: Colors.red);
//     }
//   }

//   void _showClearWishlistDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red[50],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(Icons.delete_outline, color: Colors.red[700]),
//             ),
//             const SizedBox(width: 12),
//             const Text('Clear Wishlist'),
//           ],
//         ),
//         content: const Text(
//           'Are you sure you want to clear your entire wishlist?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               gradient: LinearGradient(
//                 colors: [Colors.red[400]!, Colors.red[600]!],
//               ),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(8),
//                 onTap: () async {
//                   Navigator.pop(context);

//                   final oldItems = List<LaptopModel>.from(_wishlistItems);
//                   setState(() {
//                     _wishlistItems.clear();
//                   });

//                   _showSnackbar('✅ Wishlist cleared');

//                   try {
//                     await _wishlistService.clearWishlist();
//                   } catch (e) {
//                     setState(() {
//                       _wishlistItems = oldItems;
//                     });
//                     _showSnackbar(
//                       '❌ Failed to clear wishlist',
//                       backgroundColor: Colors.red,
//                     );
//                   }
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Text(
//                     'Clear All',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
import 'package:laptop_harbor/pages/laptop_home_page.dart';
import 'package:laptop_harbor/services/cart.sevices.dart';
import 'package:laptop_harbor/services/wishlist_service.dart';
import 'dart:math' as math;
import 'package:laptop_harbor/widgets/laptop_card.dart'; // ✅ Home page ka card import karo

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> with TickerProviderStateMixin {
  final WishlistService _wishlistService = WishlistService();
  final CartService _cartService = CartService();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  List<LaptopModel> _wishlistItems = [];
  bool _isLoading = true;

  // Animation controllers
  late AnimationController _floatingController;
  late AnimationController _heartbeatController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadWishlistItems();
  }

  void _setupAnimations() {
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _heartbeatAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _heartbeatController.dispose();
    super.dispose();
  }

  Widget _buildFloatingParticle(int index) {
    final random = math.Random(index);
    final size = 3.0 + random.nextDouble() * 6;
    final initialX = random.nextDouble() * 400;
    final initialY = random.nextDouble() * 600;

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Positioned(
          left: initialX + (_floatingAnimation.value * (index % 3)),
          top: initialY + (_floatingAnimation.value * (index % 4)),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink[300]!.withOpacity(0.1 + (index % 3) * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink[300]!.withOpacity(0.15),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadWishlistItems() async {
    setState(() => _isLoading = true);

    try {
      final items = await _wishlistService.getWishlistItems();
      if (mounted) {
        setState(() {
          _wishlistItems = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackbar(
          'Error loading wishlist: $e',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void _showSnackbar(String message, {Color backgroundColor = Colors.green}) {
    if (!mounted) return;

    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              backgroundColor == Colors.green ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: Stack(
          children: [
            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFF5F7), Color(0xFFFCE7F3)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Floating particles
            ...List.generate(10, (index) => _buildFloatingParticle(index)),
            // Main content
            SafeArea(
              child: Column(
                children: [
                  _buildCustomAppBar(),
                  Expanded(child: _buildBody()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[400]!, Colors.pink[600]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LaptopHomePage()),
                  (route) => false,
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Wishlist',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '${_wishlistItems.length} ${_wishlistItems.length == 1 ? 'item' : 'items'}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          if (_wishlistItems.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white),
                onPressed: _showClearWishlistDialog,
              ),
            ),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: _heartbeatAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _heartbeatAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    // Beautiful Loading Animation
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 2),
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer rotating circle
                    Transform.rotate(
                      angle: value * 2 * 3.14159,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.pink[300]!,
                            width: 3,
                          ),
                          gradient: LinearGradient(
                            colors: [Colors.pink[400]!, Colors.transparent],
                            stops: const [0.5, 0.5],
                          ),
                        ),
                      ),
                    ),
                    // Inner pulsing circle
                    Container(
                      width: 60 + (value * 10),
                      height: 60 + (value * 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink[400]!.withOpacity(1 - value * 0.3),
                            Colors.pink[600]!.withOpacity(1 - value * 0.3),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.3),
                            blurRadius: 20 * value,
                            spreadRadius: 5 * value,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: const Text(
                    'Loading wishlist...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    if (_wishlistItems.isEmpty) {
      return _buildEmptyWishlist();
    }

    return RefreshIndicator(
      onRefresh: _loadWishlistItems,
      color: Colors.pink[600],
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
          return _buildWishlistCard(_wishlistItems[index], index);
        },
      ),
    );
  }

  // ✅ UPDATED: Ab same LaptopCard use karo jo home page mein hai
  Widget _buildWishlistCard(LaptopModel laptop, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: LaptopCard(
                laptop: laptop,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LaptopDetailScreen(laptop: laptop),
                    ),
                  );
                },
                showWishlistButton: false, // Wishlist page par heart button nahi dikhayein
                isInWishlist: true, // Ye to wishlist hi hai, so true
                onFavorite: () {
                  // Remove from wishlist logic
                  _removeFromWishlistWithUndo(laptop);
                },
                onWishlistToggle: () {
                  // Remove from wishlist logic
                  _removeFromWishlistWithUndo(laptop);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _heartbeatController,
            builder: (context, child) {
              return Transform.scale(
                scale: _heartbeatAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.pink[100]!, Colors.pink[50]!],
                    ),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.pink[300],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add items you love',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.pink[400]!, Colors.pink[600]!],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.white),
                      SizedBox(width: 12),
                      Text(
                        'Start Shopping',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeFromWishlistWithUndo(LaptopModel laptop) async {
    final removedItem = laptop;
    final removedIndex = _wishlistItems.indexOf(laptop);

    setState(() {
      _wishlistItems.remove(laptop);
    });

    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('${laptop.name} removed from wishlist')),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () async {
            setState(() {
              _wishlistItems.insert(removedIndex, removedItem);
            });
            await _wishlistService.addToWishlist(laptop.id);
          },
        ),
      ),
    );

    try {
      await _wishlistService.removeFromWishlist(laptop.id);
    } catch (e) {
      if (mounted) {
        setState(() {
          _wishlistItems.insert(removedIndex, removedItem);
        });
        _showSnackbar(
          'Failed to remove from wishlist',
          backgroundColor: Colors.red,
        );
      }
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.delete_outline, color: Colors.red[700]),
            ),
            const SizedBox(width: 12),
            const Text('Clear Wishlist'),
          ],
        ),
        content: const Text(
          'Are you sure you want to clear your entire wishlist?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [Colors.red[400]!, Colors.red[600]!],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  Navigator.pop(context);

                  final oldItems = List<LaptopModel>.from(_wishlistItems);
                  setState(() {
                    _wishlistItems.clear();
                  });

                  _showSnackbar('✅ Wishlist cleared');

                  try {
                    await _wishlistService.clearWishlist();
                  } catch (e) {
                    setState(() {
                      _wishlistItems = oldItems;
                    });
                    _showSnackbar(
                      '❌ Failed to clear wishlist',
                      backgroundColor: Colors.red,
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
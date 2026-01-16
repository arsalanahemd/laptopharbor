
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/cart_item_model.dart';
// import 'package:provider/provider.dart';
// import '../providers/cart_provider.dart';
// import '../widgets/cart_item_card.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen>
//     with TickerProviderStateMixin {
//   AnimationController? _headerController;
//   AnimationController? _listController;
//   AnimationController? _bottomController;
  
//   Animation<double>? _headerSlideAnimation;
//   Animation<double>? _headerFadeAnimation;
//   Animation<double>? _listSlideAnimation;
//   Animation<double>? _bottomSlideAnimation;

//   bool _isAnimationsInitialized = false;

//   @override
//   void initState() {
//     super.initState();
    
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeAnimations();
//     });
//   }

//   void _initializeAnimations() {
//     if (!mounted) return;
    
//     _headerController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
    
//     _headerSlideAnimation = Tween<double>(begin: -100, end: 0).animate(
//       CurvedAnimation(parent: _headerController!, curve: Curves.easeOutCubic),
//     );
    
//     _headerFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _headerController!, curve: Curves.easeIn),
//     );
    
//     _listController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
    
//     _listSlideAnimation = Tween<double>(begin: 50, end: 0).animate(
//       CurvedAnimation(parent: _listController!, curve: Curves.easeOutCubic),
//     );
    
//     _bottomController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
    
//     _bottomSlideAnimation = Tween<double>(begin: 100, end: 0).animate(
//       CurvedAnimation(parent: _bottomController!, curve: Curves.easeOutBack),
//     );
    
//     if (mounted) {
//       setState(() {
//         _isAnimationsInitialized = true;
//       });
//     }

//     _headerController?.forward();
//     Future.delayed(const Duration(milliseconds: 200), () {
//       if (mounted) _listController?.forward();
//     });
//     Future.delayed(const Duration(milliseconds: 400), () {
//       if (mounted) _bottomController?.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _headerController?.dispose();
//     _listController?.dispose();
//     _bottomController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isAnimationsInitialized) {
//       return Scaffold(
//         backgroundColor: Colors.grey[50],
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.blue[700],
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: const Text(
//             'Shopping Cart',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         body: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     final screenWidth = MediaQuery.of(context).size.width;
    
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
      
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: AnimatedBuilder(
//           animation: _headerController!,
//           builder: (context, child) {
//             return Transform.translate(
//               offset: Offset(0, _headerSlideAnimation!.value),
//               child: _buildAnimatedOpacity(_headerFadeAnimation!.value, child),
//             );
//           },
//           child: AppBar(
//             elevation: 0,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blue[700]!, Colors.blue[600]!],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//             leading: IconButton(
//               icon: Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.arrow_back_ios_rounded,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//               onPressed: () => Navigator.pop(context),
//             ),
//             title: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.shopping_cart_rounded,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Shopping Cart',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               Consumer<CartProvider>(
//                 builder: (context, cart, child) {
//                   if (cart.items.isEmpty) return const SizedBox();
                  
//                   return IconButton(
//                     icon: Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.delete_outline_rounded,
//                         color: Colors.white,
//                       ),
//                     ),
//                     onPressed: () => _showClearCartDialog(context),
//                   );
//                 },
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//         ),
//       ),

//       body: Consumer<CartProvider>(
//         builder: (context, cart, child) {
//           if (cart.items.isEmpty) {
//             return _buildEmptyCart(context, screenWidth);
//           }

//           return Column(
//             children: [
//               // Animated Summary Card
//               AnimatedBuilder(
//                 animation: _listController!,
//                 builder: (context, child) {
//                   return Transform.translate(
//                     offset: Offset(0, _listSlideAnimation!.value),
//                     child: _buildAnimatedOpacity(_listController!.value, child),
//                   );
//                 },
//                 child: _buildSummaryCard(cart, screenWidth),
//               ),

//               // Animated Cart Items List
//               Expanded(
//                 child: AnimatedBuilder(
//                   animation: _listController!,
//                   builder: (context, child) {
//                     return Transform.translate(
//                       offset: Offset(0, _listSlideAnimation!.value * 0.5),
//                       child: _buildAnimatedOpacity(_listController!.value, child),
//                     );
//                   },
//                   child: ListView.builder(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     itemCount: cart.items.length,
//                     itemBuilder: (context, index) {
//                       final item = cart.items[index];
//                       return _buildAnimatedCartItem(item, index);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),

//       // Bottom Bar
//       bottomNavigationBar: Consumer<CartProvider>(
//         builder: (context, cart, child) {
//           if (cart.items.isEmpty) return const SizedBox.shrink();
          
//           return AnimatedBuilder(
//             animation: _bottomController!,
//             builder: (context, child) {
//               return Transform.translate(
//                 offset: Offset(0, _bottomSlideAnimation!.value),
//                 child: _buildCheckoutBar(context, cart, screenWidth),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // ✅ Safe Opacity Widget
//   Widget _buildAnimatedOpacity(double value, Widget? child) {
//     // Ensure opacity is within 0.0 to 1.0 range
//     final safeOpacity = value.clamp(0.0, 1.0);
//     return Opacity(
//       opacity: safeOpacity,
//       child: child,
//     );
//   }

//   Widget _buildAnimatedCartItem(CartItem item, int index) {
//     return TweenAnimationBuilder<double>(
//       key: ValueKey('cart_item_${item.laptop.id}_${item.quantity}_${index}'),
//       tween: Tween(begin: 0, end: 1),
//       duration: Duration(milliseconds: 400 + (index * 100)),
//       curve: Curves.easeOutBack,
//       builder: (context, value, child) {
//         // ✅ Clamp value to 0.0-1.0 range
//         final safeValue = value.clamp(0.0, 1.0);
//         return Transform.scale(
//           scale: safeValue,
//           child: _buildAnimatedOpacity(safeValue, CartItemCard(item: item)),
//         );
//       },
//     );
//   }

//   Widget _buildEmptyCart(BuildContext context, double screenWidth) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0, end: 1),
//       duration: const Duration(milliseconds: 800),
//       curve: Curves.easeOutBack,
//       builder: (context, value, child) {
//         // ✅ Clamp value to 0.0-1.0 range
//         final safeValue = value.clamp(0.0, 1.0);
//         return Transform.scale(
//           scale: safeValue,
//           child: _buildAnimatedOpacity(
//             safeValue,
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: screenWidth < 360 ? 140 : 160,
//                     height: screenWidth < 360 ? 140 : 160,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.grey[100]!, Colors.grey[50]!],
//                       ),
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.grey[300]!,
//                         width: 3,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.shopping_cart_outlined,
//                       size: screenWidth < 360 ? 70 : 80,
//                       color: Colors.grey[400],
//                     ),
//                   ),
//                   const SizedBox(height: 30),
                  
//                   const Text(
//                     'Your Cart is Empty',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
                  
//                   Text(
//                     'Add some items to get started!',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 40),

//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.blue[700]!, Colors.blue[600]!],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.blue.withOpacity(0.4),
//                           blurRadius: 12,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () => Navigator.pop(context),
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 32,
//                             vertical: 16,
//                           ),
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.shopping_bag_outlined,
//                                 color: Colors.white,
//                                 size: 24,
//                               ),
//                               SizedBox(width: 12),
//                               Text(
//                                 'Continue Shopping',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
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

//   Widget _buildSummaryCard(CartProvider cart, double screenWidth) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.blue[50]!, Colors.white],
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: Colors.blue[100]!,
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blue.withOpacity(0.1),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildSummaryItem(
//             icon: Icons.shopping_bag_outlined,
//             label: 'Total Items',
//             value: '${cart.totalItems}',
//             color: Colors.blue,
//           ),
//           Container(
//             height: 50,
//             width: 1.5,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.transparent,
//                   Colors.grey[300]!,
//                   Colors.transparent,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           _buildSummaryItem(
//             icon: Icons.account_balance_wallet_outlined,
//             label: 'Subtotal',
//             value: '₹${cart.totalAmount.toStringAsFixed(0)}',
//             color: Colors.green,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryItem({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 color.withOpacity(0.1),
//                 color.withOpacity(0.05),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: color, size: 28),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCheckoutBar(
//       BuildContext context, CartProvider cart, double screenWidth) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.grey[50]!, Colors.white],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: Colors.grey[200]!,
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     _buildPriceRow(
//                       'Subtotal',
//                       '₹${cart.totalAmount.toStringAsFixed(0)}',
//                       false,
//                     ),
//                     const SizedBox(height: 8),
//                     _buildPriceRow(
//                       'Delivery',
//                       'Free',
//                       false,
//                       valueColor: Colors.green,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                       child: Divider(height: 1),
//                     ),
//                     _buildPriceRow(
//                       'Total',
//                       '₹${cart.totalAmount.toStringAsFixed(0)}',
//                       true,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),

//               Container(
//                 width: double.infinity,
//                 height: 56,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blue[700]!, Colors.blue[600]!],
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.blue.withOpacity(0.4),
//                       blurRadius: 12,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () => _showCheckoutDialog(context, cart),
//                     borderRadius: BorderRadius.circular(16),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.lock_outline_rounded,
//                           color: Colors.white,
//                           size: 24,
//                         ),
//                         SizedBox(width: 12),
//                         Text(
//                           'Proceed to Checkout',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPriceRow(String label, String value, bool isBold,
//       {Color? valueColor}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isBold ? 18 : 15,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
//             color: isBold ? Colors.black87 : Colors.grey[700],
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isBold ? 20 : 16,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
//             color: valueColor ?? (isBold ? Colors.blue[700] : Colors.grey[800]),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showClearCartDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.orange[50],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 Icons.warning_amber_rounded,
//                 color: Colors.orange[700],
//                 size: 28,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               'Clear Cart?',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         content: const Text(
//           'Are you sure you want to remove all items from your cart?',
//           style: TextStyle(fontSize: 15),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Colors.orange, Colors.deepOrange],
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   if (mounted) {
//                     context.read<CartProvider>().clearCart();
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: const Text('Cart cleared successfully'),
//                         backgroundColor: Colors.orange[700],
//                         behavior: SnackBarBehavior.floating,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 borderRadius: BorderRadius.circular(8),
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

// // ignore_for_file: unused_element, unnecessary_brace_in_string_interps

//   void _showCheckoutDialog(BuildContext context, CartProvider cart) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.green[400]!, Colors.green[600]!],
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(
//                 Icons.check_circle_outline_rounded,
//                 color: Colors.white,
//                 size: 28,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               'Checkout',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Order Summary:',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               '${cart.totalItems} items',
//               style: const TextStyle(fontSize: 14),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Total: ₹${cart.totalAmount.toStringAsFixed(0)}',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue[700],
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Proceed to payment?',
//               style: TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue[700]!, Colors.blue[600]!],
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text('Order placed successfully! 🎉'),
//                       backgroundColor: Colors.green[700],
//                       behavior: SnackBarBehavior.floating,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                   cart.clearCart();
//                 },
//                 borderRadius: BorderRadius.circular(8),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Text(
//                     'Confirm',
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
import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/cart_item_model.dart';
import 'package:provider/provider.dart';
import 'package:laptop_harbor/pages/cheack_out.dart'; // Add this import
import '../providers/cart_provider.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with TickerProviderStateMixin {
  AnimationController? _headerController;
  AnimationController? _listController;
  AnimationController? _bottomController;
  
  Animation<double>? _headerSlideAnimation;
  Animation<double>? _headerFadeAnimation;
  Animation<double>? _listSlideAnimation;
  Animation<double>? _bottomSlideAnimation;

  bool _isAnimationsInitialized = false;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAnimations();
    });
  }

  void _initializeAnimations() {
    if (!mounted) return;
    
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _headerSlideAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _headerController!, curve: Curves.easeOutCubic),
    );
    
    _headerFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController!, curve: Curves.easeIn),
    );
    
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _listSlideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _listController!, curve: Curves.easeOutCubic),
    );
    
    _bottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    
    _bottomSlideAnimation = Tween<double>(begin: 100, end: 0).animate(
      CurvedAnimation(parent: _bottomController!, curve: Curves.easeOutBack),
    );
    
    if (mounted) {
      setState(() {
        _isAnimationsInitialized = true;
      });
    }

    _headerController?.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _listController?.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _bottomController?.forward();
    });
  }

  @override
  void dispose() {
    _headerController?.dispose();
    _listController?.dispose();
    _bottomController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAnimationsInitialized) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[700],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Shopping Cart',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedBuilder(
          animation: _headerController!,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _headerSlideAnimation!.value),
              child: _buildAnimatedOpacity(_headerFadeAnimation!.value, child),
            );
          },
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Shopping Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  if (cart.items.isEmpty) return const SizedBox();
                  
                  return IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => _showClearCartDialog(context),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),

      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return _buildEmptyCart(context, screenWidth);
          }

          return Column(
            children: [
              // Animated Summary Card
              AnimatedBuilder(
                animation: _listController!,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _listSlideAnimation!.value),
                    child: _buildAnimatedOpacity(_listController!.value, child),
                  );
                },
                child: _buildSummaryCard(cart, screenWidth),
              ),

              // Animated Cart Items List
              Expanded(
                child: AnimatedBuilder(
                  animation: _listController!,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _listSlideAnimation!.value * 0.5),
                      child: _buildAnimatedOpacity(_listController!.value, child),
                    );
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return _buildAnimatedCartItem(item, index);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // Bottom Bar
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) return const SizedBox.shrink();
          
          return AnimatedBuilder(
            animation: _bottomController!,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _bottomSlideAnimation!.value),
                child: _buildCheckoutBar(context, cart, screenWidth),
              );
            },
          );
        },
      ),
    );
  }

  // ✅ Safe Opacity Widget
  Widget _buildAnimatedOpacity(double value, Widget? child) {
    // Ensure opacity is within 0.0 to 1.0 range
    final safeOpacity = value.clamp(0.0, 1.0);
    return Opacity(
      opacity: safeOpacity,
      child: child,
    );
  }

  Widget _buildAnimatedCartItem(CartItem item, int index) {
    return TweenAnimationBuilder<double>(
      key: ValueKey('cart_item_${item.laptop.id}_${item.quantity}_${index}'),
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        // ✅ Clamp value to 0.0-1.0 range
        final safeValue = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: safeValue,
          child: _buildAnimatedOpacity(safeValue, CartItemCard(item: item)),
        );
      },
    );
  }

  Widget _buildEmptyCart(BuildContext context, double screenWidth) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        // ✅ Clamp value to 0.0-1.0 range
        final safeValue = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: safeValue,
          child: _buildAnimatedOpacity(
            safeValue,
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth < 360 ? 140 : 160,
                    height: screenWidth < 360 ? 140 : 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey[100]!, Colors.grey[50]!],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: screenWidth < 360 ? 70 : 80,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  const Text(
                    'Your Cart is Empty',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    'Add some items to get started!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[700]!, Colors.blue[600]!],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Continue Shopping',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(CartProvider cart, double screenWidth) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.white],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue[100]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Total Items',
            value: '${cart.totalItems}',
            color: Colors.blue,
          ),
          Container(
            height: 50,
            width: 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.grey[300]!,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          _buildSummaryItem(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Subtotal',
            value: '₹${cart.totalAmount.toStringAsFixed(2)}',
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar(
      BuildContext context, CartProvider cart, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[50]!, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildPriceRow(
                      'Subtotal',
                      '₹${cart.totalAmount.toStringAsFixed(2)}',
                      false,
                    ),
                    const SizedBox(height: 8),
                    _buildPriceRow(
                      'Delivery',
                      'Free',
                      false,
                      valueColor: Colors.green,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1),
                    ),
                    _buildPriceRow(
                      'Total',
                      '₹${cart.totalAmount.toStringAsFixed(2)}',
                      true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[600]!],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _navigateToCheckout(context, cart),
                    borderRadius: BorderRadius.circular(16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isBold,
      {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 18 : 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? Colors.black87 : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? (isBold ? Colors.blue[700] : Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange[700],
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Clear Cart?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    context.read<CartProvider>().clearCart();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Cart cleared successfully'),
                        backgroundColor: Colors.orange[700],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(8),
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

  // ✅ **UPDATED: Navigate to Checkout Screen**
  void _navigateToCheckout(BuildContext context, CartProvider cart) {
    // Cart items ko direct navigate karenge
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartItems: cart.items,
          totalAmount: cart.totalAmount,
        ),
      ),
    );
  }

  // ✅ **UPDATED: Checkout Dialog (Optional)**
  void _showCheckoutDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[400]!, Colors.green[600]!],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Ready to Checkout?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${cart.totalItems} items',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: ₹${cart.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Proceed to checkout?',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Review Cart',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.blue[600]!],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _navigateToCheckout(context, cart);
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Proceed',
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
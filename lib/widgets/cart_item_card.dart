// // import 'package:flutter/material.dart';
// // import '../models/cart_item_model.dart';
// // import '../providers/cart_provider.dart';
// // import 'package:provider/provider.dart';

// // class CartItemCard extends StatelessWidget {
// //   final CartItem item;
  
// //   const CartItemCard({
// //     super.key,
// //     required this.item,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
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
                  
// //                   const SizedBox(height: 8),
                  
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         '₹${(item.price * item.quantity).toStringAsFixed(2)}',
// //                         style: const TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.green,
// //                         ),
// //                       ),
                      
// //                       // Quantity controls
// //                       Row(
// //                         children: [
// //                           IconButton(
// //                             icon: const Icon(Icons.remove),
// //                             onPressed: () {
// //                               if (item.quantity > 1) {
// //                                 cartProvider.updateQuantity(item.laptop.id, item.quantity - 1);
// //                               } else {
// //                                 cartProvider.removeFromCart(item.laptop.id);
// //                               }
// //                             },
// //                           ),
                          
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// //                             decoration: BoxDecoration(
// //                               border: Border.all(color: Colors.grey),
// //                               borderRadius: BorderRadius.circular(4),
// //                             ),
// //                             child: Text(
// //                               '${item.quantity}',
// //                               style: const TextStyle(fontSize: 16),
// //                             ),
// //                           ),
                          
// //                           IconButton(
// //                             icon: const Icon(Icons.add),
// //                             onPressed: () {
// //                               cartProvider.updateQuantity(item.laptop.id, item.quantity + 1);
// //                             },
// //                           ),
                          
// //                           IconButton(
// //                             icon: const Icon(Icons.delete_outline, color: Colors.red),
// //                             onPressed: () {
// //                               cartProvider.removeFromCart(item.laptop.id);
// //                             },
// //                           ),
// //                         ],
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
// import '../models/cart_item_model.dart';
// import '../providers/cart_provider.dart';
// import 'package:provider/provider.dart';

// class CartItemCard extends StatefulWidget {
//   final CartItem item;

//   const CartItemCard({
//     super.key,
//     required this.item,
//   });

//   @override
//   State<CartItemCard> createState() => _CartItemCardState();
// }

// class _CartItemCardState extends State<CartItemCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   bool _isDeleting = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _animateDelete(Function deleteAction) async {
//     setState(() => _isDeleting = true);
//     await _controller.reverse();
//     deleteAction();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final totalPrice = widget.item.price * widget.item.quantity;
//     final hasDiscount = widget.item.laptop.discount > 0;

//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white,
//                 Colors.grey[50]!,
//               ],
//             ),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 15,
//                 offset: const Offset(0, 5),
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 // Main Content
//                 Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Row(
//                     children: [
//                       // Image with Gradient Border
//                       Hero(
//                         tag: 'cart_${widget.item.laptop.id}',
//                         child: Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16),
//                                 gradient: LinearGradient(
//                                   colors: [Colors.grey[100]!, Colors.grey[50]!],
//                                 ),
//                                 border: Border.all(
//                                   color: Colors.grey[200]!,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(15),
//                                 child: Image.network(
//                                   widget.item.laptop.imageUrl,
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => Container(
//                                     width: 100,
//                                     height: 100,
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Colors.grey[200]!,
//                                           Colors.grey[100]!
//                                         ],
//                                       ),
//                                     ),
//                                     child: const Icon(
//                                       Icons.laptop_mac,
//                                       size: 50,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             // Discount Badge
//                             if (hasDiscount)
//                               Positioned(
//                                 top: 6,
//                                 left: 6,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 6,
//                                     vertical: 3,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     gradient: const LinearGradient(
//                                       colors: [
//                                         Color(0xFFFF416C),
//                                         Color(0xFFFF4B2B)
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(6),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.red.withOpacity(0.3),
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Text(
//                                     '-${widget.item.laptop.discount.toStringAsFixed(0)}%',
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 9,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(width: 14),

//                       // Details
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Brand Badge
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 3,
//                               ),
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.blue[700]!.withOpacity(0.1),
//                                     Colors.blue[600]!.withOpacity(0.05),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(6),
//                                 border: Border.all(
//                                   color: Colors.blue[700]!.withOpacity(0.3),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Text(
//                                 widget.item.laptop.brand.toUpperCase(),
//                                 style: TextStyle(
//                                   fontSize: 9,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.blue[700],
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 6),

//                             // Name
//                             Text(
//                               widget.item.laptop.name,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                                 height: 1.2,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 8),

//                             // Price Row
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 // Price
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     if (hasDiscount)
//                                       Text(
//                                         '₹${widget.item.laptop.originalPrice.toStringAsFixed(0)}',
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: Colors.grey[500],
//                                           decoration:
//                                               TextDecoration.lineThrough,
//                                         ),
//                                       ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.baseline,
//                                       textBaseline: TextBaseline.alphabetic,
//                                       children: [
//                                         Text(
//                                           '₹${totalPrice.toStringAsFixed(0)}',
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.blue[700],
//                                           ),
//                                         ),
//                                         if (widget.item.quantity > 1)
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 4),
//                                             child: Text(
//                                               '(x${widget.item.quantity})',
//                                               style: TextStyle(
//                                                 fontSize: 11,
//                                                 color: Colors.grey[600],
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),

//                                 // Quantity Controls
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [Colors.grey[50]!, Colors.white],
//                                     ),
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: Colors.grey[300]!,
//                                       width: 1.5,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.05),
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       // Minus Button
//                                       _buildQuantityButton(
//                                         icon: Icons.remove,
//                                         onPressed: () {
//                                           if (widget.item.quantity > 1) {
//                                             cartProvider.updateQuantity(
//                                               widget.item.laptop.id,
//                                               widget.item.quantity - 1,
//                                             );
//                                           } else {
//                                             _animateDelete(() {
//                                               cartProvider.removeFromCart(
//                                                   widget.item.laptop.id);
//                                             });
//                                           }
//                                         },
//                                         isEnabled: true,
//                                       ),

//                                       // Quantity Display
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 10,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           border: Border(
//                                             left: BorderSide(
//                                               color: Colors.grey[300]!,
//                                               width: 1,
//                                             ),
//                                             right: BorderSide(
//                                               color: Colors.grey[300]!,
//                                               width: 1,
//                                             ),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           '${widget.item.quantity}',
//                                           style: const TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black87,
//                                           ),
//                                         ),
//                                       ),

//                                       // Plus Button
//                                       _buildQuantityButton(
//                                         icon: Icons.add,
//                                         onPressed: () {
//                                           cartProvider.updateQuantity(
//                                             widget.item.laptop.id,
//                                             widget.item.quantity + 1,
//                                           );
//                                         },
//                                         isEnabled: true,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Delete Button (Top Right)
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {
//                         _showDeleteDialog(context, cartProvider);
//                       },
//                       borderRadius: BorderRadius.circular(20),
//                       child: Container(
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Colors.red.withOpacity(0.3),
//                             width: 1.5,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.red.withOpacity(0.2),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: const Icon(
//                           Icons.close_rounded,
//                           color: Colors.red,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Quantity Button Widget
//   Widget _buildQuantityButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//     required bool isEnabled,
//   }) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(11),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.all(6),
//           child: Icon(
//             icon,
//             size: 16,
//             color: isEnabled ? Colors.blue[700] : Colors.grey[400],
//           ),
//         ),
//       ),
//     );
//   }

// ignore_for_file: unnecessary_null_comparison

//   // Delete Confirmation Dialog
//   void _showDeleteDialog(BuildContext context, CartProvider cartProvider) {
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
//                 color: Colors.red[50],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 Icons.warning_amber_rounded,
//                 color: Colors.red[700],
//                 size: 28,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const Expanded(
//               child: Text(
//                 'Remove Item?',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           'Are you sure you want to remove "${widget.item.laptop.name}" from your cart?',
//           style: const TextStyle(fontSize: 14),
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
//                 colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                   _animateDelete(() {
//                     cartProvider.removeFromCart(widget.item.laptop.id);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content:
//                             Text('${widget.item.laptop.name} removed from cart'),
//                         backgroundColor: Colors.red[700],
//                         behavior: SnackBarBehavior.floating,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     );
//                   });
//                 },
//                 borderRadius: BorderRadius.circular(8),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Text(
//                     'Remove',
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
import '../models/cart_item_model.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatefulWidget {
  final CartItem item;

  const CartItemCard({
    super.key,
    required this.item,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animateDelete(Function deleteAction) async {
    if (!mounted) return;
    
    setState(() => _isDeleting = true);
    await _controller.reverse();
    if (mounted) {
      deleteAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDeleting) {
      return const SizedBox.shrink();
    }
    
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final totalPrice = widget.item.price * widget.item.quantity;
    final hasDiscount = widget.item.laptop.discount > 0;

    // ✅ null check for laptop
    if (widget.item.laptop.id == null || widget.item.laptop.id.isEmpty) {
      return const SizedBox.shrink();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey[50]!,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Main Content
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      // Image with Gradient Border
                      Hero(
                        tag: 'cart_${widget.item.laptop.id}',
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [Colors.grey[100]!, Colors.grey[50]!],
                                ),
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  widget.item.laptop.imageUrl.isNotEmpty
                                      ? widget.item.laptop.imageUrl
                                      : 'https://via.placeholder.com/100x100?text=No+Image',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.grey[200]!,
                                          Colors.grey[100]!
                                        ],
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.laptop_mac,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[100],
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Discount Badge
                            if (hasDiscount && widget.item.laptop.discount > 0)
                              Positioned(
                                top: 6,
                                left: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFF416C),
                                        Color(0xFFFF4B2B)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '-${widget.item.laptop.discount.toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Brand Badge
                            if (widget.item.laptop.brand.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue[700]!.withOpacity(0.1),
                                      Colors.blue[600]!.withOpacity(0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.blue[700]!.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  widget.item.laptop.brand.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue[700],
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            if (widget.item.laptop.brand.isNotEmpty)
                              const SizedBox(height: 6),

                            // Name
                            Text(
                              widget.item.laptop.name.isNotEmpty
                                  ? widget.item.laptop.name
                                  : 'Unknown Product',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),

                            // Price Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Price
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (hasDiscount && widget.item.laptop.originalPrice > 0)
                                      Text(
                                        '₹${widget.item.laptop.originalPrice.toStringAsFixed(0)}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[500],
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '₹${totalPrice.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[700],
                                          ),
                                        ),
                                        if (widget.item.quantity > 1)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            child: Text(
                                              '(x${widget.item.quantity})',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Quantity Controls
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.grey[50]!, Colors.white],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Minus Button
                                      _buildQuantityButton(
                                        icon: Icons.remove,
                                        onPressed: () {
                                          if (widget.item.quantity > 1) {
                                            cartProvider.updateQuantity(
                                              widget.item.laptop.id,
                                              widget.item.quantity - 1,
                                            );
                                          } else {
                                            _animateDelete(() {
                                              cartProvider.removeFromCart(
                                                  widget.item.laptop.id);
                                            });
                                          }
                                        },
                                        isEnabled: true,
                                      ),

                                      // Quantity Display
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              color: Colors.grey[300]!,
                                              width: 1,
                                            ),
                                            right: BorderSide(
                                              color: Colors.grey[300]!,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          '${widget.item.quantity}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),

                                      // Plus Button
                                      _buildQuantityButton(
                                        icon: Icons.add,
                                        onPressed: () {
                                          cartProvider.updateQuantity(
                                            widget.item.laptop.id,
                                            widget.item.quantity + 1,
                                          );
                                        },
                                        isEnabled: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Delete Button (Top Right)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _showDeleteDialog(context, cartProvider);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Quantity Button Widget
  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(11),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 16,
            color: isEnabled ? Colors.blue[700] : Colors.grey[400],
          ),
        ),
      ),
    );
  }

  // Delete Confirmation Dialog
  void _showDeleteDialog(BuildContext context, CartProvider cartProvider) {
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
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.red[700],
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Remove Item?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
        content: Text(
          widget.item.laptop.name.isNotEmpty
              ? 'Are you sure you want to remove "${widget.item.laptop.name}" from your cart?'
              : 'Are you sure you want to remove this item from your cart?',
          style: const TextStyle(fontSize: 14),
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
                colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _animateDelete(() {
                    cartProvider.removeFromCart(widget.item.laptop.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            widget.item.laptop.name.isNotEmpty
                                ? '${widget.item.laptop.name} removed from cart'
                                : 'Item removed from cart',
                          ),
                          backgroundColor: Colors.red[700],
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Remove',
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
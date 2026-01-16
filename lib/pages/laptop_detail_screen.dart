// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';

// class LaptopDetailScreen extends StatefulWidget {
//   final LaptopModel laptop;

//   const LaptopDetailScreen({super.key, required this.laptop});

//   @override
//   State<LaptopDetailScreen> createState() => _LaptopDetailScreenState();
// }

// class _LaptopDetailScreenState extends State<LaptopDetailScreen> {
//   bool isFavorite = false;
//   int quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Product Details'),
//         actions: [
//           IconButton(
//             icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.black),
//             onPressed:
//              () => setState(() => isFavorite = !isFavorite),
//           ),
//           IconButton(icon: const Icon(Icons.share), onPressed: () {}),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image
//             Container(
//               height: 350,
//               width: double.infinity,
//               color: Colors.grey[100],
//               child: Image.network(
//                 widget.laptop.imageUrl,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.laptop_mac, size: 100, color: Colors.grey)),
//               ),
//             ),
            
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Brand & Category
//                   Row(
//                     children: [
//                       _buildBadge(widget.laptop.brand, Colors.blue),
//                       const SizedBox(width: 8),
//                       _buildBadge(widget.laptop.category, _getCategoryColor(widget.laptop.category)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
                  
//                   // Name
//                   Text(widget.laptop.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.2)),
//                   const SizedBox(height: 12),
                  
//                   // Rating
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.amber[600], size: 24),
//                       const SizedBox(width: 6),
//                       Text(widget.laptop.rating.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       const SizedBox(width: 8),
//                       Text('(${widget.laptop.reviews} reviews)', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
                  
//                   // Price
//                   if (widget.laptop.discount > 0) ...[
//                     Text('Rs ${widget.laptop.originalPrice.toStringAsFixed(0)}', style: TextStyle(fontSize: 18, color: Colors.grey[500], decoration: TextDecoration.lineThrough)),
//                     const SizedBox(height: 8),
//                   ],
//                   Text('Rs ${widget.laptop.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[700])),
//                   const SizedBox(height: 24),
                  
//                   // Specs
//                   const Text('Specifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 12),
//                   _buildSpec(Icons.memory, 'Processor', widget.laptop.processor),
//                   _buildSpec(Icons.storage, 'RAM', '${widget.laptop.ram}GB'),
//                   _buildSpec(Icons.sd_storage, 'Storage', '${widget.laptop.storage}GB SSD'),
//                   _buildSpec(Icons.monitor, 'Display', widget.laptop.display),
//                   const SizedBox(height: 24),
                  
//                   // Features
//                   if (widget.laptop.features.isNotEmpty) ...[
//                     const Text('Key Features', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: widget.laptop.features.map((f) => Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Icons.check_circle, size: 16, color: Colors.green[600]),
//                             const SizedBox(width: 6),
//                             Text(f, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//                           ],
//                         ),
//                       )).toList(),
//                     ),
//                     const SizedBox(height: 24),
//                   ],
                  
//                   // Quantity
//                   const Text('Quantity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       _buildQuantityButton(Icons.remove, () {
//                         if (quantity > 1) setState(() => quantity--);
//                       }),
//                       Container(width: 60, alignment: Alignment.center, child: Text(quantity.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
//                       _buildQuantityButton(Icons.add, () => setState(() => quantity++), filled: true),
//                     ],
//                   ),
//                   const SizedBox(height: 80),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
      
//       // Bottom Buttons
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
//         ),
//         child: SafeArea(
//           child: Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: widget.laptop.inStock ? () {} : null,
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     side: BorderSide(color: Colors.blue[700]!, width: 2),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: Text('Add to Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: widget.laptop.inStock ? () {} : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[700],
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: const Text('Buy Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
//       child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
//     );
//   }

//   Widget _buildSpec(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
//             child: Icon(icon, size: 24, color: Colors.grey[700]),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
//                 const SizedBox(height: 2),
//                 Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuantityButton(IconData icon, VoidCallback onTap, {bool filled = false}) {
//     return IconButton(
//       onPressed: onTap,
//       icon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: filled ? Colors.blue[700] : Colors.transparent,
//           border: filled ? null : Border.all(color: Colors.grey[300]!),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(icon, size: 20, color: filled ? Colors.white : Colors.black),
//       ),
//     );
//   }

//   Color _getCategoryColor(String category) {
//     switch (category.toLowerCase()) {
//       case 'premium': return Colors.purple;
//       case 'gaming': return Colors.red;
//       case 'business': return Colors.blue;
//       case 'budget': return Colors.green;
//       default: return Colors.grey;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/providers/cart_provider.dart';
import 'package:laptop_harbor/providers/wishlist_provider.dart';

class LaptopDetailScreen extends StatefulWidget {
  final LaptopModel laptop;

  const LaptopDetailScreen({super.key, required this.laptop});

  @override
  State<LaptopDetailScreen> createState() => _LaptopDetailScreenState();
}

class _LaptopDetailScreenState extends State<LaptopDetailScreen> {
  int quantity = 1;
  bool _isUpdatingWishlist = false;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    
    final isInWishlist = wishlistProvider.isInWishlist(widget.laptop.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Product Details'),
        actions: [
          // ✅ Updated Wishlist Button with Provider
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist ? Colors.red : Colors.black,
                ),
                onPressed: _isUpdatingWishlist 
                    ? null 
                    : () async {
                        setState(() => _isUpdatingWishlist = true);
                        try {
                          await wishlistProvider.toggleWishlist(widget.laptop.id);
                          
                          // Show feedback
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isInWishlist 
                                  ? 'Removed from wishlist'
                                  : 'Added to wishlist',
                              ),
                              backgroundColor: isInWishlist ? Colors.red : Colors.green,
                              duration: const Duration(milliseconds: 800),
                            ),
                          );
                        } finally {
                          if (mounted) {
                            setState(() => _isUpdatingWishlist = false);
                          }
                        }
                      },
              ),
              if (_isUpdatingWishlist)
                Positioned.fill(
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.share), 
            onPressed: () {
              // Share functionality
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 350,
              width: double.infinity,
              color: Colors.grey[100],
              child: Image.network(
                widget.laptop.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.laptop_mac, size: 100, color: Colors.grey)
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand & Category
                  Row(
                    children: [
                      _buildBadge(widget.laptop.brand, Colors.blue),
                      const SizedBox(width: 8),
                      _buildBadge(widget.laptop.category, _getCategoryColor(widget.laptop.category)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Name
                  Text(
                    widget.laptop.name, 
                    style: const TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.bold, 
                      height: 1.2
                    )
                  ),
                  const SizedBox(height: 12),
                  
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[600], size: 24),
                      const SizedBox(width: 6),
                      Text(
                        widget.laptop.rating.toString(), 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${widget.laptop.reviews} reviews)', 
                        style: TextStyle(fontSize: 16, color: Colors.grey[600])
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Price
                  if (widget.laptop.discount > 0) ...[
                    Text(
                      'Rs ${widget.laptop.originalPrice.toStringAsFixed(0)}', 
                      style: TextStyle(
                        fontSize: 18, 
                        color: Colors.grey[500], 
                        decoration: TextDecoration.lineThrough
                      )
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    'Rs ${widget.laptop.price.toStringAsFixed(0)}', 
                    style: TextStyle(
                      fontSize: 32, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.blue[700]
                    )
                  ),
                  const SizedBox(height: 24),
                  
                  // Stock Status
                  if (!widget.laptop.inStock)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.red[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Specs
                  const Text(
                    'Specifications', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  _buildSpec(Icons.memory, 'Processor', widget.laptop.processor),
                  _buildSpec(Icons.storage, 'RAM', '${widget.laptop.ram}GB'),
                  _buildSpec(Icons.sd_storage, 'Storage', '${widget.laptop.storage}GB SSD'),
                  _buildSpec(Icons.monitor, 'Display', widget.laptop.display),
                  const SizedBox(height: 24),
                  
                  // Features
                  if (widget.laptop.features.isNotEmpty) ...[
                    const Text(
                      'Key Features', 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.laptop.features.map((f) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100], 
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, size: 16, color: Colors.green[600]),
                            const SizedBox(width: 6),
                            Text(f, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Quantity
                  const Text(
                    'Quantity', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildQuantityButton(Icons.remove, () {
                        if (quantity > 1) setState(() => quantity--);
                      }),
                      Container(
                        width: 60, 
                        alignment: Alignment.center, 
                        child: Text(
                          quantity.toString(), 
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                        )
                      ),
                      _buildQuantityButton(Icons.add, () => setState(() => quantity++), filled: true),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // ✅ Updated Bottom Buttons with Provider
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), 
              blurRadius: 10, 
              offset: const Offset(0, -5)
            )
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // ✅ Add to Cart Button
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.laptop.inStock ? () {
                    // Add to cart with quantity
                    for (int i = 0; i < quantity; i++) {
                      cartProvider.addToCart(widget.laptop);
                    }
                    
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          quantity > 1 
                            ? 'Added $quantity ${widget.laptop.name} to cart'
                            : 'Added ${widget.laptop.name} to cart',
                        ),
                        backgroundColor: Colors.green,
                        duration: const Duration(milliseconds: 1500),
                        action: SnackBarAction(
                          label: 'View Cart',
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/cart');
                          },
                        ),
                      ),
                    );
                  } : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                      color: widget.laptop.inStock 
                        ? Colors.blue[700]! 
                        : Colors.grey[300]!,
                      width: 2
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                  child: Text(
                    'Add to Cart', 
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: widget.laptop.inStock 
                        ? Colors.blue[700] 
                        : Colors.grey[400]
                    )
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // ✅ Buy Now Button
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.laptop.inStock ? () {
                    // Add to cart first
                    for (int i = 0; i < quantity; i++) {
                      cartProvider.addToCart(widget.laptop);
                    }
                    
                    // Navigate to checkout/cart
                    Navigator.pushNamed(context, '/cart');
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.laptop.inStock 
                      ? Colors.blue[700] 
                      : Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                  child: Text(
                    'Buy Now', 
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: widget.laptop.inStock 
                        ? Colors.white 
                        : Colors.grey[500]
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1), 
        borderRadius: BorderRadius.circular(8)
      ),
      child: Text(
        text, 
        style: TextStyle(
          color: color, 
          fontWeight: FontWeight.bold, 
          fontSize: 14
        )
      ),
    );
  }

  Widget _buildSpec(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100], 
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(icon, size: 24, color: Colors.grey[700]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap, {bool filled = false}) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: filled ? Colors.blue[700] : Colors.transparent,
          border: filled ? null : Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon, 
          size: 20, 
          color: filled ? Colors.white : Colors.black
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'premium': return Colors.purple;
      case 'gaming': return Colors.red;
      case 'business': return Colors.blue;
      case 'budget': return Colors.green;
      default: return Colors.grey;
    }
  }
}
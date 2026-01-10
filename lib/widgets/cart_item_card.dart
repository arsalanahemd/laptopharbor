// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';


// class CartItemCard extends StatelessWidget {
//   final LaptopModel laptop;
//   final int quantity;
//   final Function(int) onQuantityChanged;
//   final VoidCallback onRemove;

//   const CartItemCard({
//     required this.laptop,
//     required this.quantity,
//     required this.onQuantityChanged,
//     required this.onRemove,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Laptop Image
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               laptop.imageUrl,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 16),
//           // Laptop Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Name + Remove button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         laptop.name,
//                         style: const TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.red, size: 22),
//                       onPressed: onRemove,
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   laptop.brand,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${laptop.ram}GB RAM • ${laptop.storage}GB SSD',
//                   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                 ),
//                 const SizedBox(height: 8),
//                 // Price + Quantity Controls
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '\$${laptop.price}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[700],
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey[300]!),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           // Minus Button
//                           IconButton(
//                             icon: const Icon(Icons.remove, size: 20),
//                             onPressed: () => onQuantityChanged(quantity - 1),
//                             padding: const EdgeInsets.all(4),
//                             constraints: const BoxConstraints(),
//                           ),
//                           // Quantity Text
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 10),
//                             child: Text(
//                               '$quantity',
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           // Plus Button
//                           IconButton(
//                             icon: const Icon(Icons.add, size: 20),
//                             onPressed: () => onQuantityChanged(quantity + 1),
//                             padding: const EdgeInsets.all(4),
//                             constraints: const BoxConstraints(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../models/laptop_model.dart';

// class CartItemCard extends StatelessWidget {
//   final LaptopModel laptop;
//   final int quantity;
//   final Function(int) onQuantityChanged;
//   final VoidCallback onRemove;

//   const CartItemCard({
//     required this.laptop,
//     required this.quantity,
//     required this.onQuantityChanged,
//     required this.onRemove,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Laptop Image (Web-friendly)
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.network(
//               laptop.imageUrl, // <-- URL use karo
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) => Container(
//                 width: 100,
//                 height: 100,
//                 color: Colors.grey[200],
//                 child: const Icon(Icons.error, color: Colors.red),
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),

//           // Laptop Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Name + Remove button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         laptop.name,
//                         style: const TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.red, size: 22),
//                       onPressed: onRemove,
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   laptop.brand,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${laptop.ram}GB RAM • ${laptop.storage}GB SSD',
//                   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                 ),
//                 const SizedBox(height: 8),

//                 // Price + Quantity Controls
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '\$${laptop.price}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[700],
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey[300]!),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           // Minus Button
//                           IconButton(
//                             icon: const Icon(Icons.remove, size: 20),
//                             onPressed: quantity > 1
//                                 ? () => onQuantityChanged(quantity - 1)
//                                 : null, // prevent negative
//                             padding: const EdgeInsets.all(4),
//                             constraints: const BoxConstraints(),
//                           ),

//                           // Quantity Text
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Text(
//                               '$quantity',
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ),

//                           // Plus Button
//                           IconButton(
//                             icon: const Icon(Icons.add, size: 20),
//                             onPressed: () => onQuantityChanged(quantity + 1),
//                             padding: const EdgeInsets.all(4),
//                             constraints: const BoxConstraints(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/laptop_model.dart';

class CartItemCard extends StatelessWidget {
  final LaptopModel laptop;
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    required this.laptop,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = laptop.price * quantity;
    final hasDiscount = laptop.discount > 0;

    return Container(
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
                  // Laptop Image with Badge
                  Stack(
                    children: [
                      // Image Container
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
                            laptop.imageUrl,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.grey[200]!, Colors.grey[100]!],
                                ),
                              ),
                              child: const Icon(
                                Icons.laptop_mac,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      // Discount Badge
                      if (hasDiscount)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              // '-${laptop.discount.toStringAsFixed(0)}%',
                              "${laptop.discount.toStringAsFixed(0)}% OFF",

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
                  const SizedBox(width: 14),

                  // Laptop Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand Badge
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
                            laptop.brand.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Laptop Name
                        Text(
                          laptop.name,
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

                        // Specs Row
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _buildSpecChip(
                              Icons.memory,
                              '${laptop.ram}GB',
                            ),
                            _buildSpecChip(
                              Icons.sd_storage,
                              '${laptop.storage}GB',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Price Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Price Column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (hasDiscount)
                                  Text(
                                    // 'Rs ${laptop.originalPrice.toStringAsFixed(0)}',
                                    "${laptop.discount.toStringAsFixed(0)}% OFF",

                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[500],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'Rs ${totalPrice.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                    if (quantity > 1)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          '(x$quantity)',
                                          style: TextStyle(
                                            fontSize: 12,
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
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: quantity > 1
                                          ? () => onQuantityChanged(quantity - 1)
                                          : null,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(11),
                                        bottomLeft: Radius.circular(11),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.remove,
                                          size: 18,
                                          color: quantity > 1
                                              ? Colors.blue[700]
                                              : Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Quantity Display
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
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
                                      '$quantity',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),

                                  // Plus Button
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => onQuantityChanged(quantity + 1),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(11),
                                        bottomRight: Radius.circular(11),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.add,
                                          size: 18,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ),
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

            // Remove Button (Top Right)
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onRemove,
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
    );
  }

  // Spec Chip Widget
  Widget _buildSpecChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[100]!, Colors.grey[50]!],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
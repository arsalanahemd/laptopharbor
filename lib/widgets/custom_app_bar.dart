
// // import 'package:flutter/material.dart';
// // import 'package:laptop_harbor/pages/cart_page.dart';
// // import 'package:provider/provider.dart';
// // import '../providers/cart_provider.dart';

// // class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
// //   final bool isSearchOpen;
// //   final TextEditingController searchController;
// //   final ValueChanged<String> onSearchChanged;
// //   final VoidCallback onSearchToggle;
// //   final VoidCallback onFilterClick;
// //   final VoidCallback onMenuClick;
// //   final VoidCallback onCartClick;
// //   final String title;
// //   final String subtitle;

// //   const CustomAppBar({
// //     super.key,
// //     required this.isSearchOpen,
// //     required this.searchController,
// //     required this.onSearchChanged,
// //     required this.onSearchToggle,
// //     required this.onFilterClick,
// //     required this.onMenuClick,
// //     required this.onCartClick,
// //     this.title = 'Laptop Harbor',
// //     this.subtitle = 'Premium Laptops', required int cartCount, required Null Function() onNotificationClick, required Null Function() onSearchClick, required Null Function() onClose,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     // ✅ Use Provider to get cart items
// //     final cartProvider = Provider.of<CartProvider>(context);

// //     return Container(
// //       color: const Color(0xFF1E293B),
// //       padding: const EdgeInsets.all(16),
// //       child: SafeArea(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             /// 🔹 TOP BAR
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 IconButton(
// //                   onPressed: onMenuClick,
// //                   icon: const Icon(Icons.menu, color: Colors.white),
// //                 ),

// //                 Column(
// //                   children: [
// //                     Text(
// //                       title,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     Text(
// //                       subtitle,
// //                       style: const TextStyle(
// //                         color: Colors.white70,
// //                         fontSize: 12,
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //                 // ✅ Cart Icon with Count
// //                 Stack(
// //                   children: [
// //                     IconButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (_) => const CartScreen()),
// //                         );
// //                       },
// //                       icon: const Icon(
// //                         Icons.shopping_cart,
// //                         color: Colors.white,
// //                       ), 
// //                     ),
// //                     if (cartProvider.items.isNotEmpty)
// //                       Positioned(
// //                         right: 4,
// //                         top: 4,
// //                         child: Container(
// //                           padding: const EdgeInsets.all(4),
// //                           decoration: const BoxDecoration(
// //                             color: Colors.red,
// //                             shape: BoxShape.circle,
// //                           ),
// //                           constraints: const BoxConstraints(
// //                             minWidth: 16,
// //                             minHeight: 16,
// //                           ),
// //                           child: Text(
// //                             '${cartProvider.items.length}',
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 11,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                             textAlign: TextAlign.center,
// //                           ),
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //               ],
// //             ),

// //             const SizedBox(height: 12),

// //             /// 🔍 SEARCH BAR
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: isSearchOpen
// //                       ? TextField(
// //                           controller: searchController,
// //                           autofocus: true,
// //                           onChanged: onSearchChanged,
// //                           style: const TextStyle(color: Colors.white),
// //                           decoration: const InputDecoration(
// //                             hintText: 'Search laptops...',
// //                             hintStyle: TextStyle(color: Colors.white54),
// //                             border: InputBorder.none,
// //                           ),
// //                         )
// //                       : InkWell(
// //                           onTap: onSearchToggle,
// //                           child: Row(
// //                             children: const [
// //                               Icon(Icons.search, color: Colors.white70),
// //                               SizedBox(width: 8),
// //                               Text(
// //                                 'Search laptops...',
// //                                 style: TextStyle(color: Colors.white70),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 IconButton(
// //                   onPressed: onFilterClick,
// //                   icon: const Icon(Icons.tune, color: Colors.white),
// //                 ),
// //                 if (isSearchOpen)
// //                   IconButton(
// //                     onPressed: onSearchToggle,
// //                     icon: const Icon(Icons.close, color: Colors.white),
// //                   ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Size get preferredSize => Size.fromHeight(isSearchOpen ? 140 : 120);
// // }
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/pages/cart_page.dart';
// import 'package:provider/provider.dart';
// import '../providers/cart_provider.dart';
// import 'dart:math' as math;

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   final bool isSearchOpen;
//   final TextEditingController searchController;
//   final ValueChanged<String> onSearchChanged;
//   final VoidCallback onSearchToggle;
//   final VoidCallback onFilterClick;
//   final VoidCallback onMenuClick;
//   final VoidCallback onCartClick;
//   final String title;
//   final String subtitle;
//   final bool isDarkTheme;
//   final ValueChanged<bool>? onThemeChanged;

//   const CustomAppBar({
//     super.key,
//     required this.isSearchOpen,
//     required this.searchController,
//     required this.onSearchChanged,
//     required this.onSearchToggle,
//     required this.onFilterClick,
//     required this.onMenuClick,
//     required this.onCartClick,
//     this.title = 'Laptop Harbor',
//     this.subtitle = 'Premium Laptops',
//     this.isDarkTheme = true,
//     this.onThemeChanged, required int cartCount, required Null Function() onNotificationClick, required Null Function() onSearchClick, required Null Function() onClose,
//   });

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();

//   @override
//   Size get preferredSize => Size.fromHeight(isSearchOpen ? 160 : 140);
// }

// class _CustomAppBarState extends State<CustomAppBar> with TickerProviderStateMixin {
//   late AnimationController _waveController;
//   late AnimationController _floatingController;
//   late AnimationController _pulseController;
//   late Animation<double> _floatingAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _waveController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();

//     _floatingController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     )..repeat(reverse: true);

//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);

//     _floatingAnimation = Tween<double>(begin: -5, end: 5).animate(
//       CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _waveController.dispose();
//     _floatingController.dispose();
//     _pulseController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);

//     return Stack(
//       children: [
//         // Animated gradient background
//         AnimatedBuilder(
//           animation: _waveController,
//           builder: (context, child) {
//             return Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: widget.isDarkTheme
//                       ? [
//                           const Color(0xFF1E293B),
//                           const Color(0xFF1E40AF),
//                           Color.lerp(
//                             const Color(0xFF1E40AF),
//                             const Color(0xFF3B82F6),
//                             (_waveController.value * 0.3),
//                           )!,
//                         ]
//                       : [
//                           const Color(0xFF3B82F6),
//                           const Color(0xFF60A5FA),
//                           Color.lerp(
//                             const Color(0xFF60A5FA),
//                             const Color(0xFF93C5FD),
//                             (_waveController.value * 0.3),
//                           )!,
//                         ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   stops: [0.0, 0.5, 1.0],
//                 ),
//               ),
//             );
//           },
//         ),

//         // Floating particles
//         ...List.generate(8, (index) => _buildFloatingParticle(index)),

//         // Main content
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildTopBar(cartProvider),
//                 const SizedBox(height: 16),
//                 _buildSearchBar(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFloatingParticle(int index) {
//     final random = math.Random(index);
//     final size = 3.0 + random.nextDouble() * 5;
//     final initialX = random.nextDouble() * 350;
//     final initialY = random.nextDouble() * 140;

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
//               color: Colors.white.withOpacity(0.1 + (index % 3) * 0.05),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.white.withOpacity(0.15),
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

//   Widget _buildTopBar(CartProvider cartProvider) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Menu Button with glass effect
//         _buildGlassButton(
//           icon: Icons.menu,
//           onPressed: widget.onMenuClick,
//         ),

//         // Title with gradient text
//         Expanded(
//           child: Column(
//             children: [
//               ShaderMask(
//                 shaderCallback: (bounds) => LinearGradient(
//                   colors: [
//                     Colors.white,
//                     widget.isDarkTheme ? Colors.blue[100]! : Colors.blue[50]!,
//                   ],
//                 ).createShader(bounds),
//                 child: Text(
//                   widget.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 widget.subtitle,
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.85),
//                   fontSize: 12,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Action buttons row
//         Row(
//           children: [
//             // // Theme Toggle Button
//             // _buildGlassButton(
//             //   icon: widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
//             //   onPressed: () {
//             //     if (widget.onThemeChanged != null) {
//             //       widget.onThemeChanged!(!widget.isDarkTheme);
//             //     }
//             //   },
//             // ),
//             // const SizedBox(width: 8),

//             // Cart Button with badge
//             _buildCartButton(cartProvider),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildGlassButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.2),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: onPressed,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Icon(
//               icon,
//               color: Colors.white,
//               size: 22,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCartButton(CartProvider cartProvider) {
//     return AnimatedBuilder(
//       animation: _pulseController,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: cartProvider.items.isNotEmpty
//               ? 1.0 + (_pulseController.value * 0.05)
//               : 1.0,
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.2),
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const CartScreen()),
//                       );
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Icon(
//                         Icons.shopping_cart_outlined,
//                         color: Colors.white,
//                         size: 22,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if (cartProvider.items.isNotEmpty)
//                 Positioned(
//                   right: -4,
//                   top: -4,
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
//                       ),
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white, width: 2),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.red.withOpacity(0.4),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 20,
//                       minHeight: 20,
//                     ),
//                     child: Center(
//                       child: Text(
//                         '${cartProvider.items.length}',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchBar() {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(widget.isDarkTheme ? 0.15 : 0.25),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: Colors.white.withOpacity(widget.isDarkTheme ? 0.2 : 0.3),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: widget.isSearchOpen
//                 ? TextField(
//                     controller: widget.searchController,
//                     autofocus: true,
//                     onChanged: widget.onSearchChanged,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: 'Search laptops...',
//                       hintStyle: TextStyle(
//                         color: Colors.white.withOpacity(0.6),
//                         fontSize: 15,
//                       ),
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.zero,
//                       isDense: true,
//                     ),
//                   )
//                 : InkWell(
//                     onTap: widget.onSearchToggle,
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.search,
//                           color: Colors.white.withOpacity(0.8),
//                           size: 20,
//                         ),
//                         const SizedBox(width: 12),
//                         Text(
//                           'Search laptops...',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.7),
//                             fontSize: 15,
//                             letterSpacing: 0.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//           const SizedBox(width: 8),

//           // Filter Button
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(10),
//                 onTap: widget.onFilterClick,
//                 child: const Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Icon(
//                     Icons.tune,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           if (widget.isSearchOpen) ...[
//             const SizedBox(width: 8),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(10),
//                   onTap: widget.onSearchToggle,
//                   child: const Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:laptop_harbor/pages/cart_page.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearchOpen;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchToggle;
  final VoidCallback onFilterClick;
  final VoidCallback onMenuClick;
  final VoidCallback onCartClick;
  final String title;
  final String subtitle;
  final bool isDarkTheme;
  final ValueChanged<bool>? onThemeChanged;

  const CustomAppBar({
    super.key,
    required this.isSearchOpen,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchToggle,
    required this.onFilterClick,
    required this.onMenuClick,
    required this.onCartClick,
    this.title = 'Laptop Harbor',
    this.subtitle = 'Premium Laptops',
    this.isDarkTheme = true,
    this.onThemeChanged,
    required int cartCount,
    required Null Function() onNotificationClick,
    required Null Function() onSearchClick,
    required Null Function() onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E40AF),
            Colors.blue[700]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return _buildTopBar(context, cartProvider);
                },
              ),
              const SizedBox(height: 14),
              _buildSearchBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, CartProvider cartProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Menu Button
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onMenuClick,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),

        // Title Section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Cart Button with Badge
        _buildCartButton(context, cartProvider),
      ],
    );
  }

  Widget _buildCartButton(BuildContext context, CartProvider cartProvider) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        if (cartProvider.items.isNotEmpty)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red[600],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Center(
                child: Text(
                  '${cartProvider.items.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: isSearchOpen
                ? TextField(
                    controller: searchController,
                    autofocus: true,
                    onChanged: onSearchChanged,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search laptops...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  )
                : InkWell(
                    onTap: onSearchToggle,
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Colors.grey[600],
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Search laptops...',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          
          // Filter Button
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onFilterClick,
              child: Icon(
                Icons.tune_rounded,
                color: Colors.blue[700],
                size: 20,
              ),
            ),
          ),

          if (isSearchOpen) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onSearchToggle,
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.red[700],
                  size: 20,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isSearchOpen ? 140 : 130);
}
// // import 'package:flutter/material.dart';
// // import 'package:laptop_harbor/data/laptop_data.dart';
// // import 'package:laptop_harbor/widgets/filter_dialog.dart';
// // import 'package:laptop_harbor/models/laptop_model.dart';
// // import 'package:laptop_harbor/widgets/laptop_card.dart';

// // class LaptopHomePage extends StatefulWidget {
// //   const LaptopHomePage({super.key});

// //   @override
// //   State<LaptopHomePage> createState() => _LaptopHomePageState();
// // }

// // class _LaptopHomePageState extends State<LaptopHomePage> with TickerProviderStateMixin {
// //   List<LaptopModel> laptops = [];
// //   List<LaptopModel> filteredLaptops = [];
// //   String selectedBrand = 'All';
// //   int _selectedIndex = 0;
  
// //   bool _isSearchOpen = false;
// //   final TextEditingController _searchController = TextEditingController();
// //   FilterOptions _filterOptions = FilterOptions();
  
// //   late AnimationController _searchAnimController;
// //   late Animation<double> _searchAnimation;
// //   late AnimationController _navController;
// //   late List<Animation<double>> _iconAnimations;
// //   late List<Animation<double>> _scaleAnimations;

// //   @override
// //   void initState() {
// //     super.initState();
// //     laptops = laptopData;
// //     filteredLaptops = laptops;

// //     _searchAnimController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 300),
// //     );
// //     _searchAnimation = Tween<double>(begin: 0, end: 1).animate(_searchAnimController);

// //     _navController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 300),
// //     );
// //     _iconAnimations = List.generate(3, (i) => 
// //       Tween<double>(begin: 0, end: 1).animate(
// //         CurvedAnimation(parent: _navController, curve: Interval(i * 0.2, 0.6 + (i * 0.2), curve: Curves.easeOutBack))
// //       )
// //     );
// //     _scaleAnimations = List.generate(3, (i) => 
// //       Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _navController, curve: Curves.easeOutBack))
// //     );
// //     _navController.forward();
// //   }

// //   void _filterByBrand(String brand) {
// //     setState(() {
// //       selectedBrand = brand;
// //       filteredLaptops = brand == 'All' 
// //         ? laptops 
// //         : laptops.where((l) => l.brand.toLowerCase() == brand.toLowerCase()).toList();
// //     });
// //   }

// //   void _toggleSearch() {
// //     setState(() {
// //       _isSearchOpen = !_isSearchOpen;
// //       _isSearchOpen ? _searchAnimController.forward() : _searchAnimController.reverse();
// //       if (!_isSearchOpen) {
// //         _searchController.clear();
// //         filteredLaptops = laptops;
// //       }
// //     });
// //   }

// //   void _onSearchChanged(String query) {
// //     setState(() {
// //       if (query.isEmpty) {
// //         filteredLaptops = laptops;
// //       } else {
// //         final q = query.toLowerCase();
// //         filteredLaptops = laptops.where((l) =>
// //           l.name.toLowerCase().contains(q) ||
// //           l.brand.toLowerCase().contains(q) ||
// //           l.processor.toLowerCase().contains(q)
// //         ).toList();
// //       }
// //     });
// //   }

// //   void _showFilterDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => FilterDialog(
// //         currentFilters: _filterOptions,
// //         onApply: (newFilters) {
// //           setState(() {
// //             _filterOptions = newFilters;
// //             filteredLaptops = _applyFilters(_searchController.text);
// //           });
// //         },
// //       ),
// //     );
// //   }

// //   List<LaptopModel> _applyFilters(String searchQuery) {
// //     var result = laptops;
    
// //     if (searchQuery.isNotEmpty) {
// //       final q = searchQuery.toLowerCase();
// //       result = result.where((l) => l.name.toLowerCase().contains(q) || 
// //         l.brand.toLowerCase().contains(q) || l.processor.toLowerCase().contains(q)).toList();
// //     }
    
// //     result = result.where((l) => 
// //       l.price >= _filterOptions.priceRange.start && l.price <= _filterOptions.priceRange.end).toList();
    
// //     if (_filterOptions.selectedBrands.isNotEmpty) {
// //       result = result.where((l) => _filterOptions.selectedBrands.contains(l.brand)).toList();
// //     }
    
// //     if (_filterOptions.selectedRamSizes.isNotEmpty) {
// //       result = result.where((l) => _filterOptions.selectedRamSizes.contains(l.ram)).toList();
// //     }
    
// //     return result;
// //   }

// //   void _onNavTap(int index) {
// //     if (_selectedIndex != index) {
// //       _navController.reset();
// //       _navController.forward();
// //       setState(() => _selectedIndex = index);
// //     }
// //   }

// //   List<LaptopModel> _getHotDeals() {
// //     var deals = laptops.where((l) => l.isHotDeal).toList();
// //     return deals.isEmpty ? laptops.where((l) => l.price < 100000).take(6).toList() : deals.take(6).toList();
// //   }

// //   List<LaptopModel> _getNewArrivals() {
// //     var items = laptops.where((l) => l.isNewArrival).toList();
// //     return items.isEmpty ? laptops.reversed.take(6).toList() : items.take(6).toList();
// //   }

// //   List<LaptopModel> _getMostSale() {
// //     var items = laptops.where((l) => l.isMostSale).toList();
// //     return items.isEmpty ? laptops.where((l) => l.discount > 10).take(6).toList() : items.take(6).toList();
// //   }

// //   List<LaptopModel> _getPremium() {
// //     var items = laptops.where((l) => l.category == 'Premium').toList();
// //     return items.isEmpty ? laptops.where((l) => l.price > 150000).take(6).toList() : items.take(6).toList();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: _buildAppBar(),
// //       body: _selectedIndex == 0 ? _buildHomePage() : _buildOtherPages(),
// //       bottomNavigationBar: _buildBottomNav(),
// //     );
// //   }

// //   PreferredSizeWidget _buildAppBar() {
// //     return AppBar(
// //       title: _isSearchOpen
// //           ? TextField(
// //               controller: _searchController,
// //               autofocus: true,
// //               onChanged: _onSearchChanged,
// //               style: const TextStyle(color: Colors.black),
// //               decoration: const InputDecoration(
// //                 hintText: 'Search laptops...',
// //                 border: InputBorder.none,
// //                 hintStyle: TextStyle(color: Colors.grey),
// //               ),
// //             )
// //           : const Text('Laptop Harbor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
// //       backgroundColor: Colors.white,
// //       foregroundColor: Colors.black,
// //       elevation: 0,
// //       actions: [
// //         IconButton(
// //           icon: Icon(_isSearchOpen ? Icons.close : Icons.search, size: 22),
// //           onPressed: _toggleSearch,
// //         ),
// //         Stack(
// //           children: [
// //             IconButton(
// //               icon: const Icon(Icons.filter_list, size: 22),
// //               onPressed: _showFilterDialog,
// //             ),
// //             if (_filterOptions.hasActiveFilters)
// //               Positioned(
// //                 right: 8,
// //                 top: 8,
// //                 child: Container(
// //                   width: 8,
// //                   height: 8,
// //                   decoration: const BoxDecoration(
// //                     color: Colors.red,
// //                     shape: BoxShape.circle,
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //         IconButton(
// //           icon: const Icon(Icons.shopping_cart_outlined, size: 22),
// //           onPressed: () {},
// //         ),
// //         const SizedBox(width: 4),
// //       ],
// //     );
// //   }

// //   Widget _buildHomePage() {
// //     final brands = ['All', ...laptops.map((l) => l.brand).toSet()];
    
// //     return SingleChildScrollView(
// //       child: Column(
// //         children: [
// //           _buildHeroBanner(),
// //           const SizedBox(height: 16),
// //           _buildSection('🔥 Hot Deals', 'Limited offers', _getHotDeals(), Colors.red),
// //           const SizedBox(height: 16),
// //           _buildSection('✨ New Arrivals', 'Latest products', _getNewArrivals(), Colors.blue),
// //           const SizedBox(height: 16),
// //           _buildSection('💰 Most Sale', 'Best sellers', _getMostSale(), Colors.green),
// //           const SizedBox(height: 16),
// //           _buildSection('💎 Premium', 'High-end laptops', _getPremium(), Colors.purple),
// //           const SizedBox(height: 16),
// //           _buildBrandFilter(brands),
// //           const SizedBox(height: 12),
// //           _buildAllProducts(),
// //           const SizedBox(height: 16),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildOtherPages() {
// //     return Center(
// //       child: Text(_selectedIndex == 1 ? 'Categories' : 'Profile', style: const TextStyle(fontSize: 20)),
// //     );
// //   }

// //   Widget _buildHeroBanner() {
// //     return Container(
// //       margin: const EdgeInsets.all(16),
// //       height: 160,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(16),
// //         gradient: LinearGradient(colors: [Colors.red[700]!, Colors.red[400]!]),
// //         boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
// //       ),
// //       child: Stack(
// //         children: [
// //           Positioned(
// //             right: -20,
// //             bottom: -20,
// //             child: Icon(Icons.laptop_mac, size: 150, color: Colors.white.withOpacity(0.15)),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(20),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 const Text('Special Offer', style: TextStyle(color: Colors.white, fontSize: 14)),
// //                 const SizedBox(height: 6),
// //                 const Text('Up to 30% OFF', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
// //                 const SizedBox(height: 4),
// //                 Text('On selected laptops', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSection(String title, String subtitle, List<LaptopModel> items, Color color) {
// //     if (items.isEmpty) return const SizedBox();
    
// //     return Column(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16),
// //           child: Row(
// //             children: [
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //                   Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
// //                 ],
// //               ),
// //               const Spacer(),
// //               TextButton(
// //                 onPressed: () {},
// //                 child: Row(
// //                   children: [
// //                     Text('View All', style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
// //                     const SizedBox(width: 4),
// //                     Icon(Icons.arrow_forward_ios, size: 12, color: color),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         SizedBox(
// //           height: 320,
// //           child: ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             itemCount: items.length,
// //             itemBuilder: (_, i) => Container(
// //               width: 190,
// //               margin: const EdgeInsets.only(right: 12),
// //               child: LaptopCard(
// //                 laptop: items[i],
// //                 onFavorite: () {},
// //                 onTap: () {
// //                   // ✅ Navigate to detail page
// //                   Navigator.pushNamed(
// //                     context,
// //                     '/details',
// //                     arguments: items[i],
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildBrandFilter(List<String> brands) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 16),
// //           child: Text('Shop by Brand', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //         ),
// //         const SizedBox(height: 10),
// //         SizedBox(
// //           height: 44,
// //           child: ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             itemCount: brands.length,
// //             itemBuilder: (_, i) {
// //               final brand = brands[i];
// //               final isSelected = selectedBrand == brand;
// //               return GestureDetector(
// //                 onTap: () => _filterByBrand(brand),
// //                 child: AnimatedContainer(
// //                   duration: const Duration(milliseconds: 300),
// //                   margin: const EdgeInsets.only(right: 10),
// //                   padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
// //                   decoration: BoxDecoration(
// //                     color: isSelected ? Colors.red : Colors.white,
// //                     borderRadius: BorderRadius.circular(22),
// //                     border: Border.all(color: isSelected ? Colors.red : Colors.grey[300]!, width: 2),
// //                     boxShadow: isSelected ? [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3))] : [],
// //                   ),
// //                   child: Text(brand, style: TextStyle(color: isSelected ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13)),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildAllProducts() {
// //     return Column(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16),
// //           child: Row(
// //             children: [
// //               const Text('All Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               const SizedBox(width: 8),
// //               Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
// //                 decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(10)),
// //                 child: Text('${filteredLaptops.length}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red[700])),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 10),
// //         LayoutBuilder(
// //           builder: (context, constraints) {
// //             int columns = 2;
// //             if (constraints.maxWidth > 900) columns = 4;
// //             else if (constraints.maxWidth > 600) columns = 3;
            
// //             return GridView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: columns,
// //                 childAspectRatio: 0.68,
// //                 crossAxisSpacing: 12,
// //                 mainAxisSpacing: 12,
// //               ),
// //               itemCount: filteredLaptops.length,
// //               itemBuilder: (_, i) => LaptopCard(
// //                 laptop: filteredLaptops[i],
// //                 onFavorite: () {},
// //                 onTap: () {
// //                   // ✅ Navigate to detail page
// //                   Navigator.pushNamed(
// //                     context,
// //                     '/details',
// //                     arguments: filteredLaptops[i],
// //                   );
// //                 },
// //               ),
// //             );
// //           },
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildBottomNav() {
// //     return Container(
// //       height: MediaQuery.of(context).size.width < 600 ? 65 : 70,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, -3))],
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //         children: [
// //           _buildNavItem(Icons.home_rounded, 'Home', 0),
// //           _buildNavItem(Icons.category_rounded, 'Category', 1),
// //           _buildNavItem(Icons.person_rounded, 'Profile', 2),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildNavItem(IconData icon, String label, int index) {
// //     final isSelected = _selectedIndex == index;
// //     final isSmall = MediaQuery.of(context).size.width < 600;
    
// //     return GestureDetector(
// //       onTap: () => _onNavTap(index),
// //       child: AnimatedBuilder(
// //         animation: _navController,
// //         builder: (_, __) => FadeTransition(
// //           opacity: _iconAnimations[index],
// //           child: ScaleTransition(
// //             scale: _scaleAnimations[index],
// //             child: AnimatedContainer(
// //               duration: const Duration(milliseconds: 300),
// //               padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 16, vertical: 6),
// //               decoration: BoxDecoration(
// //                 color: isSelected ? Colors.red.withOpacity(0.1) : Colors.transparent,
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   AnimatedContainer(
// //                     duration: const Duration(milliseconds: 300),
// //                     padding: EdgeInsets.all(isSmall ? 6 : 8),
// //                     decoration: BoxDecoration(
// //                       color: isSelected ? Colors.red : Colors.transparent,
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Icon(icon, color: isSelected ? Colors.white : Colors.grey[600], size: isSmall ? 20 : 24),
// //                   ),
// //                   const SizedBox(height: 3),
// //                   Text(
// //                     label,
// //                     style: TextStyle(
// //                       fontSize: isSmall ? 10 : 11,
// //                       fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
// //                       color: isSelected ? Colors.red : Colors.grey[600],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _searchAnimController.dispose();
// //     _navController.dispose();
// //     _searchController.dispose();
// //     super.dispose();
// //   }
// // }
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
//       body: CustomScrollView(
//         slivers: [
//           // App Bar
//           SliverAppBar(
//             expandedHeight: 350,
//             pinned: true,
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(
//                   isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: isFavorite ? Colors.red : Colors.black,
//                 ),
//                 onPressed: () {
//                   setState(() => isFavorite = !isFavorite);
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.share, color: Colors.black),
//                 onPressed: () {},
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Hero(
//                 tag: 'laptop-${widget.laptop.id}',
//                 child: Image.network(
//                   widget.laptop.imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     color: Colors.grey[200],
//                     child: const Icon(Icons.laptop_mac, size: 100, color: Colors.grey),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Content
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Brand & Category
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           widget.laptop.brand,
//                           style: TextStyle(
//                             color: Colors.blue[700],
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: _getCategoryColor(widget.laptop.category).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           widget.laptop.category,
//                           style: TextStyle(
//                             color: _getCategoryColor(widget.laptop.category),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                       if (!widget.laptop.inStock)
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.red[50],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             'Out of Stock',
//                             style: TextStyle(
//                               color: Colors.red[700],
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Name
//                   Text(
//                     widget.laptop.name,
//                     style: const TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       height: 1.2,
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Rating & Reviews
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.amber[600], size: 24),
//                       const SizedBox(width: 6),
//                       Text(
//                         widget.laptop.rating.toString(),
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         '(${widget.laptop.reviews} reviews)',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Price
//                   Row(
//                     children: [
//                       if (widget.laptop.discount > 0) ...[
//                         Text(
//                           'Rs ${widget.laptop.originalPrice.toStringAsFixed(0)}',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.grey[500],
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             '-${widget.laptop.discount.toStringAsFixed(0)}%',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Rs ${widget.laptop.price.toStringAsFixed(0)}',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue[700],
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   // Specifications
//                   const Text(
//                     'Specifications',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   _buildSpecRow(Icons.memory, 'Processor', widget.laptop.processor),
//                   _buildSpecRow(Icons.storage, 'RAM', '${widget.laptop.ram}GB'),
//                   _buildSpecRow(Icons.sd_storage, 'Storage', '${widget.laptop.storage}GB SSD'),
//                   _buildSpecRow(Icons.monitor, 'Display', widget.laptop.display),
//                   const SizedBox(height: 24),

//                   // Features
//                   if (widget.laptop.features.isNotEmpty) ...[
//                     const Text(
//                       'Key Features',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: widget.laptop.features.map((feature) {
//                         return Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.check_circle, size: 16, color: Colors.green[600]),
//                               const SizedBox(width: 6),
//                               Text(
//                                 feature,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 24),
//                   ],

//                   // Quantity Selector
//                   const Text(
//                     'Quantity',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           if (quantity > 1) {
//                             setState(() => quantity--);
//                           }
//                         },
//                         icon: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: const Icon(Icons.remove, size: 20),
//                         ),
//                       ),
//                       Container(
//                         width: 60,
//                         alignment: Alignment.center,
//                         child: Text(
//                           quantity.toString(),
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() => quantity++);
//                         },
//                         icon: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[700],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: const Icon(Icons.add, size: 20, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 100),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),

//       // Bottom Bar
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: widget.laptop.inStock ? () {} : null,
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   side: BorderSide(color: Colors.blue[700]!, width: 2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   'Add to Cart',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[700],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: widget.laptop.inStock ? () {} : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[700],
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   disabledBackgroundColor: Colors.grey[300],
//                 ),
//                 child: const Text(
//                   'Buy Now',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSpecRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, size: 24, color: Colors.grey[700]),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
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
// }
import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';

class LaptopDetailScreen extends StatefulWidget {
  final LaptopModel laptop;

  const LaptopDetailScreen({super.key, required this.laptop});

  @override
  State<LaptopDetailScreen> createState() => _LaptopDetailScreenState();
}

class _LaptopDetailScreenState extends State<LaptopDetailScreen> {
  bool isFavorite = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.black),
            onPressed: () => setState(() => isFavorite = !isFavorite),
          ),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
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
                errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.laptop_mac, size: 100, color: Colors.grey)),
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
                  Text(widget.laptop.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.2)),
                  const SizedBox(height: 12),
                  
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[600], size: 24),
                      const SizedBox(width: 6),
                      Text(widget.laptop.rating.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Text('(${widget.laptop.reviews} reviews)', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Price
                  if (widget.laptop.discount > 0) ...[
                    Text('Rs ${widget.laptop.originalPrice.toStringAsFixed(0)}', style: TextStyle(fontSize: 18, color: Colors.grey[500], decoration: TextDecoration.lineThrough)),
                    const SizedBox(height: 8),
                  ],
                  Text('Rs ${widget.laptop.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                  const SizedBox(height: 24),
                  
                  // Specs
                  const Text('Specifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildSpec(Icons.memory, 'Processor', widget.laptop.processor),
                  _buildSpec(Icons.storage, 'RAM', '${widget.laptop.ram}GB'),
                  _buildSpec(Icons.sd_storage, 'Storage', '${widget.laptop.storage}GB SSD'),
                  _buildSpec(Icons.monitor, 'Display', widget.laptop.display),
                  const SizedBox(height: 24),
                  
                  // Features
                  if (widget.laptop.features.isNotEmpty) ...[
                    const Text('Key Features', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.laptop.features.map((f) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
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
                  const Text('Quantity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildQuantityButton(Icons.remove, () {
                        if (quantity > 1) setState(() => quantity--);
                      }),
                      Container(width: 60, alignment: Alignment.center, child: Text(quantity.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
      
      // Bottom Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.laptop.inStock ? () {} : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.blue[700]!, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Add to Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.laptop.inStock ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Buy Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildSpec(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
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
        child: Icon(icon, size: 20, color: filled ? Colors.white : Colors.black),
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
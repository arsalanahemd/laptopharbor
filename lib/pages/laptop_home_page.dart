
// // ignore_for_file: avoid_print
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/pages/debug_page.dart';
// import 'package:provider/provider.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:laptop_harbor/pages/CategoriesPage.dart';
// import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// import 'package:laptop_harbor/pages/orders_page.dart';
// import 'package:laptop_harbor/pages/profile_page.dart';
// import 'package:laptop_harbor/pages/wishlist_page.dart';
// import 'package:laptop_harbor/services/firestore_service.dart';
// import 'package:laptop_harbor/widgets/app_drawer.dart';
// import 'package:laptop_harbor/widgets/custom_app_bar.dart';
// import 'package:laptop_harbor/widgets/custom_bottom_nav.dart';
// import 'package:laptop_harbor/widgets/filter_dialog.dart';
// import 'package:laptop_harbor/widgets/hero_section.dart';
// import 'package:laptop_harbor/widgets/laptop_card.dart';
// import 'package:laptop_harbor/providers/wishlist_provider.dart';

// class LaptopHomePage extends StatefulWidget {
//   const LaptopHomePage({super.key});

//   @override
//   State<LaptopHomePage> createState() => _LaptopHomePageState();
// }

// class _LaptopHomePageState extends State<LaptopHomePage> with TickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final PageController _pageController = PageController();
//   final TextEditingController _searchController = TextEditingController();
//   final FirestoreService _firestoreService = FirestoreService();

//   List<LaptopModel> laptops = [];
//   List<LaptopModel> filteredLaptops = [];

//   int _selectedIndex = 0;
//   bool _isSearchOpen = false;
//   bool _isLoading = true;
//   String _errorMessage = '';

//   FilterOptions _filterOptions = FilterOptions();

//   late AnimationController _loadingController;
//   late AnimationController _fadeController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     _loadLaptops();
//   }

//   void _setupAnimations() {
//     _loadingController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);

//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
//       CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
//       CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
//     );
//   }

//   // ================= LOAD LAPTOPS FROM FIREBASE =================
//   Future<void> _loadLaptops() async {
//     if (!mounted) return;
    
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     try {
//       final data = await _firestoreService.getAllLaptops();
      
//       if (!mounted) return;
      
//       setState(() {
//         laptops = data;
//         filteredLaptops = data;
//         _isLoading = false;
//       });
      
//       print('✅ Loaded ${laptops.length} laptops from Firebase');
//     } catch (e) {
//       if (!mounted) return;
      
//       setState(() {
//         _errorMessage = 'Failed to load laptops: $e';
//         _isLoading = false;
//       });
//       print('❌ Error loading laptops: $e');
//     }
//   }

//   // ================= FORCE REFRESH =================
//   Future<void> _handleRefresh() async {
//     if (!mounted) return;
    
//     print('🔄 Refreshing data...');
//     await _firestoreService.clearCache();
//     await _loadLaptops();
//   }

//   // ================= SEARCH =================
//   void _onSearchChanged(String query) {
//     if (!mounted) return;
    
//     setState(() {
//       filteredLaptops = _applyFilters(query);
//     });
//   }

//   // ================= FILTER =================
//   void _showFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => FilterDialog(
//         currentFilters: _filterOptions,
//         onApply: (newFilters) {
//           setState(() {
//             _filterOptions = newFilters;
//             filteredLaptops = _applyFilters(_searchController.text);
//           });
//         },
//       ),
//     );
//   }

//   List<LaptopModel> _applyFilters([String? search]) {
//     var result = laptops;

//     // Price
//     result = result.where((l) {
//       return l.price >= _filterOptions.priceRange.start &&
//           l.price <= _filterOptions.priceRange.end;
//     }).toList();

//     // Brand
//     if (_filterOptions.selectedBrands.isNotEmpty) {
//       result = result
//           .where((l) => _filterOptions.selectedBrands.contains(l.brand))
//           .toList();
//     }

//     // RAM
//     if (_filterOptions.selectedRamSizes.isNotEmpty) {
//       result = result
//           .where((l) => _filterOptions.selectedRamSizes.contains(l.ram))
//           .toList();
//     }

//     // Search
//     if (search != null && search.isNotEmpty) {
//       final q = search.toLowerCase();
//       result = result.where((l) {
//         return l.name.toLowerCase().contains(q) ||
//             l.brand.toLowerCase().contains(q) ||
//             l.processor.toLowerCase().contains(q);
//       }).toList();
//     }

//     return result;
//   }

//   // ================= NAV =================
//   void _onNavTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   // ================= DATA =================
//   List<LaptopModel> _hotDeals() =>
//       laptops.where((l) => l.isHotDeal).take(6).toList();
//   List<LaptopModel> _newArrivals() =>
//       laptops.where((l) => l.isNewArrival).take(6).toList();
//   List<LaptopModel> _mostSale() =>
//       laptops.where((l) => l.isMostSale).take(6).toList();
//   List<LaptopModel> _premium() =>
//       laptops.where((l) => l.price > 150000).take(6).toList();

//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: AppDrawer(
//         onClose: () => Navigator.pop(context),
//       ),
//       body: Column(
//         children: [
//           /// ✅ APP BAR (HOME ONLY)
//           if (_selectedIndex == 0)
//             CustomAppBar(
//               isSearchOpen: _isSearchOpen,
//               searchController: _searchController,
//               onSearchChanged: _onSearchChanged,
//               onSearchToggle: () {
//                 setState(() {
//                   _isSearchOpen = !_isSearchOpen;
//                   if (!_isSearchOpen) {
//                     _searchController.clear();
//                     filteredLaptops = laptops;
//                   }
//                 });
//               },
//               onFilterClick: _showFilterDialog,
//               onMenuClick: () => _scaffoldKey.currentState?.openDrawer(),
//               onCartClick: () {},
//               cartCount: 3,
//               onNotificationClick: () {},
//               onSearchClick: () {},
//               onClose: () {},
//             ),

//           /// ✅ PAGES
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               onPageChanged: (i) {
//                 setState(() {
//                   _selectedIndex = i;
//                 });
//               },
//               children: [
//                 _buildHome(),
//                 const CategoriesPage(),
//                 const OrderPage(),
//                 const WishlistPage(),
//                 const ProfilePage(),
//                 //  DebugFirestorePage(),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onTabChange: _onNavTap,
//       ),
//       floatingActionButton: _selectedIndex == 0
//           ? AnimatedBuilder(
//               animation: _loadingController,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: 1.0 + (_scaleAnimation.value - 1.0) * 0.05,
//                   child: FloatingActionButton(
//                     onPressed: _isLoading ? null : _handleRefresh,
//                     backgroundColor: Colors.blue[700],
//                     child: _isLoading
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2.5,
//                             ),
//                           )
//                         : const Icon(Icons.refresh_rounded, color: Colors.white),
//                   ),
//                 );
//               },
//             )
//           : null,
//     );
//   }

//   // ================= HOME =================
//   Widget _buildHome() {
//     // Loading State with Beautiful Animation
//     if (_isLoading) {
//       return Center(
//         child: AnimatedBuilder(
//           animation: _loadingController,
//           builder: (context, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Animated Laptop Icon
//                 Transform.scale(
//                   scale: _scaleAnimation.value,
//                   child: Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.blue[400]!.withOpacity(_fadeAnimation.value),
//                           Colors.blue[700]!.withOpacity(_fadeAnimation.value),
//                         ],
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.blue.withOpacity(0.3 * _fadeAnimation.value),
//                           blurRadius: 30,
//                           spreadRadius: 10,
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.laptop_mac,
//                       size: 60,
//                       color: Colors.white.withOpacity(_fadeAnimation.value),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 // Animated Dots
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(3, (index) {
//                     return AnimatedBuilder(
//                       animation: _loadingController,
//                       builder: (context, child) {
//                         final delay = index * 0.2;
//                         final value = (_loadingController.value + delay) % 1.0;
//                         return Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           width: 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.blue[700]!.withOpacity(value),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//                 ),
//                 const SizedBox(height: 16),
//                 // Text
//                 Opacity(
//                   opacity: _fadeAnimation.value,
//                   child: const Text(
//                     'Loading laptops...',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//     }

//     // Error State
//     if (_errorMessage.isNotEmpty) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.red[50],
//                 ),
//                 child: Icon(
//                   Icons.error_outline_rounded,
//                   size: 64,
//                   color: Colors.red[400],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'Oops! Something went wrong',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 _errorMessage,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton.icon(
//                 onPressed: _handleRefresh,
//                 icon: const Icon(Icons.refresh_rounded),
//                 label: const Text('Try Again'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[700],
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     // Empty State
//     if (laptops.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey[100],
//                 ),
//                 child: Icon(
//                   Icons.laptop_chromebook_rounded,
//                   size: 64,
//                   color: Colors.grey[400],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'No laptops available',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'Check back later for new products',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton.icon(
//                 onPressed: _handleRefresh,
//                 icon: const Icon(Icons.refresh_rounded),
//                 label: const Text('Refresh'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[700],
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     bool isFiltering = _searchController.text.isNotEmpty ||
//         _filterOptions.selectedBrands.isNotEmpty ||
//         _filterOptions.selectedRamSizes.isNotEmpty ||
//         _filterOptions.priceRange.start > 0 ||
//         _filterOptions.priceRange.end <
//             laptops.map((e) => e.price).reduce((a, b) => a > b ? a : b);

//     // 🔍 SEARCH / FILTER MODE
//     if (isFiltering) {
//       return RefreshIndicator(
//         onRefresh: _handleRefresh,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               _allProducts(),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       );
//     }

//     // 🏠 NORMAL HOME
//     return RefreshIndicator(
//       onRefresh: _handleRefresh,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             const HeroSection(),
//             _section('🔥 Hot Deals', _hotDeals()),
//             _section('✨ New Arrivals', _newArrivals()),
//             _section('💰 Most Sale', _mostSale()),
//             _section('💎 Premium', _premium()),
//             _allProducts(),
//             const SizedBox(height: 80), // Extra space for FAB
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _section(String title, List<LaptopModel> items) {
//     if (items.isEmpty) return const SizedBox();

//     return Consumer<WishlistProvider>(
//       builder: (context, wishlistProvider, child) {
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 300,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: items.length,
//                 itemBuilder: (_, i) => SizedBox(
//                   width: 190,
//                   child: LaptopCard(
//                     laptop: items[i],
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => LaptopDetailScreen(laptop: items[i]),
//                         ),
//                       );
//                     },
//                     onFavorite: () {
//                       wishlistProvider.toggleWishlist(items[i].id);
//                     },
//                     isInWishlist: wishlistProvider.isInWishlist(items[i].id),
//                     showWishlistButton: true,
//                     onWishlistToggle: () {
//                       wishlistProvider.toggleWishlist(items[i].id);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _allProducts() {
//     if (filteredLaptops.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(48),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey[100],
//               ),
//               child: Icon(
//                 Icons.search_off_rounded,
//                 size: 64,
//                 color: Colors.grey[400],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'No products found',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Try adjusting your filters',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Consumer<WishlistProvider>(
//       builder: (context, wishlistProvider, child) {
//         return GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           itemCount: filteredLaptops.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.7,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//           ),
//           itemBuilder: (_, i) => LaptopCard(
//             laptop: filteredLaptops[i],
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => LaptopDetailScreen(laptop: filteredLaptops[i]),
//                 ),
//               );
//             },
//             onFavorite: () {
//               wishlistProvider.toggleWishlist(filteredLaptops[i].id);
//             },
//             isInWishlist: wishlistProvider.isInWishlist(filteredLaptops[i].id),
//             showWishlistButton: true,
//             onWishlistToggle: () {
//               wishlistProvider.toggleWishlist(filteredLaptops[i].id);
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _loadingController.dispose();
//     _fadeController.dispose();
//     _pageController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
// }
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Admin/admin.dart';
import 'package:provider/provider.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/pages/CategoriesPage.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
import 'package:laptop_harbor/pages/wishlist_page.dart';
import 'package:laptop_harbor/services/firestore_service.dart';
import 'package:laptop_harbor/widgets/app_drawer.dart';
import 'package:laptop_harbor/widgets/custom_app_bar.dart';
import 'package:laptop_harbor/widgets/custom_bottom_nav.dart';
import 'package:laptop_harbor/widgets/filter_dialog.dart';
import 'package:laptop_harbor/widgets/hero_section.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';
import 'package:laptop_harbor/providers/wishlist_provider.dart';
import 'dart:math' as math;

class LaptopHomePage extends StatefulWidget {
  const LaptopHomePage({super.key});

  @override
  State<LaptopHomePage> createState() => _LaptopHomePageState();
}

class _LaptopHomePageState extends State<LaptopHomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  List<LaptopModel> laptops = [];
  List<LaptopModel> filteredLaptops = [];

  int _selectedIndex = 0;
  bool _isSearchOpen = false;
  bool _isLoading = true;
  String _errorMessage = '';

  FilterOptions _filterOptions = FilterOptions();

  late AnimationController _loadingController;
  late AnimationController _fadeController;
  late AnimationController _floatingController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadLaptops();
  }

  void _setupAnimations() {
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
    );

    _floatingAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  // ================= LOAD LAPTOPS FROM FIREBASE =================
  Future<void> _loadLaptops() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final data = await _firestoreService.getAllLaptops();
      
      if (!mounted) return;
      
      setState(() {
        laptops = data;
        filteredLaptops = data;
        _isLoading = false;
      });
      
      print('✅ Loaded ${laptops.length} laptops from Firebase');
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _errorMessage = 'Failed to load laptops: $e';
        _isLoading = false;
      });
      print('❌ Error loading laptops: $e');
    }
  }

  // ================= FORCE REFRESH =================
  Future<void> _handleRefresh() async {
    if (!mounted) return;
    
    print('🔄 Refreshing data...');
    await _firestoreService.clearCache();
    await _loadLaptops();
  }

  // ================= SEARCH =================
  void _onSearchChanged(String query) {
    if (!mounted) return;
    
    setState(() {
      filteredLaptops = _applyFilters(query);
    });
  }

  // ================= FILTER =================
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (_) => FilterDialog(
        currentFilters: _filterOptions,
        onApply: (newFilters) {
          setState(() {
            _filterOptions = newFilters;
            filteredLaptops = _applyFilters(_searchController.text);
          });
        },
      ),
    );
  }

  List<LaptopModel> _applyFilters([String? search]) {
    var result = laptops;

    // Price
    result = result.where((l) {
      return l.price >= _filterOptions.priceRange.start &&
          l.price <= _filterOptions.priceRange.end;
    }).toList();

    // Brand
    if (_filterOptions.selectedBrands.isNotEmpty) {
      result = result
          .where((l) => _filterOptions.selectedBrands.contains(l.brand))
          .toList();
    }

    // RAM
    if (_filterOptions.selectedRamSizes.isNotEmpty) {
      result = result
          .where((l) => _filterOptions.selectedRamSizes.contains(l.ram))
          .toList();
    }

    // Search
    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      result = result.where((l) {
        return l.name.toLowerCase().contains(q) ||
            l.brand.toLowerCase().contains(q) ||
            l.processor.toLowerCase().contains(q);
      }).toList();
    }

    return result;
  }

  // ================= NAV =================
  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  // ================= DATA =================
  List<LaptopModel> _hotDeals() =>
      laptops.where((l) => l.isHotDeal).take(6).toList();
  List<LaptopModel> _newArrivals() =>
      laptops.where((l) => l.isNewArrival).take(6).toList();
  List<LaptopModel> _mostSale() =>
      laptops.where((l) => l.isMostSale).take(6).toList();
  List<LaptopModel> _premium() =>
      laptops.where((l) => l.price > 150000).take(6).toList();
  List<LaptopModel> _forYou() {
    // Get random laptops for "For You" section
    final shuffled = List<LaptopModel>.from(laptops)..shuffle();
    return shuffled.take(6).toList();
  }

  // ================= FLOATING PARTICLES =================
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
              color: Colors.blue[300]!.withOpacity(0.1 + (index % 3) * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[300]!.withOpacity(0.15),
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

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        onClose: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          // Animated gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 30, 64, 175),
                  Color.fromARGB(255, 118, 113, 113),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Floating particles (only on home page)
          if (_selectedIndex == 0)
            ...List.generate(10, (index) => _buildFloatingParticle(index)),
          // Main content
          Column(
            children: [
              /// ✅ APP BAR (HOME ONLY)
              if (_selectedIndex == 0)
                CustomAppBar(
                  isSearchOpen: _isSearchOpen,
                  searchController: _searchController,
                  onSearchChanged: _onSearchChanged,
                  onSearchToggle: () {
                    setState(() {
                      _isSearchOpen = !_isSearchOpen;
                      if (!_isSearchOpen) {
                        _searchController.clear();
                        filteredLaptops = laptops;
                      }
                    });
                  },
                  onFilterClick: _showFilterDialog,
                  onMenuClick: () => _scaffoldKey.currentState?.openDrawer(),
                  onCartClick: () {},
                  isDarkTheme: false,
                  onThemeChanged: null, cartCount: 0, onNotificationClick: () {  }, onSearchClick: () {  }, onClose: () {  },
                ),

              /// ✅ PAGES
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) {
                    setState(() {
                      _selectedIndex = i;
                    });
                  },
                  children: [
                    _buildHome(),
                    const CategoriesPage(),
                    // const MyOrdersScreen(),
                    // MyOrdersScreen(),
                    const WishlistPage(),
                    // const ProfilePage(),
                    const AdminDashboard(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onNavTap,
      ),
    );
  }

  // ================= HOME =================
  Widget _buildHome() {
    // Loading State with Beautiful Animation
    if (_isLoading) {
      return Center(
        child: AnimatedBuilder(
          animation: _loadingController,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Laptop Icon
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[300]!.withOpacity(_fadeAnimation.value),
                          Colors.blue[600]!.withOpacity(_fadeAnimation.value),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3 * _fadeAnimation.value),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.laptop_mac,
                      size: 60,
                      color: Colors.white.withOpacity(_fadeAnimation.value),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Animated Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedBuilder(
                      animation: _loadingController,
                      builder: (context, child) {
                        final delay = index * 0.2;
                        final value = (_loadingController.value + delay) % 1.0;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[600]!.withOpacity(value),
                          ),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(height: 16),
                // Text
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: Text(
                    'Loading laptops...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    // Error State
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red[50],
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: Colors.red[700],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.blue[500]!, Colors.blue[700]!],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _handleRefresh,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh_rounded, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Try Again',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
      );
    }

    // Empty State
    if (laptops.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[100],
                ),
                child: Icon(
                  Icons.laptop_chromebook_rounded,
                  size: 64,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No laptops available',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Check back later for new products',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.blue[500]!, Colors.blue[700]!],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _handleRefresh,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh_rounded, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Refresh',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
      );
    }

    bool isFiltering = _searchController.text.isNotEmpty ||
        _filterOptions.selectedBrands.isNotEmpty ||
        _filterOptions.selectedRamSizes.isNotEmpty ||
        _filterOptions.priceRange.start > 0 ||
        _filterOptions.priceRange.end <
            laptops.map((e) => e.price).reduce((a, b) => a > b ? a : b);

    // 🔍 SEARCH / FILTER MODE
    if (isFiltering) {
      return RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue[700],
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _allProducts(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    // 🏠 NORMAL HOME
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: Colors.blue[700],
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const HeroSection(),
            _section('🔥 Hot Deals', _hotDeals()),
            _section('✨ New Arrivals', _newArrivals()),
            _section('💰 Most Sale', _mostSale()),
            _section('💎 Premium', _premium()),
            _section('🎯 For You', _forYou()),
            _allProducts(),
            const SizedBox(height: 80), // Extra space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<LaptopModel> items) {
    if (items.isEmpty) return const SizedBox();

    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                itemBuilder: (_, i) => SizedBox(
                  width: 190,
                  child: LaptopCard(
                    laptop: items[i],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LaptopDetailScreen(laptop: items[i]),
                        ),
                      );
                    },
                    onFavorite: () {
                      wishlistProvider.toggleWishlist(items[i].id);
                    },
                    isInWishlist: wishlistProvider.isInWishlist(items[i].id),
                    showWishlistButton: true,
                    onWishlistToggle: () {
                      wishlistProvider.toggleWishlist(items[i].id);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _allProducts() {
    if (filteredLaptops.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 64,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: filteredLaptops.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, i) => LaptopCard(
            laptop: filteredLaptops[i],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LaptopDetailScreen(laptop: filteredLaptops[i]),
                ),
              );
            },
            onFavorite: () {
              wishlistProvider.toggleWishlist(filteredLaptops[i].id);
            },
            isInWishlist: wishlistProvider.isInWishlist(filteredLaptops[i].id),
            showWishlistButton: true,
            onWishlistToggle: () {
              wishlistProvider.toggleWishlist(filteredLaptops[i].id);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _fadeController.dispose();
    _floatingController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
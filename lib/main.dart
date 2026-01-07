// // import 'package:flutter/material.dart';
// // import 'package:laptop_harbor/data/laptop_data.dart';
// // import 'package:laptop_harbor/widgets/laptop_card.dart';
// // import 'package:laptop_harbor/pages/laptop_detail_screen.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Laptop Store',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         scaffoldBackgroundColor: Color(0xFFF5F7FA),
// //         fontFamily: 'SF Pro',
// //       ),
// //       home: LaptopListScreen(),
// //     );
// //   }
// // }

// // class LaptopListScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         elevation: 0,
// //         backgroundColor: Colors.white,
// //         title: Text(
// //           'Premium Laptops',
// //           style: TextStyle(
// //             color: Colors.grey[900],
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.search, color: Colors.grey[700]),
// //             onPressed: () {},
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.shopping_cart_outlined,
// //                 color: Colors.grey[700]),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //       body: LayoutBuilder(
// //         builder: (context, constraints) {
// //           // Responsive: 2 columns on mobile, 3 on tablet, 4 on desktop
// //           int crossAxisCount = 2;
// //           if (constraints.maxWidth > 900) {
// //             crossAxisCount = 4;
// //           } else if (constraints.maxWidth > 600) {
// //             crossAxisCount = 3;
// //           }

// //           // Calculate aspect ratio based on screen width
// //           double cardWidth = (constraints.maxWidth - 48) / crossAxisCount;
// //           double cardHeight = cardWidth * 1.45;

// //           // Check if data is available
// //           if (laptopData.isEmpty) {
// //             return Center(
// //               child: Text('No laptops available'),
// //             );
// //           }

// //           return GridView.builder(
// //             padding: EdgeInsets.all(16),
// //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: crossAxisCount,
// //               childAspectRatio: cardWidth / cardHeight,
// //               crossAxisSpacing: 16,
// //               mainAxisSpacing: 16,
// //             ),
// //             itemCount: laptopData.length,
// //             itemBuilder: (context, index) {
// //               return LaptopCard(
// //                 laptop: laptopData[index],
// //                 onTap: () {
// //                   // Navigate to detail screen
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => LaptopDetailScreen(
// //                         laptop: laptopData[index],
// //                       ),
// //                     ),
// //                   );
// //                 }, onFavorite: () {  },
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:laptop_harbor/data/laptop_data.dart';
// // import 'package:laptop_harbor/widgets/laptop_card.dart';
// // import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// // import 'package:laptop_harbor/widgets/hero_section.dart';

// // void main() {
// //   runApp(LaptopHarborApp());
// // }

// // class LaptopHarborApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Laptop Harbor',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.red, // Harbor Red
// //         scaffoldBackgroundColor: Color(0xFFF5F7FA),
// //         fontFamily: 'SF Pro',
// //       ),
// //       home: HomeScreen(),
// //     );
// //   }
// // }

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen>
// //     with SingleTickerProviderStateMixin {
// //   int _selectedIndex = 0;
// //   bool _isSearchOpen = false;
// //   late AnimationController _controller;
// //   late Animation<double> _searchAnimation;
// //   final TextEditingController _searchController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: Duration(milliseconds: 300),
// //     );
// //     _searchAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
// //   }

// //   void _toggleSearch() {
// //     setState(() {
// //       _isSearchOpen = !_isSearchOpen;
// //       if (_isSearchOpen) {
// //         _controller.forward();
// //       } else {
// //         _controller.reverse();
// //       }
// //     });
// //   }

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   Widget _buildBody() {
// //     if (_selectedIndex == 0) {
// //       // Home Screen with Hero Section and Grid
// //       return Column(
// //         children: [
// //           const HeroSection(),
// //           Expanded(
// //             child: LayoutBuilder(
// //               builder: (context, constraints) {
// //                 int crossAxisCount = 2;
// //                 if (constraints.maxWidth > 900) {
// //                   crossAxisCount = 4;
// //                 } else if (constraints.maxWidth > 600) {
// //                   crossAxisCount = 3;
// //                 }

// //                 double cardWidth = (constraints.maxWidth - 48) / crossAxisCount;
// //                 double cardHeight = cardWidth * 1.45;

// //                 if (laptopData.isEmpty) {
// //                   return Center(
// //                     child: Text('No laptops available'),
// //                   );
// //                 }

// //                 return GridView.builder(
// //                   padding: EdgeInsets.all(16),
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: crossAxisCount,
// //                     childAspectRatio: cardWidth / cardHeight,
// //                     crossAxisSpacing: 16,
// //                     mainAxisSpacing: 16,
// //                   ),
// //                   itemCount: laptopData.length,
// //                   itemBuilder: (context, index) {
// //                     return LaptopCard(
// //                       laptop: laptopData[index],
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                                 LaptopDetailScreen(laptop: laptopData[index]),
// //                           ),
// //                         );
// //                       },
// //                       onFavorite: () {},
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       );
// //     } else if (_selectedIndex == 1) {
// //       return Center(child: Text("Categories"));
// //     } else {
// //       return Center(child: Text("Profile"));
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         elevation: 0,
// //         backgroundColor: Colors.white,
// //         title: _isSearchOpen
// //             ? SizeTransition(
// //                 sizeFactor: _searchAnimation,
// //                 axis: Axis.horizontal,
// //                 axisAlignment: -1.0,
// //                 child: TextField(
// //                   controller: _searchController,
// //                   decoration: InputDecoration(
// //                     hintText: "Search laptops...",
// //                     border: InputBorder.none,
// //                   ),
// //                   autofocus: true,
// //                 ),
// //               )
// //             : Text(
// //                 'Laptop Harbor',
// //                 style: TextStyle(
// //                   color: Colors.black,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //         actions: [
// //           IconButton(
// //             icon: Icon(
// //               _isSearchOpen ? Icons.close : Icons.search,
// //               color: Colors.grey[700],
// //             ),
// //             onPressed: _toggleSearch,
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey[700]),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //       body: _buildBody(),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: Colors.red,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     _searchController.dispose();
// //     super.dispose();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/data/laptop_data.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:laptop_harbor/pages/categories_page.dart';
// import 'package:laptop_harbor/widgets/laptop_card.dart';
// import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// import 'package:laptop_harbor/widgets/hero_section.dart';
// import 'package:laptop_harbor/widgets/app_drawer.dart';
// import 'package:laptop_harbor/widgets/filter_dialog.dart';

// void main() {
//   runApp(const LaptopHarborApp());
// }

// class LaptopHarborApp extends StatelessWidget {
//   const LaptopHarborApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Laptop Harbor',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         scaffoldBackgroundColor: const Color(0xFFF5F7FA),
//         fontFamily: 'SF Pro',
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const HomeScreen(),
//         '/categories': (context) => CategoriesPage(),
//       },
//       onGenerateRoute: (settings) {
//         if (settings.name == '/details') {
//           final laptop = settings.arguments as LaptopModel;
//           return MaterialPageRoute(
//             builder: (_) => LaptopDetailScreen(laptop: laptop),
//           );
//         }
//         return null;
//       },
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with TickerProviderStateMixin {
//   int _selectedIndex = 0;

//   // 🔍 SEARCH
//   bool _isSearchOpen = false;
//   final TextEditingController _searchController = TextEditingController();
//   List<LaptopModel> _filteredLaptops = laptopData;

//   // 🎯 FILTER
//   FilterOptions _filterOptions = FilterOptions();

//   // 🔄 SEARCH ANIMATION
//   late AnimationController _searchController2;
//   late Animation<double> _searchAnimation;

//   // 🎨 BOTTOM NAV ANIMATION
//   late AnimationController _navController;
//   late List<Animation<double>> _iconAnimations;
//   late List<Animation<double>> _scaleAnimations;

//   @override
//   void initState() {
//     super.initState();

//     // Search Animation
//     _searchController2 = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _searchAnimation = Tween<double>(begin: 0, end: 1).animate(_searchController2);

//     // Bottom Nav Animation
//     _navController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );

//     _iconAnimations = List.generate(
//       3,
//       (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(
//           parent: _navController,
//           curve: Interval(
//             index * 0.2,
//             0.6 + (index * 0.2),
//             curve: Curves.easeOutBack,
//           ),
//         ),
//       ),
//     );

//     _scaleAnimations = List.generate(
//       3,
//       (index) => Tween<double>(begin: 0.8, end: 1.0).animate(
//         CurvedAnimation(
//           parent: _navController,
//           curve: Curves.easeOutBack,
//         ),
//       ),
//     );

//     _navController.forward();
//   }

//   // 🔍 SEARCH LOGIC
//   void _onSearchChanged(String query) {
//     setState(() {
//       _filteredLaptops = _applyFilters(query);
//     });
//   }

//   // 🎯 APPLY FILTERS
//   List<LaptopModel> _applyFilters(String searchQuery) {
//     List<LaptopModel> result = laptopData;

//     // Search filter
//     if (searchQuery.isNotEmpty) {
//       final q = searchQuery.toLowerCase();
//       result = result.where((laptop) {
//         return laptop.name.toLowerCase().contains(q) ||
//             laptop.brand.toLowerCase().contains(q) ||
//             laptop.processor.toLowerCase().contains(q);
//       }).toList();
//     }

//     // Price filter
//     result = result.where((laptop) {
//       return laptop.price >= _filterOptions.priceRange.start &&
//           laptop.price <= _filterOptions.priceRange.end;
//     }).toList();

//     // Brand filter
//     if (_filterOptions.selectedBrands.isNotEmpty) {
//       result = result.where((laptop) {
//         return _filterOptions.selectedBrands.contains(laptop.brand);
//       }).toList();
//     }

//     // Processor filter
//     if (_filterOptions.selectedProcessors.isNotEmpty) {
//       result = result.where((laptop) {
//         return _filterOptions.selectedProcessors.any((proc) =>
//             laptop.processor.toLowerCase().contains(proc.toLowerCase()));
//       }).toList();
//     }

//     // RAM filter
//     if (_filterOptions.selectedRamSizes.isNotEmpty) {
//       result = result.where((laptop) {
//         return _filterOptions.selectedRamSizes.contains(laptop.ram);
//       }).toList();
//     }

//     // Storage filter
//     if (_filterOptions.selectedStorageSizes.isNotEmpty) {
//       result = result.where((laptop) {
//         return _filterOptions.selectedStorageSizes.contains(laptop.storage);
//       }).toList();
//     }

//     // Sort
//     if (_filterOptions.sortBy == 'price_low') {
//       result.sort((a, b) => a.price.compareTo(b.price));
//     } else if (_filterOptions.sortBy == 'price_high') {
//       result.sort((a, b) => b.price.compareTo(a.price));
//     } else if (_filterOptions.sortBy == 'name') {
//       result.sort((a, b) => a.name.compareTo(b.name));
//     }

//     return result;
//   }

//   void _showFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => FilterDialog(
//         currentFilters: _filterOptions,
//         onApply: (newFilters) {
//           setState(() {
//             _filterOptions = newFilters;
//             _filteredLaptops = _applyFilters(_searchController.text);
//           });
//         },
//       ),
//     );
//   }

//   void _toggleSearch() {
//     setState(() {
//       _isSearchOpen = !_isSearchOpen;
//       if (_isSearchOpen) {
//         _searchController2.forward();
//       } else {
//         _searchController2.reverse();
//         _searchController.clear();
//         _filteredLaptops = laptopData;
//       }
//     });
//   }

//   void _onNavTap(int index) {
//     if (_selectedIndex != index) {
//       _navController.reset();
//       _navController.forward();
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   Widget _buildHome() {
//     return Column(
//       children: [
//         const HeroSection(),
//         Expanded(
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               int crossAxisCount = 2;
//               if (constraints.maxWidth > 900) {
//                 crossAxisCount = 4;
//               } else if (constraints.maxWidth > 600) {
//                 crossAxisCount = 3;
//               }

//               double cardWidth = (constraints.maxWidth - 48) / crossAxisCount;
//               double cardHeight = cardWidth * 1.45;

//               if (_filteredLaptops.isEmpty) {
//                 return const Center(child: Text('No laptops found'));
//               }

//               return GridView.builder(
//                 padding: const EdgeInsets.all(16),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: crossAxisCount,
//                   childAspectRatio: cardWidth / cardHeight,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: _filteredLaptops.length,
//                 itemBuilder: (context, index) {
//                   final laptop = _filteredLaptops[index];

//                   return LaptopCard(
//                     laptop: laptop,
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/details',
//                         arguments: laptop,
//                       );
//                     },
//                     onFavorite: () {},
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBody() {
//     if (_selectedIndex == 0) {
//       return _buildHome();
//     } else if (_selectedIndex == 1) {
//       return CategoriesPage();
//     } else {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.person, size: 80, color: Colors.grey[400]),
//             const SizedBox(height: 16),
//             Text(
//               'Profile Page',
//               style: TextStyle(fontSize: 24, color: Colors.grey[700]),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.grey[700]),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//         title: _isSearchOpen
//             ? SizeTransition(
//                 sizeFactor: _searchAnimation,
//                 axis: Axis.horizontal,
//                 axisAlignment: -1,
//                 child: TextField(
//                   controller: _searchController,
//                   autofocus: true,
//                   onChanged: _onSearchChanged,
//                   decoration: const InputDecoration(
//                     hintText: 'Search laptops...',
//                     border: InputBorder.none,
//                   ),
//                 ),
//               )
//             : const Text(
//                 'Laptop Harbor',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _isSearchOpen ? Icons.close : Icons.search,
//               color: Colors.grey[700],
//             ),
//             onPressed: _toggleSearch,
//           ),
//           // Filter Button with Badge
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.filter_list, color: Colors.grey[700]),
//                 onPressed: _showFilterDialog,
//               ),
//               if (_filterOptions.hasActiveFilters)
//                 Positioned(
//                   right: 8,
//                   top: 8,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 16,
//                       minHeight: 16,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           IconButton(
//             icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey[700]),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       drawer: const AppDrawer(),
//       body: _buildBody(),
//       bottomNavigationBar: _buildAnimatedBottomNav(),
//     );
//   }

//   Widget _buildAnimatedBottomNav() {
//     return Container(
//       height: 70,
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
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(
//             icon: Icons.home_rounded,
//             label: 'Home',
//             index: 0,
//           ),
//           _buildNavItem(
//             icon: Icons.category_rounded,
//             label: 'Category',
//             index: 1,
//           ),
//           _buildNavItem(
//             icon: Icons.person_rounded,
//             label: 'Profile',
//             index: 2,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required IconData icon,
//     required String label,
//     required int index,
//   }) {
//     final isSelected = _selectedIndex == index;

//     return GestureDetector(
//       onTap: () => _onNavTap(index),
//       child: AnimatedBuilder(
//         animation: _navController,
//         builder: (context, child) {
//           return FadeTransition(
//             opacity: _iconAnimations[index],
//             child: ScaleTransition(
//               scale: _scaleAnimations[index],
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.red.withOpacity(0.1) : Colors.transparent,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.red : Colors.transparent,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Icon(
//                         icon,
//                         color: isSelected ? Colors.white : Colors.grey[600],
//                         size: 26,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     AnimatedDefaultTextStyle(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       style: TextStyle(
//                         fontSize: isSelected ? 12 : 11,
//                         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                         color: isSelected ? Colors.red : Colors.grey[600],
//                       ),
//                       child: Text(label),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController2.dispose();
//     _navController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
// }
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/firebase_options.dart';
// // import 'package:laptop_harbor/models/laptop_model.dart';
// // import 'package:laptop_harbor/pages/CategoriesPage.dart';
// // import 'package:laptop_harbor/pages/laptop_home_page.dart';
// // import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// import 'package:laptop_harbor/services/wrapper.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const LaptopHarborApp());
// }
// class LaptopHarborApp extends StatelessWidget {
//   const LaptopHarborApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Laptop Harbor',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         scaffoldBackgroundColor: const Color(0xFFF5F7FA),
//         fontFamily: 'SF Pro',
//       ),
//       home: const AuthWrapper(),
//       // routes: {'/categories': (context) => CategoriesPage()},
//       // onGenerateRoute: (settings) {
//         // if (settings.name == '/details') {
//           // final laptop = settings.arguments as LaptopModel;
//           // return MaterialPageRoute(
//             // builder: (_) => LaptopDetailScreen(laptop: laptop),
//           // );
//         // }
//         // return null;
//       // },
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:laptop_harbor/firebase_options.dart';
import 'package:laptop_harbor/providers/cart_provider.dart';
import 'package:laptop_harbor/services/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LaptopHarborApp());
}

class LaptopHarborApp extends StatelessWidget {
  const LaptopHarborApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        // Agar future me aur providers chahiye to yahan add karo
      ],
      child: MaterialApp(
        title: 'Laptop Harbor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),
          fontFamily: 'SF Pro',
        ),
        home: const AuthWrapper(), // Ye tumhara auth/login wrapper
      ),
    );
  }
}

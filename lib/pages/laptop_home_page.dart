// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/auth/login_page.dart';
// import 'package:laptop_harbor/data/laptop_data.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:laptop_harbor/pages/CategoriesPage.dart';
// import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// import 'package:laptop_harbor/pages/view_all_product.dart';
// import 'package:laptop_harbor/widgets/app_drawer.dart';
// import 'package:laptop_harbor/widgets/filter_dialog.dart';
// import 'package:laptop_harbor/widgets/laptop_card.dart';

// class LaptopHomePage extends StatefulWidget {
//   const LaptopHomePage({super.key});

//   @override
//   State<LaptopHomePage> createState() => _LaptopHomePageState();
// }

// class _LaptopHomePageState extends State<LaptopHomePage>
//     with TickerProviderStateMixin {
//   List<LaptopModel> laptops = [];
//   List<LaptopModel> filteredLaptops = [];

//   int _selectedIndex = 0;
//   bool _isSearchOpen = false;

//   final TextEditingController _searchController = TextEditingController();
//   final PageController _pageController = PageController();

//   FilterOptions _filterOptions = FilterOptions();

//   late AnimationController _navController;
//   late List<Animation<double>> _iconAnimations;
//   late List<Animation<double>> _scaleAnimations;

//   String selectedBrand = 'All';

//   @override
//   void initState() {
//     super.initState();

//     laptops = laptopData;
//     filteredLaptops = laptops;

//     _navController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );

//     _iconAnimations = List.generate(
//       3,
//       (i) => Tween<double>(begin: 0, end: 1).animate(
//         CurvedAnimation(
//           parent: _navController,
//           curve: Interval(i * 0.2, 0.6 + (i * 0.2),
//               curve: Curves.easeOutBack),
//         ),
//       ),
//     );

//     _scaleAnimations = List.generate(
//       3,
//       (_) => Tween<double>(begin: 0.85, end: 1).animate(
//         CurvedAnimation(parent: _navController, curve: Curves.easeOutBack),
//       ),
//     );

//     _navController.forward();
//   }

//   // ---------------- SEARCH ----------------
//   void _toggleSearch() {
//     setState(() {
//       _isSearchOpen = !_isSearchOpen;
//       if (!_isSearchOpen) {
//         _searchController.clear();
//         filteredLaptops = laptops;
//       }
//     });
//   }

//   void _onSearchChanged(String query) {
//     setState(() {
//       filteredLaptops = _applyFilters();
//     });
//   }

//   // ---------------- FILTER ----------------
//   void _showFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => FilterDialog(
//         currentFilters: _filterOptions,
//         onApply: (newFilters) {
//           setState(() {
//             _filterOptions = newFilters;
//             filteredLaptops = _applyFilters();
//           });
//         },
//       ),
//     );
//   }

//   List<LaptopModel> _applyFilters() {
//     var result = laptops;

//     // Apply price filter
//     result = result.where((l) {
//       return l.price >= _filterOptions.priceRange.start &&
//           l.price <= _filterOptions.priceRange.end;
//     }).toList();

//     // Apply brand filter only if brands are selected
//     if (_filterOptions.selectedBrands.isNotEmpty) {
//       result = result
//           .where((l) => _filterOptions.selectedBrands.contains(l.brand))
//           .toList();
//     }

//     // Apply RAM filter only if RAM sizes are selected
//     if (_filterOptions.selectedRamSizes.isNotEmpty) {
//       result = result
//           .where((l) => _filterOptions.selectedRamSizes.contains(l.ram))
//           .toList();
//     }

//     // If search is open, also apply search query
//     if (_isSearchOpen && _searchController.text.isNotEmpty) {
//       final q = _searchController.text.toLowerCase();
//       result = result.where((l) {
//         return l.name.toLowerCase().contains(q) ||
//             l.brand.toLowerCase().contains(q) ||
//             l.processor.toLowerCase().contains(q);
//       }).toList();
//     }

//     return result;
//   }

//   // ---------------- NAV ----------------
//   void _onNavTap(int index) {
//     setState(() => _selectedIndex = index);
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   // ---------------- DATA ----------------
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
//       backgroundColor: Colors.grey[50],
//       drawer: const AppDrawer(), // ✅ Drawer fixed

//       appBar: _buildAppBar(),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (i) => setState(() => _selectedIndex = i),
//         children: [
//           _buildHome(),
//           const CategoriesPage(),
//           const LoginPage(),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black,
//       elevation: 0,
//       leading: _selectedIndex == 0
//           ? Builder(
//               builder: (context) => IconButton(
//                 icon: const Icon(Icons.menu),
//                 onPressed: () => Scaffold.of(context).openDrawer(),
//               ),
//             )
//           : null,
//       title: _selectedIndex == 0 && _isSearchOpen
//           ? TextField(
//               controller: _searchController,
//               autofocus: true,
//               onChanged: _onSearchChanged,
//               decoration: const InputDecoration(
//                 hintText: 'Search laptops...',
//                 border: InputBorder.none,
//               ),
//             )
//           : Text(
//               _selectedIndex == 0
//                   ? 'Laptop Harbor'
//                   : _selectedIndex == 1
//                       ? 'Categories'
//                       : 'Profile',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//       actions: _selectedIndex == 0
//           ? [
//               IconButton(
//                 icon: Icon(_isSearchOpen ? Icons.close : Icons.search),
//                 onPressed: _toggleSearch,
//               ),
//               IconButton(
//                 icon: const Icon(Icons.filter_list),
//                 onPressed: _showFilterDialog,
//               ),
//               IconButton(
//                 icon: const Icon(Icons.shopping_cart_outlined),
//                 onPressed: () {},
//               ),
//             ]
//           : null,
//     );
//   }

//   Widget _buildHome() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           _hero(),
//           _section('🔥 Hot Deals', _hotDeals(), Colors.red),
//           _section('✨ New Arrivals', _newArrivals(), Colors.blue),
//           _section('💰 Most Sale', _mostSale(), Colors.green),
//           _section('💎 Premium', _premium(), Colors.purple),
//           _allProducts(),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _hero() {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       height: 160,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         gradient: LinearGradient(
//           colors: [Colors.red.shade700, Colors.red.shade400],
//         ),
//       ),
//       child: const Center(
//         child: Text(
//           'Up to 30% OFF',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _section(String title, List<LaptopModel> items, Color color) {
//     if (items.isEmpty) return const SizedBox();

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               Text(title,
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold)),
//               const Spacer(),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) =>
//                           ViewAllProductsPage(title: title, products: items),
//                     ),
//                   );
//                 },
//                 child: Text('View All', style: TextStyle(color: color)),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 320,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: items.length,
//             itemBuilder: (_, i) => SizedBox(
//               width: 190,
//               child: LaptopCard(
//                 laptop: items[i],
//                 onFavorite: () {},
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) =>
//                           LaptopDetailScreen(laptop: items[i]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _allProducts() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.all(16),
//       itemCount: filteredLaptops.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.7,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//       ),
//       itemBuilder: (_, i) => LaptopCard(
//         laptop: filteredLaptops[i],
//         onFavorite: () {},
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) =>
//                   LaptopDetailScreen(laptop: filteredLaptops[i]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onNavTap,
//       selectedItemColor: Colors.red,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _navController.dispose();
//     _searchController.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:laptop_harbor/auth/login_page.dart';
import 'package:laptop_harbor/data/laptop_data.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/pages/CategoriesPage.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
import 'package:laptop_harbor/pages/view_all_product.dart';
import 'package:laptop_harbor/widgets/app_drawer.dart';
import 'package:laptop_harbor/widgets/filter_dialog.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';

class LaptopHomePage extends StatefulWidget {
  const LaptopHomePage({super.key});

  @override
  State<LaptopHomePage> createState() => _LaptopHomePageState();
}

class _LaptopHomePageState extends State<LaptopHomePage>
    with TickerProviderStateMixin {
  List<LaptopModel> laptops = [];
  List<LaptopModel> filteredLaptops = [];

  int _selectedIndex = 0;
  bool _isSearchOpen = false;

  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();

  FilterOptions _filterOptions = FilterOptions();

  late AnimationController _navController;
  late List<Animation<double>> _iconAnimations;
  late List<Animation<double>> _scaleAnimations;

  String selectedBrand = 'All';

  @override
  void initState() {
    super.initState();

    laptops = laptopData;
    filteredLaptops = laptops;

    _navController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _iconAnimations = List.generate(
      3,
      (i) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _navController,
          curve: Interval(i * 0.2, 0.6 + (i * 0.2),
              curve: Curves.easeOutBack),
        ),
      ),
    );

    _scaleAnimations = List.generate(
      3,
      (_) => Tween<double>(begin: 0.85, end: 1).animate(
        CurvedAnimation(parent: _navController, curve: Curves.easeOutBack),
      ),
    );

    _navController.forward();
  }

  // ---------------- SEARCH ----------------
  void _toggleSearch() {
    setState(() {
      _isSearchOpen = !_isSearchOpen;
      if (!_isSearchOpen) {
        _searchController.clear();
        filteredLaptops = laptops;
      }
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredLaptops = _applyFilters();
    });
  }

  // ---------------- FILTER ----------------
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (_) => FilterDialog(
        currentFilters: _filterOptions,
        onApply: (newFilters) {
          setState(() {
            _filterOptions = newFilters;
            filteredLaptops = _applyFilters();
          });
        },
      ),
    );
  }

  List<LaptopModel> _applyFilters() {
    var result = laptops;

    // Apply price filter
    result = result.where((l) {
      return l.price >= _filterOptions.priceRange.start &&
          l.price <= _filterOptions.priceRange.end;
    }).toList();

    // Apply brand filter only if brands are selected
    if (_filterOptions.selectedBrands.isNotEmpty) {
      result = result
          .where((l) => _filterOptions.selectedBrands.contains(l.brand))
          .toList();
    }

    // Apply RAM filter only if RAM sizes are selected
    if (_filterOptions.selectedRamSizes.isNotEmpty) {
      result = result
          .where((l) => _filterOptions.selectedRamSizes.contains(l.ram))
          .toList();
    }

    // If search is open, also apply search query
    if (_isSearchOpen && _searchController.text.isNotEmpty) {
      final q = _searchController.text.toLowerCase();
      result = result.where((l) {
        return l.name.toLowerCase().contains(q) ||
            l.brand.toLowerCase().contains(q) ||
            l.processor.toLowerCase().contains(q);
      }).toList();
    }

    return result;
  }

  // ---------------- NAV ----------------
  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ---------------- DATA ----------------
  List<LaptopModel> _hotDeals() =>
      laptops.where((l) => l.isHotDeal).take(6).toList();

  List<LaptopModel> _newArrivals() =>
      laptops.where((l) => l.isNewArrival).take(6).toList();

  List<LaptopModel> _mostSale() =>
      laptops.where((l) => l.isMostSale).take(6).toList();

  List<LaptopModel> _premium() =>
      laptops.where((l) => l.price > 150000).take(6).toList();

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: const AppDrawer(),

      appBar: _buildAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _selectedIndex = i),
        children: [
          _buildHome(),
          const CategoriesPage(),
          const LoginPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      leading: _selectedIndex == 0
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: _selectedIndex == 0 && _isSearchOpen
          ? TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search laptops...',
                border: InputBorder.none,
              ),
            )
          : Text(
              _selectedIndex == 0
                  ? 'Laptop Harbor'
                  : _selectedIndex == 1
                      ? 'Categories'
                      : 'Profile',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
      actions: _selectedIndex == 0
          ? [
              IconButton(
                icon: Icon(_isSearchOpen ? Icons.close : Icons.search),
                onPressed: _toggleSearch,
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showFilterDialog,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
            ]
          : null,
    );
  }

  Widget _buildHome() {
    // Check if search/filter is active
    bool isFiltering = _isSearchOpen ||
        _filterOptions.selectedBrands.isNotEmpty ||
        _filterOptions.selectedRamSizes.isNotEmpty ||
        _filterOptions.priceRange.start > 0 ||
        _filterOptions.priceRange.end <
            laptops.map((e) => e.price).reduce((a, b) => a > b ? a : b);

    if (isFiltering) {
      // Only show filtered laptops grid
      return SingleChildScrollView(
        child: Column(
          children: [
            _allProducts(),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    // Normal home sections
    return SingleChildScrollView(
      child: Column(
        children: [
          _hero(),
          _section('🔥 Hot Deals', _hotDeals(), Colors.red),
          _section('✨ New Arrivals', _newArrivals(), Colors.blue),
          _section('💰 Most Sale', _mostSale(), Colors.green),
          _section('💎 Premium', _premium(), Colors.purple),
          _allProducts(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.red.shade700, Colors.red.shade400],
        ),
      ),
      child: const Center(
        child: Text(
          'Up to 30% OFF',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<LaptopModel> items, Color color) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ViewAllProductsPage(title: title, products: items),
                    ),
                  );
                },
                child: Text('View All', style: TextStyle(color: color)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (_, i) => SizedBox(
              width: 190,
              child: LaptopCard(
                laptop: items[i],
                onFavorite: () {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LaptopDetailScreen(laptop: items[i]),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _allProducts() {
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
        onFavorite: () {},
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  LaptopDetailScreen(laptop: filteredLaptops[i]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onNavTap,
      selectedItemColor: Colors.red,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  @override
  void dispose() {
    _navController.dispose();
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}

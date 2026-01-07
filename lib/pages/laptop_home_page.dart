// ignore_for_file: unused_element

import 'package:flutter/material.dart';
// import 'package:laptop_harbor/Admin/admin.dart';
// import 'package:laptop_harbor/auth/login_page.dart';
import 'package:laptop_harbor/data/laptop_data.dart';
// import 'package:laptop_harbor/models/Admin/admin.dart';
import 'package:laptop_harbor/pages/orders_page.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/pages/CategoriesPage.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
// import 'package:laptop_harbor/pages/orders_page.dart';
import 'package:laptop_harbor/pages/profile_page.dart';
// import 'package:laptop_harbor/pages/view_all_product.dart';
import 'package:laptop_harbor/pages/wishlist_page.dart';
import 'package:laptop_harbor/widgets/app_drawer.dart';
import 'package:laptop_harbor/widgets/custom_app_bar.dart';
import 'package:laptop_harbor/widgets/custom_bottom_nav.dart';
import 'package:laptop_harbor/widgets/filter_dialog.dart';
import 'package:laptop_harbor/widgets/hero_section.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';

class LaptopHomePage extends StatefulWidget {
  const LaptopHomePage({super.key});

  @override
  State<LaptopHomePage> createState() => _LaptopHomePageState();
}

class _LaptopHomePageState extends State<LaptopHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();

  List<LaptopModel> laptops = [];
  List<LaptopModel> filteredLaptops = [];

  int _selectedIndex = 0;
  bool _isSearchOpen = false;

  FilterOptions _filterOptions = FilterOptions();

  @override
  void initState() {
    super.initState();
    laptops = laptopData;
    filteredLaptops = laptops;
  }

  // ================= SEARCH =================
  void _onSearchChanged(String query) {
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
    setState(() => _selectedIndex = index);
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

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        onClose: () => Navigator.pop(context),
        profile: const {
          'name': 'John Doe',
          'title': 'Premium Member',
          'avatar':
              'https://api.dicebear.com/7.x/avataaars/svg?seed=John',
        },
      ),
      body: Column(
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
              onMenuClick: () =>
                  _scaffoldKey.currentState?.openDrawer(),
              onCartClick: () {},
              
              cartCount: 3, onNotificationClick: () {  }, onSearchClick: () {  }, onClose: () {  },
            ),

          /// ✅ PAGES
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) =>
                  setState(() => _selectedIndex = i),
              children: [
                _buildHome(),
                const CategoriesPage(),
                const OrderPage(),
                const WishlistPage(),
                // const AdminDashboard(),
                const ProfilePage(),
              ],
            ),
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
    bool isFiltering =
        _searchController.text.isNotEmpty ||
        _filterOptions.selectedBrands.isNotEmpty ||
        _filterOptions.selectedRamSizes.isNotEmpty ||
        _filterOptions.priceRange.start > 0 ||
        _filterOptions.priceRange.end <
            laptops.map((e) => e.price).reduce((a, b) => a > b ? a : b);

    // 🔍 SEARCH / FILTER MODE
    if (isFiltering) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _allProducts(),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    // 🏠 NORMAL HOME
    return SingleChildScrollView(
      child: Column(
        children: [
          // _hero(),
          const HeroSection(),
          _section('🔥 Hot Deals', _hotDeals()),
          _section('✨ New Arrivals', _newArrivals()),
          _section('💰 Most Sale', _mostSale()),
          _section('💎 Premium', _premium()),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF1E40AF)],
        ),
      ),
      child: const Center(
        child: Text(
          'Up to 30% OFF on Premium Laptops',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _section(String title, List<LaptopModel> items) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                onFavorite: () {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          LaptopDetailScreen(laptop: items[i]),
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
    if (filteredLaptops.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: filteredLaptops.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
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

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}


// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:laptop_harbor/pages/orders_page.dart';
import 'package:laptop_harbor/pages/profile_page.dart';
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

  late AnimationController _sectionController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadLaptops();
  }

  void _setupAnimations() {
    _sectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _sectionController,
      curve: Curves.easeOutCubic,
    ));
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
      
      _sectionController.forward();
      
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
    _sectionController.reset();
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

    result = result.where((l) {
      return l.price >= _filterOptions.priceRange.start &&
          l.price <= _filterOptions.priceRange.end;
    }).toList();

    if (_filterOptions.selectedBrands.isNotEmpty) {
      result = result
          .where((l) => _filterOptions.selectedBrands.contains(l.brand))
          .toList();
    }

    if (_filterOptions.selectedRamSizes.isNotEmpty) {
      result = result
          .where((l) => _filterOptions.selectedRamSizes.contains(l.ram))
          .toList();
    }

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
    final shuffled = List<LaptopModel>.from(laptops)..shuffle();
    return shuffled.take(6).toList();
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F7FA),
      drawer: AppDrawer(
        onClose: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
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
              onThemeChanged: null,
              cartCount: 0,
              onNotificationClick: () {},
              onSearchClick: () {},
              onClose: () {},
            ),

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
                UserOrdersPage(),
                const WishlistPage(),
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
    // Beautiful Loading Animation - Same as Profile Page
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer rotating circle
                      Transform.rotate(
                        angle: value * 2 * 3.14159,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue[300]!,
                              width: 3,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue[400]!,
                                Colors.transparent,
                              ],
                              stops: const [0.5, 0.5],
                            ),
                          ),
                        ),
                      ),
                      // Inner pulsing circle
                      Container(
                        width: 60 + (value * 10),
                        height: 60 + (value * 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue[400]!.withOpacity(1 - value * 0.3),
                              Colors.blue[600]!.withOpacity(1 - value * 0.3),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 20 * value,
                              spreadRadius: 5 * value,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.laptop_mac_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  );
                },
                onEnd: () {
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: 32),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: const Text(
                      'Loading laptops...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
              ElevatedButton(
                onPressed: _handleRefresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
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
              ElevatedButton(
                onPressed: _handleRefresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Refresh',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
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

    if (isFiltering) {
      return RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue[700],
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _allProducts(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: Colors.blue[700],
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const HeroSection(),
            const SizedBox(height: 10),
            _section('🔥 Hot Deals', _hotDeals(), 0),
            _section('✨ New Arrivals', _newArrivals(), 1),
            _section('💰 Most Sale', _mostSale(), 2),
            _section('💎 Premium', _premium(), 3),
            _section('🎯 For You', _forYou(), 4),
            _allProducts(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<LaptopModel> items, int index) {
    if (items.isEmpty) return const SizedBox();

    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _sectionController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[600]!, Colors.blue[800]!],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue[400]!.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
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
                              builder: (_) =>
                                  LaptopDetailScreen(laptop: items[i]),
                            ),
                          );
                        },
                        onFavorite: () {
                          wishlistProvider.toggleWishlist(items[i].id);
                        },
                        isInWishlist:
                            wishlistProvider.isInWishlist(items[i].id),
                        showWishlistButton: true,
                        onWishlistToggle: () {
                          wishlistProvider.toggleWishlist(items[i].id);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[600]!, Colors.blue[800]!],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[400]!.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.grid_view_rounded, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'All Products (${filteredLaptops.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
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
                      builder: (_) =>
                          LaptopDetailScreen(laptop: filteredLaptops[i]),
                    ),
                  );
                },
                onFavorite: () {
                  wishlistProvider.toggleWishlist(filteredLaptops[i].id);
                },
                isInWishlist:
                    wishlistProvider.isInWishlist(filteredLaptops[i].id),
                showWishlistButton: true,
                onWishlistToggle: () {
                  wishlistProvider.toggleWishlist(filteredLaptops[i].id);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _sectionController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
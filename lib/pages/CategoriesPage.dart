import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/services/firestore_service.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';
import 'package:laptop_harbor/providers/wishlist_provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  
  String _selectedCategory = 'All';
  List<LaptopModel> _laptops = [];
  List<LaptopModel> _filteredLaptops = [];
  bool _isLoading = true;
  String _errorMessage = '';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.laptop, 'gradient': [Color(0xFF667EEA), Color(0xFF764BA2)]},
    {'name': 'Gaming', 'icon': Icons.sports_esports, 'gradient': [Color(0xFFFF6B6B), Color(0xFFFF8E53)]},
    {'name': 'Business', 'icon': Icons.business_center, 'gradient': [Color(0xFF4FACFE), Color(0xFF00F2FE)]},
    {'name': 'Student', 'icon': Icons.school, 'gradient': [Color(0xFF43E97B), Color(0xFF38F9D7)]},
    {'name': 'Premium', 'icon': Icons.diamond, 'gradient': [Color(0xFFFA709A), Color(0xFFFEE140)]},
    {'name': 'Budget', 'icon': Icons.savings, 'gradient': [Color(0xFF30CFD0), Color(0xFF330867)]},
    {'name': 'Workstation', 'icon': Icons.work, 'gradient': [Color(0xFFA8EDEA), Color(0xFFFED6E3)]},
    {'name': 'Ultrabook', 'icon': Icons.laptop_chromebook, 'gradient': [Color(0xFFFFD89B), Color(0xFF19547B)]},
  ];

  @override
  void initState() {
    super.initState();
    _loadLaptops();
  }

  Future<void> _loadLaptops() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final laptops = await _firestoreService.getAllLaptops();
      
      if (!mounted) return;
      
      setState(() {
        _laptops = laptops;
        _filterByCategory(_selectedCategory);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _errorMessage = 'Failed to load laptops: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    if (!mounted) return;
    
    await _firestoreService.clearCache();
    await _loadLaptops();
  }

  void _filterByCategory(String category) {
    if (!mounted) return;
    
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredLaptops = _laptops;
      } else {
        _filteredLaptops = _laptops
            .where((laptop) => laptop.category == category)
            .toList();
      }
    });
  }

  void _toggleWishlist(String laptopId, BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    wishlistProvider.toggleWishlist(laptopId);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              wishlistProvider.isInWishlist(laptopId)
                ? Icons.favorite
                : Icons.favorite_border,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              wishlistProvider.isInWishlist(laptopId)
                ? 'Added to wishlist'
                : 'Removed from wishlist',
            ),
          ],
        ),
        backgroundColor: wishlistProvider.isInWishlist(laptopId)
          ? Colors.green[600]
          : Colors.red[600],
        duration: const Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'All Laptops',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              bool isSmallScreen = screenWidth < 400;
              
              return TextButton(
                onPressed: _handleRefresh,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue[700],
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 12 : 16,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  'Refresh',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          
          return SafeArea(
            child: Column(
              children: [
                // Categories Tabs
                Container(
                  height: _calculateCategoriesHeight(screenWidth),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _calculateHorizontalPadding(screenWidth),
                        vertical: _calculateVerticalPadding(screenWidth),
                      ),
                      child: Row(
                        children: _categories.asMap().entries.map((entry) {
                          final index = entry.key;
                          final category = entry.value;
                          final isSelected = _selectedCategory == category['name'];
                          
                          return Padding(
                            padding: EdgeInsets.only(right: _calculateCategorySpacing(screenWidth)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _filterByCategory(category['name'] as String),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: _calculateCategoryWidth(screenWidth),
                                  height: _calculateCategoryHeight(screenWidth),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                      ? LinearGradient(
                                          colors: category['gradient'] as List<Color>,
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                    color: isSelected ? null : Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected 
                                        ? Colors.transparent 
                                        : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                    boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: (category['gradient'] as List<Color>)[0].withOpacity(0.2),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        category['icon'] as IconData,
                                        color: isSelected ? Colors.white : Colors.grey[700],
                                        size: _calculateIconSize(screenWidth),
                                      ),
                                      SizedBox(height: _calculateIconSpacing(screenWidth)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(
                                          category['name'] as String,
                                          style: TextStyle(
                                            fontSize: _calculateFontSize(screenWidth),
                                            fontWeight: FontWeight.w600,
                                            color: isSelected ? Colors.white : Colors.grey[700],
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // Products Grid
                Expanded(
                  child: _buildBody(context, screenWidth, screenHeight),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Responsive calculation methods
  double _calculateCategoriesHeight(double screenWidth) {
    if (screenWidth < 360) return 80;
    if (screenWidth < 600) return 85;
    return 90;
  }

  double _calculateCategoryWidth(double screenWidth) {
    if (screenWidth < 360) return 60;
    if (screenWidth < 600) return 65;
    return 70;
  }

  double _calculateCategoryHeight(double screenWidth) {
    if (screenWidth < 360) return 60;
    if (screenWidth < 600) return 65;
    return 70;
  }

  double _calculateCategorySpacing(double screenWidth) {
    if (screenWidth < 360) return 6;
    if (screenWidth < 600) return 8;
    return 10;
  }

  double _calculateIconSize(double screenWidth) {
    if (screenWidth < 360) return 20;
    if (screenWidth < 600) return 22;
    return 24;
  }

  double _calculateIconSpacing(double screenWidth) {
    if (screenWidth < 360) return 3;
    if (screenWidth < 600) return 4;
    return 5;
  }

  double _calculateFontSize(double screenWidth) {
    if (screenWidth < 360) return 9;
    if (screenWidth < 600) return 10;
    return 11;
  }

  double _calculateHorizontalPadding(double screenWidth) {
    if (screenWidth < 360) return 8;
    if (screenWidth < 600) return 10;
    return 12;
  }

  double _calculateVerticalPadding(double screenWidth) {
    if (screenWidth < 360) return 8;
    if (screenWidth < 600) return 10;
    return 12;
  }

  Widget _buildBody(BuildContext context, double screenWidth, double screenHeight) {
    // Beautiful Loading Animation - Same as Home Page
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
                          Icons.category_rounded,
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
                      'Loading Laptops...',
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
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(screenWidth < 360 ? 16 : 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth < 360 ? 16 : 24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.red[100]!, Colors.red[50]!],
                  ),
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: screenWidth < 360 ? 48 : 64,
                  color: Colors.red[600],
                ),
              ),
              SizedBox(height: screenWidth < 360 ? 16 : 24),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth < 360 ? 8 : 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 12 : 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: screenWidth < 360 ? 24 : 32),
              ElevatedButton(
                onPressed: _handleRefresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth < 360 ? 24 : 32,
                    vertical: screenWidth < 360 ? 12 : 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth < 360 ? 14 : 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Empty State
    if (_filteredLaptops.isEmpty) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(screenWidth < 360 ? 16 : 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth < 360 ? 16 : 24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.grey[200]!, Colors.grey[100]!],
                  ),
                ),
                child: Icon(
                  Icons.laptop_chromebook_rounded,
                  size: screenWidth < 360 ? 60 : 80,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: screenWidth < 360 ? 16 : 24),
              Text(
                'No laptops in $_selectedCategory',
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth < 360 ? 8 : 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Try selecting a different category',
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 12 : 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenWidth < 360 ? 24 : 32),
              ElevatedButton(
                onPressed: () => _filterByCategory('All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth < 360 ? 20 : 28,
                    vertical: screenWidth < 360 ? 12 : 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'View All Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth < 360 ? 14 : 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Products Grid
    return OrientationBuilder(
      builder: (context, orientation) {
        return RefreshIndicator(
          onRefresh: _handleRefresh,
          color: Colors.purple[600],
          backgroundColor: Colors.white,
          child: Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, child) {
              return GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(screenWidth < 360 ? 10 : 14),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _calculateCrossAxisCount(screenWidth, orientation),
                  childAspectRatio: 0.7,
                  crossAxisSpacing: screenWidth < 360 ? 8 : 12,
                  mainAxisSpacing: screenWidth < 360 ? 8 : 12,
                ),
                itemCount: _filteredLaptops.length,
                itemBuilder: (context, index) {
                  final laptop = _filteredLaptops[index];
                  
                  return LaptopCard(
                    laptop: laptop,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaptopDetailScreen(laptop: laptop),
                        ),
                      );
                    },
                    showWishlistButton: true,
                    isInWishlist: wishlistProvider.isInWishlist(laptop.id),
                    onFavorite: () {},
                    onWishlistToggle: () {},
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  // Grid responsive calculation
  int _calculateCrossAxisCount(double screenWidth, Orientation orientation) {
    if (orientation == Orientation.landscape) {
      if (screenWidth < 600) return 3;
      if (screenWidth < 900) return 4;
      if (screenWidth < 1200) return 5;
      return 6;
    } else {
      if (screenWidth < 360) return 2;
      if (screenWidth < 600) return 2;
      if (screenWidth < 900) return 3;
      if (screenWidth < 1200) return 4;
      return 5;
    }
  }
}
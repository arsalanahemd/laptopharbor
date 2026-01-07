// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';
import 'package:laptop_harbor/data/laptop_data.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String selectedBrand = 'All';

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 🔹 UNIQUE BRANDS
    final brands = [
      'All',
      ...laptopData.map((e) => e.brand).toSet(),
    ];

    // 🔹 FILTER LOGIC
    final filteredLaptops = selectedBrand == 'All'
        ? laptopData
        : laptopData.where((e) => e.brand == selectedBrand).toList();

    // 🔹 RESPONSIVE GRID SETTINGS
    int crossAxisCount = 2;
    double childAspectRatio = 0.7;
    
    if (screenWidth > 900) {
      crossAxisCount = 4;
      childAspectRatio = 0.75;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
      childAspectRatio = 0.72;
    } else if (screenWidth < 360) {
      // Very small screens
      crossAxisCount = 2;
      childAspectRatio = 0.65;
    }

    return Column(
      children: [
        // 🔹 BRAND FILTER CHIPS - Fixed Height
        Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade50, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              final isSelected = brand == selectedBrand;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      selectedBrand = brand;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.indigo.shade600,
                              ],
                            )
                          : null,
                      color: isSelected ? null : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : Colors.grey.shade300,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? Colors.blue.withOpacity(0.4)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: isSelected ? 12 : 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        Text(
                          brand,
                          style: TextStyle(
                            color: isSelected 
                                ? Colors.white 
                                : Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth < 360 ? 13 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // 🔹 PRODUCT COUNT - Responsive Padding
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth < 360 ? 12 : 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${filteredLaptops.length} Products Found',
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Optional: Sort/Filter icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.tune,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),

        // 🔹 PRODUCTS GRID - Fully Responsive
        Expanded(
          child: filteredLaptops.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth < 360 ? 100 : 120,
                        height: screenWidth < 360 ? 100 : 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade50,
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.laptop_chromebook,
                          size: screenWidth < 360 ? 50 : 60,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'No Laptops Found',
                        style: TextStyle(
                          fontSize: screenWidth < 360 ? 16 : 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try selecting a different brand',
                        style: TextStyle(
                          fontSize: screenWidth < 360 ? 12 : 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate dynamic card width and height
                    final cardWidth = 
                        (constraints.maxWidth - (crossAxisCount + 1) * 12) / 
                        crossAxisCount;
                    final cardHeight = cardWidth / childAspectRatio;
                    
                    return GridView.builder(
                      padding: EdgeInsets.all(screenWidth < 360 ? 8 : 12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: screenWidth < 360 ? 8 : 12,
                        mainAxisSpacing: screenWidth < 360 ? 8 : 12,
                        childAspectRatio: cardWidth / cardHeight,
                      ),
                      itemCount: filteredLaptops.length,
                      itemBuilder: (context, index) {
                        final laptop = filteredLaptops[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    LaptopDetailScreen(laptop: laptop),
                              ),
                            );
                          },
                          child: LaptopCard(
                            laptop: laptop,
                            onFavorite: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${laptop.name} added to favorites',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth < 360 ? 12 : 16,
                                    vertical: 10,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ============================================
// ADDITIONAL: Responsive Helper Class
// ============================================

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 900;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }

  static int getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  static double getCardAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 0.75;
    if (width >= 600) return 0.72;
    if (width < 360) return 0.65;
    return 0.7;
  }
}
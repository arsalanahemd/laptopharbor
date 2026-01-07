// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/data/laptop_data.dart';

class ViewAllProductsPage extends StatefulWidget {
  final String? category;
  final String title;

  const ViewAllProductsPage({
    Key? key,
    this.category,
    this.title = 'All Products', required List<LaptopModel> products,
  }) : super(key: key);

  @override
  State<ViewAllProductsPage> createState() => _ViewAllProductsPageState();
}

class _ViewAllProductsPageState extends State<ViewAllProductsPage> {
  String selectedSort = 'Featured';
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Premium',
    'Gaming',
    'Business',
    'Budget',
  ];

  final List<String> sortOptions = [
    'Featured',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
  ];

  /// 🔍 Filter + Sort Logic
  List<LaptopModel> get filteredLaptops {
    List<LaptopModel> filtered = [...laptopData];

    // Category filter
    if (widget.category != null) {
      filtered =
          filtered.where((l) => l.category == widget.category).toList();
    } else if (selectedCategory != 'All') {
      filtered =
          filtered.where((l) => l.category == selectedCategory).toList();
    }

    // Sorting
    switch (selectedSort) {
      case 'Price: Low to High':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        break;
    }

    return filtered;
  }

  /// 📱 Responsive grid count
  int _crossAxisCount(double width) {
    if (width >= 1100) return 4; // Desktop
    if (width >= 800) return 3; // Tablet
    return 2; // Mobile
  }

  double _childAspectRatio(double width) {
    if (width >= 1100) return 0.72;
    if (width >= 800) return 0.68;
    return 0.65;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.shopping_cart_outlined, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          /// 🔽 FILTER BAR
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (widget.category == null)
                  Expanded(
                    child: _buildDropdown(
                      categories,
                      selectedCategory,
                      (v) => setState(() => selectedCategory = v),
                    ),
                  ),
                if (widget.category == null) const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    sortOptions,
                    selectedSort,
                    (v) => setState(() => selectedSort = v),
                  ),
                ),
              ],
            ),
          ),

          /// 🔢 COUNT
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredLaptops.length} Products Found',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          /// 🧱 GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount(width),
                childAspectRatio: _childAspectRatio(width),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredLaptops.length,
              itemBuilder: (_, i) =>
                  ProductCard(laptop: filteredLaptops[i]),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔽 Dropdown Widget
  Widget _buildDropdown(
    List<String> items,
    String value,
    Function(String) onChanged,
  ) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
          onChanged: (v) => onChanged(v!),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final LaptopModel laptop;

  const ProductCard({Key? key, required this.laptop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  laptop.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.laptop, size: 50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laptop.brand,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    laptop.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${laptop.rating}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' (${laptop.reviews})',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rs ${laptop.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

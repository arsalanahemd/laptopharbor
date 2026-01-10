// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/data/laptop_data.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';

// class FilterDialog {
//   static void show(
//     BuildContext context,
//     Function(List<LaptopModel>) onApply,
//   ) {
//     String? selectedBrand;
//     double minPrice = 0;
//     double maxPrice = 500000;
//     double minRating = 0;

//     final brands = laptopData.map((e) => e.brand).toSet().toList();

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) {
//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Filter Laptops",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),

//                 // Brand Dropdown
//                 DropdownButton<String>(
//                   hint: const Text("Select Brand"),
//                   value: selectedBrand,
//                   items: brands
//                       .map((b) => DropdownMenuItem(
//                             value: b,
//                             child: Text(b),
//                           ))
//                       .toList(),
//                   onChanged: (val) => setState(() => selectedBrand = val),
//                   isExpanded: true,
//                 ),

//                 const SizedBox(height: 16),

//                 // Price Range
//                 Text("Price Range: Rs ${minPrice.toInt()} - Rs ${maxPrice.toInt()}"),
//                 RangeSlider(
//                   min: 0,
//                   max: 500000,
//                   divisions: 100,
//                   values: RangeValues(minPrice, maxPrice),
//                   onChanged: (val) => setState(() {
//                     minPrice = val.start;
//                     maxPrice = val.end;
//                   }),
//                 ),

//                 const SizedBox(height: 16),

//                 // Minimum Rating
//                 Text("Minimum Rating: ${minRating.toStringAsFixed(1)}"),
//                 Slider(
//                   min: 0,
//                   max: 5,
//                   divisions: 10,
//                   value: minRating,
//                   onChanged: (val) => setState(() => minRating = val),
//                 ),

//                 const SizedBox(height: 16),

//                 ElevatedButton(
//                   onPressed: () {
//                     // Apply filter
//                     final filtered = laptopData.where((laptop) {
//                       final matchBrand =
//                           selectedBrand == null || laptop.brand == selectedBrand;
//                       final matchPrice =
//                           laptop.price >= minPrice && laptop.price <= maxPrice;
//                       final matchRating = laptop.rating >= minRating;
//                       return matchBrand && matchPrice && matchRating;
//                     }).toList();

//                     onApply(filtered); // return filtered list
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Apply Filter"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




// claud ai
import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';

class FilterOptions {
  RangeValues priceRange;
  List<String> selectedBrands;
  List<String> selectedProcessors;
  List<int> selectedRamSizes;
  List<int> selectedStorageSizes;
  String sortBy;

  FilterOptions({
    this.priceRange = const RangeValues(0, 500000),
    this.selectedBrands = const [],
    this.selectedProcessors = const [],
    this.selectedRamSizes = const [],
    this.selectedStorageSizes = const [],
    this.sortBy = 'none',
  });

  FilterOptions copyWith({
    RangeValues? priceRange,
    List<String>? selectedBrands,
    List<String>? selectedProcessors,
    List<int>? selectedRamSizes,
    List<int>? selectedStorageSizes,
    String? sortBy,
  }) {
    return FilterOptions(
      priceRange: priceRange ?? this.priceRange,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      selectedProcessors: selectedProcessors ?? this.selectedProcessors,
      selectedRamSizes: selectedRamSizes ?? this.selectedRamSizes,
      selectedStorageSizes: selectedStorageSizes ?? this.selectedStorageSizes,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  bool get hasActiveFilters {
    return selectedBrands.isNotEmpty ||
        selectedProcessors.isNotEmpty ||
        selectedRamSizes.isNotEmpty ||
        selectedStorageSizes.isNotEmpty ||
        (priceRange.start > 0 || priceRange.end < 500000) ||
        sortBy != 'none';
  }

  void reset() {
    priceRange = const RangeValues(0, 500000);
    selectedBrands.clear();
    selectedProcessors.clear();
    selectedRamSizes.clear();
    selectedStorageSizes.clear();
    sortBy = 'none';
  }
}

class FilterDialog extends StatefulWidget {
  final FilterOptions currentFilters;
  final Function(FilterOptions) onApply;

  const FilterDialog({
    super.key,
    required this.currentFilters,
    required this.onApply,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog>
    with SingleTickerProviderStateMixin {
  late FilterOptions _filters;
  late TabController _tabController;

  final List<String> _brands = [
    'Dell',
    'HP',
    'Lenovo',
    'Apple',
    'Asus',
    'Acer',
    'MSI',
    'Microsoft'
  ];

  final List<String> _processors = [
    'Intel Core i5',
    'Intel Core i7',
    'Intel Core i9',
    'AMD Ryzen 5',
    'AMD Ryzen 7',
    'AMD Ryzen 9',
    'Apple M1',
    'Apple M2',
    'Apple M3'
  ];

  final List<int> _ramSizes = [4, 8, 16, 32, 64];
  final List<int> _storageSizes = [128, 256, 512, 1024, 2048];

  @override
  void initState() {
    super.initState();
    _filters = FilterOptions(
      priceRange: widget.currentFilters.priceRange,
      selectedBrands: List.from(widget.currentFilters.selectedBrands),
      selectedProcessors: List.from(widget.currentFilters.selectedProcessors),
      selectedRamSizes: List.from(widget.currentFilters.selectedRamSizes),
      selectedStorageSizes: List.from(widget.currentFilters.selectedStorageSizes),
      sortBy: widget.currentFilters.sortBy,
    );

    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 54, 117, 244),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Laptops',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // TABS
            Container(
              color: Colors.grey[100],
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: const Color.fromARGB(255, 54, 117, 244),
                unselectedLabelColor: Colors.grey[600],
                indicatorColor:const Color.fromARGB(255, 54, 117, 244),
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Price'),
                  Tab(text: 'Brand'),
                  Tab(text: 'Processor'),
                  Tab(text: 'RAM'),
                  Tab(text: 'Storage'),
                ],
              ),
            ),

            // TAB CONTENT
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPriceTab(),
                  _buildBrandTab(),
                  _buildProcessorTab(),
                  _buildRamTab(),
                  _buildStorageTab(),
                ],
              ),
            ),

            // FOOTER BUTTONS
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _filters.reset();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Reset All'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onApply(_filters);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 54, 117, 244),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildPriceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Range',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rs ${_filters.priceRange.start.round()} - Rs ${_filters.priceRange.end.round()}',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          RangeSlider(
            values: _filters.priceRange,
            min: 0,
            max: 500000,
            divisions: 50,
            activeColor: Color.fromARGB(255, 54, 117, 244),
            inactiveColor: Colors.red[100],
            labels: RangeLabels(
              'Rs ${_filters.priceRange.start.round()}',
              'Rs ${_filters.priceRange.end.round()}',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _filters.priceRange = values;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildQuickPriceButtons(),
        ],
      ),
    );
  }

  Widget _buildQuickPriceButtons() {
    final ranges = [
      {'label': 'Under 50k', 'min': 0.0, 'max': 50000.0},
      {'label': '50k - 100k', 'min': 50000.0, 'max': 100000.0},
      {'label': '100k - 200k', 'min': 100000.0, 'max': 200000.0},
      {'label': 'Above 200k', 'min': 200000.0, 'max': 500000.0},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ranges.map((range) {
        return OutlinedButton(
          onPressed: () {
            setState(() {
              _filters.priceRange = RangeValues(
                range['min'] as double,
                range['max'] as double,
              );
            });
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color.fromARGB(255, 54, 117, 244)),
          ),
          child: Text(range['label'] as String),
        );
      }).toList(),
    );
  }

  Widget _buildBrandTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _brands.map((brand) {
        final isSelected = _filters.selectedBrands.contains(brand);
        return CheckboxListTile(
          title: Text(brand),
          value: isSelected,
          activeColor: Color.fromARGB(255, 54, 117, 244),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _filters.selectedBrands.add(brand);
              } else {
                _filters.selectedBrands.remove(brand);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildProcessorTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _processors.map((processor) {
        final isSelected = _filters.selectedProcessors.contains(processor);
        return CheckboxListTile(
          title: Text(processor),
          value: isSelected,
          activeColor: Color.fromARGB(255, 54, 117, 244),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _filters.selectedProcessors.add(processor);
              } else {
                _filters.selectedProcessors.remove(processor);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRamTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _ramSizes.map((ram) {
        final isSelected = _filters.selectedRamSizes.contains(ram);
        return CheckboxListTile(
          title: Text('$ram GB'),
          value: isSelected,
          activeColor: Color.fromARGB(255, 54, 117, 244),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _filters.selectedRamSizes.add(ram);
              } else {
                _filters.selectedRamSizes.remove(ram);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildStorageTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _storageSizes.map((storage) {
        final isSelected = _filters.selectedStorageSizes.contains(storage);
        return CheckboxListTile(
          title: Text('$storage GB'),
          value: isSelected,
          activeColor: Color.fromARGB(255, 54, 117, 244),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _filters.selectedStorageSizes.add(storage);
              } else {
                _filters.selectedStorageSizes.remove(storage);
              }
            });
          },
        );
      }).toList(),
    );
  }
}
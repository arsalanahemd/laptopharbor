// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/widgets/app_bar.dart';
// import 'package:laptop_harbor/widgets/app_drawer.dart';
// import 'package:laptop_harbor/widgets/bottom_nav.dart';
// import '../data/laptop_data.dart';
// import '../widgets/laptop_card.dart';

// class CategoriesPage extends StatefulWidget {
//   const CategoriesPage({super.key});

//   @override
//   State<CategoriesPage> createState() => _CategoriesPageState();
// }

// class _CategoriesPageState extends State<CategoriesPage> {
//   String selectedBrand = 'All';

//   @override
//   Widget build(BuildContext context) {
//     final brands = [
//       'All',
//       ...laptopData.map((e) => e.brand).toSet(),
//     ];

//     final filteredLaptops = selectedBrand == 'All'
//         ? laptopData
//         : laptopData
//             .where((e) => e.brand == selectedBrand)
//             .toList();

//     return Scaffold(
//       appBar: CustomAppBar(
//         isSearchOpen: _isSearchOpen,
//         searchController: _searchController,
//         onToggleSearch: _toggleSearch,
//         onSearchChanged: _onSearchChanged,
//         filterOptions: _filterOptions,
//         onFilterPressed: _showFilterDialog,
//       ),
//       drawer: const AppDrawer(),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           _buildHomePage(brands), // Home tab
//           CategoriesPageWrapper(), // Category tab
//           Container(), // Profile handled separately
//         ],
//       ),
//       bottomNavigationBar: AnimatedBottomNav(
//         selectedIndex: _selectedIndex,
//         onTap: _onNavTap,
//         items: const [
//           BottomNavItem(icon: Icons.home_rounded, label: 'Home'),
//           BottomNavItem(icon: Icons.category_rounded, label: 'Category'),
//           BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
//         ],
//       ),
      
//       body: Column(
//         children: [

//           // 🔹 BRAND FILTER CHIPS
//           SizedBox(
//             height: 55,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               itemCount: brands.length,
//               itemBuilder: (context, index) {
//                 final brand = brands[index];
//                 final isSelected = brand == selectedBrand;

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 6),
//                   child: ChoiceChip(
//                     label: Text(brand),
//                     selected: isSelected,
//                     onSelected: (_) {
//                       setState(() {
//                         selectedBrand = brand;
//                       });
//                     },
//                     selectedColor: Colors.red,
//                     labelStyle: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           const SizedBox(height: 10),

//           // 🔹 PRODUCTS GRID
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(12),
//               gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.7,
//               ),
//               itemCount: filteredLaptops.length,
//               itemBuilder: (context, index) {
//                 return LaptopCard(
//                   laptop: filteredLaptops[index], onFavorite: () {  },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';
import 'package:laptop_harbor/data/laptop_data.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String selectedBrand = 'All';

  @override
  Widget build(BuildContext context) {
    final brands = [
      'All',
      ...laptopData.map((e) => e.brand).toSet(),
    ];

    final filteredLaptops = selectedBrand == 'All'
        ? laptopData
        : laptopData
            .where((e) => e.brand == selectedBrand)
            .toList();

    return Column(
      children: [
        // 🔹 BRAND FILTER CHIPS
        SizedBox(
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              final isSelected = brand == selectedBrand;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  label: Text(brand),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedBrand = brand;
                    });
                  },
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // 🔹 PRODUCTS GRID
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemCount: filteredLaptops.length,
            itemBuilder: (context, index) {
              return LaptopCard(
                laptop: filteredLaptops[index],
                onFavorite: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

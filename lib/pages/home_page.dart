// // import 'package:flutter/material.dart';
// // // import 'package:laptop_harbor/models/laptop_model.dart';
// // // import 'package:laptop_harbor/widgets/product_card.dart';
// // import '../widgets/hero_section.dart';
// // // import '../widgets/product_slider.dart';
// // // import '../models/product.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage>
// //     with SingleTickerProviderStateMixin {

// //   bool showSearch = false;
// //   late AnimationController _controller;
// //   late Animation<double> _animation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 300),
// //     );
// //     _animation = CurvedAnimation(
// //       parent: _controller,
// //       curve: Curves.easeInOut,
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   void toggleSearch() {
// //     setState(() {
// //       showSearch = !showSearch;
// //       showSearch ? _controller.forward() : _controller.reverse();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [

// //               // 🔹 TOP BAR
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   RichText(
// //                     text: TextSpan(
// //                       style: const TextStyle(
// //                         fontSize: 24,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                       children: [
// //                         const TextSpan(
// //                           text: 'Laptop',
// //                           style: TextStyle(color: Colors.black),
// //                         ),
// //                         TextSpan(
// //                           text: 'Harboure',
// //                           style: TextStyle(color: Colors.red),
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                   Row(
// //                     children: [
// //                       IconButton(
// //                         icon: const Icon(Icons.search),
// //                         onPressed: toggleSearch,
// //                       ),
// //                       const CircleAvatar(
// //                         radius: 18,
// //                         child: Icon(Icons.person),
// //                       ),
// //                     ],
// //                   )
// //                 ],
// //               ),

// //               // 🔍 SEARCH BAR (ANIMATED)
// //               SizeTransition(
// //                 sizeFactor: _animation,
// //                 axisAlignment: -1,
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(top: 10),
// //                   child: TextField(
// //                     decoration: InputDecoration(
// //                       hintText: "Search laptops...",
// //                       prefixIcon: const Icon(Icons.search),
// //                       filled: true,
// //                       fillColor: Colors.grey.shade100,
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               // 🎯 HERO SECTION
// //               const HeroSection(),

// //               const SizedBox(height: 20),

// //               // 🖥 TITLE
// //               const Text(
// //                 "Popular Laptops",
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),

// //               const SizedBox(height: 12),

// //               // 🧩 PRODUCT SLIDER (CARDS)
// //               // ProductCard(
// //               //   product:Laptop,
// //               // ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }




// import 'package:flutter/material.dart';
// // import '../models/laptop_model.dart';
// import '../pages/laptop_detail_page.dart';
// import '../widgets/hero_section.dart';
// // import '../data/demo_products.dart';
// import '../data/laptop_data.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {

//   bool showSearch = false;
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   // 🔹 DUMMY LAPTOP DATA
//   // final List<LaptopModel> laptops = [
//   //   LaptopModel(
//   //     id: '1',
//   //     name: 'HP Pavilion 15',
//   //     brand: 'HP',
//   //     imageUrl: 'https://cdn.pixabay.com/photo/2016/03/27/07/12/apple-1282241_1280.jpg',
//   //     price: 85000,
//   //     originalPrice: 95000,
//   //     processor: 'Intel Core i5',
//   //     ram: '8GB',
//   //     storage: '512GB SSD',
//   //     display: '15.6" FHD',
//   //     rating: 4.5,
//   //     reviews: 120,
//   //     inStock: true,
//   //     features: ['Backlit Keyboard', 'WiFi 6'],
//   //   ),
//   //   LaptopModel(
//   //     id: '2',
//   //     name: 'Dell Inspiron 14',
//   //     brand: 'Dell',
//   //     imageUrl: 'https://cdn.pixabay.com/photo/2014/05/02/21/49/home-office-336373_1280.jpg',
//   //     price: 92000,
//   //     originalPrice: 102000,
//   //     processor: 'Intel Core i7',
//   //     ram: '16GB',
//   //     storage: '1TB SSD',
//   //     display: '14" FHD',
//   //     rating: 4.7,
//   //     reviews: 98,
//   //     inStock: true,
//   //     features: ['Fingerprint', 'Fast Charging'], images: [], graphics: '', battery: '', weight: '', description: '',
//   //   ),
//   // ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void toggleSearch() {
//     setState(() {
//       showSearch = !showSearch;
//       showSearch ? _controller.forward() : _controller.reverse();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               // 🔹 TOP BAR
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   RichText(
//                     text: const TextSpan(
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: 'Laptop',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         TextSpan(
//                           text: 'Harboure',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.search),
//                         onPressed: toggleSearch,
//                       ),
//                       const CircleAvatar(
//                         radius: 18,
//                         child: Icon(Icons.person),
//                       ),
//                     ],
//                   )
//                 ],
//               ),

//               // 🔍 SEARCH BAR
//               SizeTransition(
//                 sizeFactor: _animation,
//                 axisAlignment: -1,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search laptops...",
//                       prefixIcon: const Icon(Icons.search),
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // 🎯 HERO SECTION
//               const HeroSection(),

//               const SizedBox(height: 20),

//               // 🖥 TITLE
//               const Text(
//                 "Popular Laptops",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // 🧩 LAPTOP GRID
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.65,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: laptopData.length,
//                 itemBuilder: (context, index) {
//                   final laptop = laptopData[index];

//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => LaptopDetailPage(
//                             laptop: laptop,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Image.network(
//                               laptop.imageUrl,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: Text(
//                               laptop.name,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: Text(
//                               'Rs ${laptop.price.toStringAsFixed(0)}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:laptop_harbor/data/laptop_data.dart';
import '../models/laptop_model.dart';
// import '../data/laptop_data.dart'; // Aapki dummy data file
import '../widgets/laptop_card.dart'; // Card widget import

class LaptopHomePage extends StatefulWidget {
  const LaptopHomePage({super.key});

  @override
  State<LaptopHomePage> createState() => _LaptopHomePageState();
}

class _LaptopHomePageState extends State<LaptopHomePage> {
  List<LaptopModel> laptops = [];
  List<LaptopModel> filteredLaptops = [];
  String selectedBrand = 'All';
  
  @override
  void initState() {
    super.initState();
    // laptop_data.dart se data load karo
    laptops = laptopData; // Ya jo bhi function name ho aapki file mein
    filteredLaptops = laptops;
  }

  void _filterByBrand(String brand) {
    setState(() {
      selectedBrand = brand;
      if (brand == 'All') {
        filteredLaptops = laptops;
      } else {
        filteredLaptops = laptops
            .where((laptop) => laptop.brand.toLowerCase() == brand.toLowerCase())
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Unique brands nikalo
    final brands = ['All', ...laptops.map((l) => l.brand).toSet()];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Laptops',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Cart page
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            height: 60,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                final isSelected = selectedBrand == brand;
                
                return GestureDetector(
                  onTap: () => _filterByBrand(brand),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        brand,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Products Count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '${filteredLaptops.length} Products',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const Spacer(),
                // Sort button (optional)
                TextButton.icon(
                  onPressed: () {
                    // Sort options
                  },
                  icon: Icon(Icons.sort, size: 18, color: Colors.grey[700]),
                  label: Text(
                    'Sort',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),

          // Grid View of Laptops
          Expanded(
            child: filteredLaptops.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.laptop_chromebook,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No laptops found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 cards per row
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredLaptops.length,
                    itemBuilder: (context, index) {
                      return LaptopCard(laptop: filteredLaptops[index], onFavorite: () {  }, onTap: () {  },);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
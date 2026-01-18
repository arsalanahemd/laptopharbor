// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/laptop_provider.dart';
// import '../providers/compare_provider.dart';
// import '../models/laptop_model.dart';

// class CompareSearchScreen extends StatefulWidget {
//   final bool isFirst;
//   const CompareSearchScreen({super.key, required this.isFirst});

//   @override
//   State<CompareSearchScreen> createState() => _CompareSearchScreenState();
// }

// class _CompareSearchScreenState extends State<CompareSearchScreen> {
//   @override
//   void initState() {
//     super.initState();

//     /// Fetch laptops only once
//     Future.microtask(() {
//       final provider =
//           Provider.of<LaptopProvider>(context, listen: false);
//       if (provider.laptops.isEmpty) {
//         provider.fetchLaptops();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final laptopProvider = Provider.of<LaptopProvider>(context);
//     final compareProvider =
//         Provider.of<CompareProvider>(context, listen: false);

//     final List<LaptopModel> laptops =
//         laptopProvider.filteredLaptops;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Select Laptop')),
//       body: Column(
//         children: [
//           // 🔍 SEARCH BAR
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Search laptop...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: laptopProvider.searchLaptops,
//             ),
//           ),

//           // 📦 LIST
//           Expanded(
//             child: laptopProvider.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : laptops.isEmpty
//                     ? const Center(child: Text('No laptops found'))
//                     : ListView.builder(
//                         itemCount: laptops.length,
//                         itemBuilder: (_, index) {
//                           final laptop = laptops[index];
//                           return ListTile(
//                             leading: Image.network(
//                               laptop.imageUrl,
//                               width: 50,
//                               errorBuilder: (_, __, ___) =>
//                                   const Icon(Icons.laptop),
//                             ),
//                             title: Text(laptop.name),
//                             subtitle: Text(laptop.formattedPrice),
//                             trailing:
//                                 const Icon(Icons.compare_arrows),
//                             onTap: () {
//                               if (widget.isFirst) {
//                                 compareProvider.setFirstLaptop(laptop);
//                               } else {
//                                 compareProvider.setSecondLaptop(laptop);
//                               }
//                               Navigator.pop(context);
//                             },
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/laptop_provider.dart';
import '../providers/compare_provider.dart';
import '../models/laptop_model.dart';

class CompareSearchScreen extends StatefulWidget {
  final bool isFirst;
  const CompareSearchScreen({super.key, required this.isFirst});

  @override
  State<CompareSearchScreen> createState() => _CompareSearchScreenState();
}

class _CompareSearchScreenState extends State<CompareSearchScreen> {
  // Aapki primary blue theme
  static const Color primaryBlue = Color(0xFF2B7DE0);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<LaptopProvider>(context, listen: false);
      if (provider.laptops.isEmpty) {
        provider.fetchLaptops();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final laptopProvider = Provider.of<LaptopProvider>(context);
    final compareProvider = Provider.of<CompareProvider>(context, listen: false);
    final List<LaptopModel> laptops = laptopProvider.filteredLaptops;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Light grey background
      appBar: AppBar(
        title: const Text('Select Laptop', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // 🔍 STYLISH SEARCH BAR
          _buildSearchBar(laptopProvider),

          // 📦 ENHANCED LIST
          Expanded(
            child: laptopProvider.isLoading
                ? const Center(child: CircularProgressIndicator(color: primaryBlue))
                : laptops.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        physics: const BouncingScrollPhysics(),
                        itemCount: laptops.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (_, index) {
                          final laptop = laptops[index];
                          return _buildLaptopCard(laptop, compareProvider, context);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(LaptopProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: TextField(
          onChanged: provider.searchLaptops,
          decoration: InputDecoration(
            hintText: 'Search brand or model...',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: const Icon(Icons.search, color: primaryBlue),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildLaptopCard(LaptopModel laptop, CompareProvider compareProvider, BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isFirst) {
          compareProvider.setFirstLaptop(laptop);
        } else {
          compareProvider.setSecondLaptop(laptop);
        }
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // Laptop Image Container
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                laptop.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.laptop, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 16),
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laptop.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    laptop.formattedPrice,
                    style: const TextStyle(color: primaryBlue, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.add_circle_outline, color: primaryBlue),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No laptops found',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/pages/compare_seach_bar.dart';
// import 'package:provider/provider.dart';

// import '../providers/compare_provider.dart';
// import '../models/laptop_model.dart';

// class CompareScreen extends StatelessWidget {
//   const CompareScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final compare = Provider.of<CompareProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Compare Laptops')),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // ================= BOXES FOR SELECTING LAPTOPS =================
//             Row(
//               children: [
//                 _CompareBox(
//                   title: 'Laptop A',
//                   laptop: compare.firstLaptop,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             const CompareSearchScreen(isFirst: true),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(width: 10),
//                 _CompareBox(
//                   title: 'Laptop B',
//                   laptop: compare.secondLaptop,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             const CompareSearchScreen(isFirst: false),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // ================= SPECS TABLE =================
//             if (compare.isReady)
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: _CompareTable(
//                     first: compare.firstLaptop!,
//                     second: compare.secondLaptop!,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // =================== COMPARE BOX ===================
// class _CompareBox extends StatelessWidget {
//   final String title;
//   final LaptopModel? laptop;
//   final VoidCallback onTap;

//   const _CompareBox({
//     required this.title,
//     required this.laptop,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 150,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               laptop != null
//                   ? Stack(
//                       children: [
//                         Image.network(
//                           laptop!.imageUrl,
//                           width: 80,
//                           height: 60,
//                           errorBuilder: (_, __, ___) =>
//                               const Icon(Icons.laptop, size: 50),
//                         ),
//                         if (laptop!.isFeatured)
//                           const Positioned(
//                             top: -5,
//                             right: -5,
//                             child: Icon(
//                               Icons.star,
//                               color: Colors.amber,
//                               size: 28,
//                             ),
//                           ),
//                       ],
//                     )
//                   : const SizedBox(height: 60),
//               const SizedBox(height: 8),
//               Text(
//                 laptop?.name ?? '+ Select $title',
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // =================== COMPARE TABLE ===================
// class _CompareTable extends StatelessWidget {
//   final LaptopModel first;
//   final LaptopModel second;

//   const _CompareTable({required this.first, required this.second});

//   @override
//   Widget build(BuildContext context) {
//     final specs = [
//       {
//         'title': 'Price',
//         'val1': first.price,
//         'val2': second.price,
//         'lowerBetter': true
//       },
//       {'title': 'Processor', 'val1': first.processor, 'val2': second.processor},
//       {'title': 'RAM (GB)', 'val1': first.ram, 'val2': second.ram},
//       {'title': 'Storage (GB)', 'val1': first.storage, 'val2': second.storage},
//       {'title': 'Rating', 'val1': first.rating, 'val2': second.rating},
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Comparison',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
//         ),
//         const SizedBox(height: 10),

//         // Spread operator without toList()
//         ...specs.map((spec) {
//           final val1 = spec['val1'];
//           final val2 = spec['val2'];
//           final lowerBetter = (spec['lowerBetter'] ?? false) as bool;

//           final winner = _getWinner(val1, val2, lowerBetter);

//           return _specRow(spec['title']!.toString(), val1, val2, winner: winner);
//         }),
//       ],
//     );
//   }

//   // ================== SPEC ROW WITH WINNER HIGHLIGHT ==================
//   Widget _specRow(String title, dynamic val1, dynamic val2, {int? winner}) {
//     final color1 = (winner == 1) ? Colors.green : Colors.black;
//     final color2 = (winner == 2) ? Colors.green : Colors.black;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '$val1',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: color1),
//                 ),
//                 if (winner == 1)
//                   const Padding(
//                     padding: EdgeInsets.only(left: 4),
//                     child: Icon(Icons.emoji_events,
//                         color: Colors.amber, size: 20),
//                   ),
//               ],
//             ),
//           ),
//           Expanded(
//               child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           )),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '$val2',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: color2),
//                 ),
//                 if (winner == 2)
//                   const Padding(
//                     padding: EdgeInsets.only(left: 4),
//                     child: Icon(Icons.emoji_events,
//                         color: Colors.amber, size: 20),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================== DETERMINE WINNER ==================
//   int? _getWinner(dynamic a, dynamic b, bool lowerBetter) {
//     if (a is num && b is num) {
//       if (lowerBetter) {
//         if (a < b) return 1;
//         if (b < a) return 2;
//       } else {
//         if (a > b) return 1;
//         if (b > a) return 2;
//       }
//     }
//     return null; // non-numeric → no winner
//   }
// }
import 'package:flutter/material.dart';
import 'package:laptop_harbor/pages/compare_seach_bar.dart'; // Spelling check: search_bar?
import 'package:provider/provider.dart';

import '../providers/compare_provider.dart';
import '../models/laptop_model.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final compare = Provider.of<CompareProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        title: const Text('Compare Laptops', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ================= SELECTION AREA =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    _CompareBox(
                      title: 'Laptop A',
                      laptop: compare.firstLaptop,
                      onTap: () => _navigateToSearch(context, true),
                    ),
                    const SizedBox(width: 16),
                    _CompareBox(
                      title: 'Laptop B',
                      laptop: compare.secondLaptop,
                      onTap: () => _navigateToSearch(context, false),
                    ),
                  ],
                ),
                // "VS" Badge
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle, // Custom VS circle
                  ),
                  child: const Text('VS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),

          // ================= SPECS TABLE =================
          Expanded(
            child: compare.isReady
                ? Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      child: _CompareTable(
                        first: compare.firstLaptop!,
                        second: compare.secondLaptop!,
                      ),
                    ),
                  )
                : _buildPlaceholder(),
          ),
        ],
      ),
    );
  }

  void _navigateToSearch(BuildContext context, bool isFirst) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CompareSearchScreen(isFirst: isFirst)),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.compare_arrows_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text('Select two laptops to\nsee their comparison', 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
        ],
      ),
    );
  }
}

// =================== IMPROVED COMPARE BOX ===================
class _CompareBox extends StatelessWidget {
  final String title;
  final LaptopModel? laptop;
  final VoidCallback onTap;

  const _CompareBox({required this.title, required this.laptop, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: laptop != null ? Colors.blue.shade200 : Colors.grey.shade300),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (laptop != null) ...[
                Image.network(laptop!.imageUrl, height: 70, fit: BoxFit.contain),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(laptop!.name, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ] else ...[
                Icon(Icons.add_circle_outline, size: 40, color: Colors.blue.shade300),
                const SizedBox(height: 10),
                Text('Add $title', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// =================== IMPROVED COMPARE TABLE ===================
class _CompareTable extends StatelessWidget {
  final LaptopModel first;
  final LaptopModel second;

  const _CompareTable({required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> specs = [
      {'title': 'Price', 'val1': first.price, 'val2': second.price, 'lowerBetter': true, 'isPrice': true},
      {'title': 'Processor', 'val1': first.processor, 'val2': second.processor},
      {'title': 'RAM (GB)', 'val1': first.ram, 'val2': second.ram},
      {'title': 'Storage (GB)', 'val1': first.storage, 'val2': second.storage},
      {'title': 'Rating', 'val1': first.rating, 'val2': second.rating},
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        const Center(
          child: Text('TECHNICAL SPECIFICATIONS', 
            style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12)),
        ),
        const SizedBox(height: 20),
        ...specs.map((spec) {
          final winner = _getWinner(spec['val1'], spec['val2'], spec['lowerBetter'] ?? false);
          return _buildSpecRow(spec, winner);
        }).toList(),
      ],
    );
  }

  Widget _buildSpecRow(Map<String, dynamic> spec, int? winner) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          _buildValueCell(spec['val1'], winner == 1, spec['isPrice'] ?? false),
          Expanded(
            flex: 2,
            child: Text(spec['title'], textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          _buildValueCell(spec['val2'], winner == 2, spec['isPrice'] ?? false),
        ],
      ),
    );
  }

  Widget _buildValueCell(dynamic value, bool isWinner, bool isPrice) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isWinner) const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 4),
          Text(
            isPrice ? '\$$value' : '$value',
            style: TextStyle(
              fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
              color: isWinner ? Colors.green.shade700 : Colors.black87,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  int? _getWinner(dynamic a, dynamic b, bool lowerBetter) {
    if (a is num && b is num) {
      if (a == b) return null;
      if (lowerBetter) return (a < b) ? 1 : 2;
      return (a > b) ? 1 : 2;
    }
    return null;
  }
}
// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';

// class CompareTable extends StatelessWidget {
//   final LaptopModel first;
//   final LaptopModel second;

//   const CompareTable({super.key, required this.first, required this.second});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         compareRow('Price', first.formattedPrice, second.formattedPrice),
//         compareRow('Processor', first.processor, second.processor),
//         compareRow('RAM', first.ramWithUnit, second.ramWithUnit),
//         compareRow('Storage', first.storageWithUnit, second.storageWithUnit),
//         compareRow('Display', first.display, second.display),
//         compareRow('Rating', first.rating.toString(), second.rating.toString()),
//       ],
//     );
//   }

//   Widget compareRow(String title, String v1, String v2) {
//     return Row(
//       children: [
//         Expanded(child: Text(v1, textAlign: TextAlign.center)),
//         Expanded(child: Text(title, textAlign: TextAlign.center)),
//         Expanded(child: Text(v2, textAlign: TextAlign.center)),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';

class CompareTable extends StatelessWidget {
  final LaptopModel first;
  final LaptopModel second;

  const CompareTable({super.key, required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildRow('Price', first.formattedPrice, second.formattedPrice, isHeader: true),
              _buildRow('Processor', first.processor, second.processor),
              _buildRow('RAM', first.ramWithUnit, second.ramWithUnit),
              _buildRow('Storage', first.storageWithUnit, second.storageWithUnit),
              _buildRow('Display', first.display, second.display),
              _buildRow('Rating', '${first.rating} ⭐', '${second.rating} ⭐', isLast: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String v1, String v2, {bool isHeader = false, bool isLast = false}) {
    return Container(
      // Alternating row colors for better readability
      decoration: BoxDecoration(
        color: title == 'Price' || title == 'RAM' || title == 'Display' 
            ? Colors.grey.shade50 
            : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: [
          // Left Laptop Value
          Expanded(
            flex: 3,
            child: Text(
              v1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? Colors.blue.shade700 : Colors.black87,
              ),
            ),
          ),
          
          // Spec Title (The Center Label)
          Expanded(
            flex: 2,
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Colors.grey.shade500,
                letterSpacing: 0.5,
              ),
            ),
          ),
          
          // Right Laptop Value
          Expanded(
            flex: 3,
            child: Text(
              v2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? Colors.blue.shade700 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
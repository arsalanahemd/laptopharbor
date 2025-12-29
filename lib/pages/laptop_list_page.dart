// import 'package:flutter/material.dart';
// import 'package:laptop_harbor/data/laptop_data.dart';
// import 'package:laptop_harbor/widgets/laptop_card.dart';

// class LaptopListPage extends StatelessWidget {
//   const LaptopListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final laptops = laptopData;
    

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Laptop Store'),
//         backgroundColor: Colors.blue[700],
//         actions: [
//           IconButton(icon: const Icon(Icons.search), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           int crossAxisCount;
//           double childAspectRatio;

//           if (constraints.maxWidth < 600) {
//             crossAxisCount = 2;
//             childAspectRatio = 0.65;
//           } else if (constraints.maxWidth < 900) {
//             crossAxisCount = 3;
//             childAspectRatio = 0.7;
//           } else if (constraints.maxWidth < 1200) {
//             crossAxisCount = 4;
//             childAspectRatio = 0.75;
//           } else {
//             crossAxisCount = 5;
//             childAspectRatio = 0.8;
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: childAspectRatio,
//               ),
//               itemCount: laptops.length,
//               // itemBuilder: (context, index) {
//               //   return LaptopCard(
//               //     laptop: laptops[index],
//               //     onFavorite: () {
//               //       ScaffoldMessenger.of(context).showSnackBar(
//               //         SnackBar(
//               //           content: Text(
//               //             '${laptops[index].description} added to favorites!',
//               //           ),
//               //           duration: const Duration(seconds: 2),
//               //         ),
//               //       );
//               //     },
//               //   );
//               // },

//               itemBuilder: (context, index) {
//   return LaptopCard(
//     laptop: laptops[index],

//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => Laptop(
//             laptop: laptops[index],
//           ),
//         ),
//       );
//     },

//     onFavorite: () {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             '${laptops[index].name} added to favorites!',
//           ),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     },
//   );
// },

//             ),
//           );
//         },
//       ),
//     );
//   }
// }

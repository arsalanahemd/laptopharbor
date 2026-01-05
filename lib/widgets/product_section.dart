// import 'package:flutter/material.dart';
// import '../models/laptop_model.dart';
// import 'laptop_card.dart';
// import '../pages/laptop_detail_screen.dart';

// class ProductSection extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final List<LaptopModel> items;

//   const ProductSection({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.items,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) return const SizedBox();

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold)),
//                   Text(subtitle,
//                       style: const TextStyle(color: Colors.grey)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         SizedBox(
//           height: 320,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: items.length,
//             itemBuilder: (_, i) => SizedBox(
//               width: 190,
//               child: LaptopCard(
//                 laptop: items[i],
//                 onFavorite: () {},
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) =>
//                           LaptopDetailScreen(laptop: items[i]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
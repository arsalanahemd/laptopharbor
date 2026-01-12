// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/wishlist_model.dart';
// import '../providers/wishlist_provider.dart';

// class WishlistButton extends StatelessWidget {
//   final WishlistModel product;

//   const WishlistButton({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final wishlistProvider = Provider.of<WishlistProvider>(context);

//     return FutureBuilder<bool>(
//       future: wishlistProvider.checkWishlist(product.id),
//       builder: (context, snapshot) {
//         bool isFav = snapshot.data ?? false;

//         return IconButton(
//           icon: Icon(
//             isFav ? Icons.favorite : Icons.favorite_border,
//             color: Colors.red,
//           ),
//           onPressed: () async {
//             await wishlistProvider.toggleWishlist(product);
//           },
//         );
//       },
//     );
//   }
// }

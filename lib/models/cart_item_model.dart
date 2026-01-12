// // import 'laptop_model.dart';

// // class CartItem {
// //   final LaptopModel laptop;
// //   int quantity;

// //   CartItem({
// //     required this.laptop,
// //     this.quantity = 1, required Null Function(dynamic qty) onQuantityChanged, required Null Function() onRemove,
// //   });

// //   double get totalPrice => laptop.price * quantity;
// // }
// // lib/models/cart_model.dart
// // lib/models/cart_item_model.dart

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';

// class CartItem {
//   final String id;
//   final String laptopId;
//   final String userId;
//   int quantity; // "late" HATA DO! Yeh simple int rakh do
//   final double price;
//   final LaptopModel laptop;
//   final DateTime addedAt;

//   CartItem({
//     required this.id,
//     required this.laptopId,
//     required this.userId,
//     required this.quantity, // Yeh required rahega
//     required this.price,
//     required this.laptop,
//     required this.addedAt,
//   });

//   /// Total price for this item
//   double get totalPrice => price * quantity;

//   /// Convert to Map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'laptopId': laptopId,
//       'userId': userId,
//       'quantity': quantity, // Yeh quantity field hai
//       'price': price,
//       'addedAt': Timestamp.fromDate(addedAt),
//     };
//   }

//   /// Create from Firestore
//   factory CartItem.fromFirestore(
//     DocumentSnapshot doc,
//     LaptopModel laptop,
//   ) {
//     final data = doc.data() as Map<String, dynamic>;
    
//     return CartItem(
//       id: doc.id,
//       laptopId: data['laptopId'] ?? '',
//       userId: data['userId'] ?? '',
//       quantity: (data['quantity'] ?? 1).toInt(), // Yahan initialize
//       price: (data['price'] ?? 0).toDouble(),
//       laptop: laptop,
//       addedAt: (data['addedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//     );
//   }

//   get items => null;

//   /// CopyWith method
//   CartItem copyWith({
//     String? id,
//     String? laptopId,
//     String? userId,
//     int? quantity, // Yeh nullable hoga
//     double? price,
//     LaptopModel? laptop,
//     DateTime? addedAt,
//   }) {
//     return CartItem(
//       id: id ?? this.id,
//       laptopId: laptopId ?? this.laptopId,
//       userId: userId ?? this.userId,
//       quantity: quantity ?? this.quantity, // Yahan copy karenge
//       price: price ?? this.price,
//       laptop: laptop ?? this.laptop,
//       addedAt: addedAt ?? this.addedAt,
//     );
//   }
// }
import 'package:laptop_harbor/models/laptop_model.dart';

class CartItem {
  final String id;
  final String laptopId;
  final String userId;
  int quantity;
  final double price;
  final LaptopModel laptop;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.laptopId,
    required this.userId,
    required this.quantity,
    required this.price,
    required this.laptop,
    required this.addedAt,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'laptopId': laptopId,
      'userId': userId,
      'quantity': quantity,
      'price': price,
      'laptop': laptop.toJson(),
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id']?.toString() ?? '',
      laptopId: json['laptopId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      quantity: (json['quantity'] ?? 1).toInt(),
      price: (json['price'] ?? 0).toDouble(),
      laptop: LaptopModel.fromJson(json['laptop'] ?? {}, json['laptopId'] ?? ''),
      addedAt: DateTime.parse(json['addedAt']?.toString() ?? DateTime.now().toIso8601String()),
    );
  }

  CartItem copyWith({
    String? id,
    String? laptopId,
    String? userId,
    int? quantity,
    double? price,
    LaptopModel? laptop,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      laptopId: laptopId ?? this.laptopId,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      laptop: laptop ?? this.laptop,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
import 'package:laptop_harbor/models/laptop_model.dart';

class WishlistItem {
  final String id;
  final String laptopId;
  final String userId;
  final LaptopModel laptop;
  final DateTime addedAt;

  WishlistItem({
    required this.id,
    required this.laptopId,
    required this.userId,
    required this.laptop,
    required this.addedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'laptopId': laptopId,
      'userId': userId,
      'laptop': laptop.toJson(),
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id']?.toString() ?? '',
      laptopId: json['laptopId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      laptop: LaptopModel.fromJson(json['laptop'] ?? {}, json['laptopId'] ?? ''),
      addedAt: DateTime.parse(json['addedAt']?.toString() ?? DateTime.now().toIso8601String()),
    );
  }
}
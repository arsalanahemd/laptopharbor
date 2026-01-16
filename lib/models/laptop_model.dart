
// lib/models/laptop_model.dart
class LaptopModel {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String processor;
  final int ram;
  final int storage;
  final String display;
  final double rating;
  final int reviews;
  final bool inStock;
  final List<String> features;
  final String category;
  final bool isHotDeal;
  final bool isMostSale;
  final bool isNewArrival;
  final double discount;

  LaptopModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.processor,
    required this.ram,
    required this.storage,
    required this.display,
    required this.rating,
    required this.reviews,
    required this.inStock,
    required this.features,
    required this.category,
    required this.isHotDeal,
    required this.isMostSale,
    required this.isNewArrival,
    required this.discount,
  });

  /// Convert LaptopModel to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'originalPrice': originalPrice,
      'processor': processor,
      'ram': ram,
      'storage': storage,
      'display': display,
      'rating': rating,
      'reviews': reviews,
      'inStock': inStock,
      'features': features,
      'category': category,
      'isHotDeal': isHotDeal,
      'isMostSale': isMostSale,
      'isNewArrival': isNewArrival,
      'discount': discount,
    };
  }

  /// Create LaptopModel from Map (from Firestore)
  factory LaptopModel.fromMap(Map<String, dynamic> map, String id) {
    return LaptopModel(
      id: id,
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      originalPrice: (map['originalPrice'] ?? 0).toDouble(),
      processor: map['processor'] ?? '',
      ram: (map['ram'] ?? 0).toInt(),
      storage: (map['storage'] ?? 0).toInt(),
      display: map['display'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      reviews: (map['reviews'] ?? 0).toInt(),
      inStock: map['inStock'] ?? true,
      features: List<String>.from(map['features'] ?? []),
      category: map['category'] ?? '',
      isHotDeal: map['isHotDeal'] ?? false,
      isMostSale: map['isMostSale'] ?? false,
      isNewArrival: map['isNewArrival'] ?? false,
      discount: (map['discount'] ?? 0).toDouble(),
    );
  }

  // ==================== ADD THESE TWO METHODS ====================

  /// Convert LaptopModel to JSON (for SharedPreferences/Storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'originalPrice': originalPrice,
      'processor': processor,
      'ram': ram,
      'storage': storage,
      'display': display,
      'rating': rating,
      'reviews': reviews,
      'inStock': inStock,
      'features': features,
      'category': category,
      'isHotDeal': isHotDeal,
      'isMostSale': isMostSale,
      'isNewArrival': isNewArrival,
      'discount': discount,
    };
  }

  /// Create LaptopModel from JSON (from SharedPreferences/Storage)
  factory LaptopModel.fromJson(Map<String, dynamic> json, param1) {
    return LaptopModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0).toDouble(),
      processor: json['processor']?.toString() ?? '',
      ram: (json['ram'] ?? 0).toInt(),
      storage: (json['storage'] ?? 0).toInt(),
      display: json['display']?.toString() ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: (json['reviews'] ?? 0).toInt(),
      inStock: json['inStock'] ?? true,
      features: List<String>.from(json['features'] ?? []),
      category: json['category']?.toString() ?? '',
      isHotDeal: json['isHotDeal'] ?? false,
      isMostSale: json['isMostSale'] ?? false,
      isNewArrival: json['isNewArrival'] ?? false,
      discount: (json['discount'] ?? 0).toDouble(),
    );
  }

  /// CopyWith method for updates
  LaptopModel copyWith({
    String? id,
    String? name,
    String? brand,
    String? imageUrl,
    double? price,
    double? originalPrice,
    String? processor,
    int? ram,
    int? storage,
    String? display,
    double? rating,
    int? reviews,
    bool? inStock,
    List<String>? features,
    String? category,
    bool? isHotDeal,
    bool? isMostSale,
    bool? isNewArrival,
    double? discount,
  }) {
    return LaptopModel(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      processor: processor ?? this.processor,
      ram: ram ?? this.ram,
      storage: storage ?? this.storage,
      display: display ?? this.display,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      inStock: inStock ?? this.inStock,
      features: features ?? this.features,
      category: category ?? this.category,
      isHotDeal: isHotDeal ?? this.isHotDeal,
      isMostSale: isMostSale ?? this.isMostSale,
      isNewArrival: isNewArrival ?? this.isNewArrival,
      discount: discount ?? this.discount,
    );
  }

  // ==================== Helper Getters ====================

  /// Formatted price with currency symbol
  String get formattedPrice => '₹${price.toStringAsFixed(0)}';

  /// Formatted original price with currency symbol
  String get formattedOriginalPrice => '₹${originalPrice.toStringAsFixed(0)}';

  /// Calculate discount amount
  double get discountAmount => originalPrice - price;

  /// Check if product has a discount
  bool get hasDiscount => discount > 0 && originalPrice > price;

  /// RAM with unit (for display)
  String get ramWithUnit => '${ram}GB';

  /// Storage with unit (for display)
  String get storageWithUnit => '${storage}GB SSD';

  /// Discount percentage formatted
  String get discountPercentage => '${discount.toStringAsFixed(0)}% OFF';

  /// Check if product is featured
  bool get isFeatured => category == 'Premium' || isHotDeal || isMostSale;

  /// Rating stars (for display)
  String get ratingStars {
    final fullStars = rating.floor();
    final hasHalfStar = rating - fullStars >= 0.5;
    String stars = '⭐' * fullStars;
    if (hasHalfStar) stars += '½';
    return stars;
  }

  /// Review count formatted (e.g., "1.2K reviews")
  String get formattedReviews {
    if (reviews >= 1000) {
      return '${(reviews / 1000).toStringAsFixed(1)}K reviews';
    }
    return '$reviews reviews';
  }

  /// Stock status message
  String get stockStatus => inStock ? 'In Stock' : 'Out of Stock';

  @override
  String toString() {
    return 'LaptopModel(id: $id, name: $name, brand: $brand, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LaptopModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
class LaptopModel {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String processor;
  final int ram;          // ✅ Changed to int
  final int storage;      // ✅ Changed to int
  final String display;
  final double rating;
  final int reviews;
  final bool inStock;
  final List<String> features;
  final String category;
  final bool isHotDeal;
  final bool isMostSale;
  final bool isNewArrival;

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
  });

  // Discount percentage
  double get discount => ((originalPrice - price) / originalPrice * 100);

  // RAM with unit (for display)
  String get ramWithUnit => '${ram}GB';

  // Storage with unit (for display)
  String get storageWithUnit => '${storage}GB SSD';

  // Check if featured (for sections)
  bool get isFeatured => category == 'Premium' || brand == 'Apple' || brand == 'Dell';

  // Factory method from JSON
  factory LaptopModel.fromJson(Map<String, dynamic> json) {
    return LaptopModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0).toDouble(),
      processor: json['processor'] ?? '',
      ram: json['ram'] ?? 0,
      storage: json['storage'] ?? 0,
      display: json['display'] ?? '',
      rating: (json['rating'] ?? 4.5).toDouble(),
      reviews: json['reviews'] ?? 0,
      inStock: json['inStock'] ?? true,
      features: List<String>.from(json['features'] ?? []),
      category: json['category'] ?? 'General',
      isHotDeal: json['isHotDeal'] ?? false,
      isMostSale: json['isMostSale'] ?? false,
      isNewArrival: json['isNewArrival'] ?? false,
    );
  }

  // Convert to JSON
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
    };
  }
}
class LaptopModel {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String processor;
  final String ram;
  final String storage;
  final String display;
  final double rating;
  final int reviews;
  final bool inStock;
  final List<String> features;

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
  });

  double get discount => 
      ((originalPrice - price) / originalPrice * 100);
}
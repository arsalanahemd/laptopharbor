class WishlistModel {
  final String id;
  final String title;
  final double price;
  final String image;

  WishlistModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'createdAt': DateTime.now(),
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      image: map['image'],
    );
  }
}

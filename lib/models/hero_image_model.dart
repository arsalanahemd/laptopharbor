// lib/models/hero_image_model.dart
class HeroImageModel {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String link;

  HeroImageModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.link,
  });

  factory HeroImageModel.fromMap(Map<String, dynamic> map, String id) {
    return HeroImageModel(
      id: id,
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      link: map['link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'link': link,
    };
  }
}

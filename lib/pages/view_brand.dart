import 'package:flutter/material.dart';
import '../models/laptop_model.dart';
import '../widgets/laptop_card.dart'; // Jo card humne pehle banaya tha

class BrandProductsScreen extends StatelessWidget {
  final String brandName;
  final List<LaptopModel> allLaptops;

  const BrandProductsScreen({super.key, required this.brandName, required this.allLaptops});

  @override
  Widget build(BuildContext context) {
    // 🔥 Yahan logic lagega filter karne ka
    final filteredLaptops = allLaptops
        .where((laptop) => laptop.brand.toLowerCase() == brandName.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("$brandName Laptops"),
        backgroundColor: Colors.blue,
      ),
      body: filteredLaptops.isEmpty
          ? Center(child: Text("No laptops found for $brandName"))
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Ek row mein 2 laptops
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredLaptops.length,
              itemBuilder: (context, index) {
                return LaptopCard(
                  laptop: filteredLaptops[index],
                  onTap: () {
                    // Navigate to Details Screen
                  }, onFavorite: () {  }, onWishlistToggle: () {  },
                );
              },
            ),
    );
  }
}
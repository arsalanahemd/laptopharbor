import 'package:flutter/material.dart';
import 'package:laptop_harbor/data/laptop_data.dart';
import 'package:laptop_harbor/widgets/laptop_card.dart';
import 'package:laptop_harbor/pages/laptop_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laptop Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF5F7FA),
        fontFamily: 'SF Pro',
      ),
      home: LaptopListScreen(),
    );
  }
}

class LaptopListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Premium Laptops',
          style: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey[700]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined,
                color: Colors.grey[700]),
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive: 2 columns on mobile, 3 on tablet, 4 on desktop
          int crossAxisCount = 2;
          if (constraints.maxWidth > 900) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 3;
          }

          // Calculate aspect ratio based on screen width
          double cardWidth = (constraints.maxWidth - 48) / crossAxisCount;
          double cardHeight = cardWidth * 1.45;

          // Check if data is available
          if (laptopData.isEmpty) {
            return Center(
              child: Text('No laptops available'),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: cardWidth / cardHeight,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: laptopData.length,
            itemBuilder: (context, index) {
              return LaptopCard(
                laptop: laptopData[index],
                onTap: () {
                  // Navigate to detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LaptopDetailScreen(
                        laptop: laptopData[index],
                      ),
                    ),
                  );
                }, onFavorite: () {  },
              );
            },
          );
        },
      ),
    );
  }
}
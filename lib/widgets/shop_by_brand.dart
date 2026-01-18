import 'package:flutter/material.dart';
import 'package:laptop_harbor/pages/CategoriesPage.dart';
import 'package:laptop_harbor/pages/view_brand.dart';

class ShopByBrandSection extends StatelessWidget {
  // Aap ye list manually bhi de sakte hain ya Firebase se unique brands nikaal sakte hain
  final List<Map<String, String>> brands = [
    {'name': 'Apple', 'icon': 'assets/brands/apple.png'},
    {'name': 'Dell', 'icon': 'assets/brands/dell.png'},
    {'name': 'HP', 'icon': 'assets/brands/hp.png'},
    {'name': 'Asus', 'icon': 'assets/brands/asus.png'},
    {'name': 'Lenovo', 'icon': 'assets/brands/lenovo.png'},
  ];

   ShopByBrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shop By Brand",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: 
                  (context)=> CategoriesPage()
                  
                  )); /* See All Logic */ },
                child: Text("See All", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 110, // Brand card ki height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BrandProductsScreen(
        brandName: brands[index]['name']!, allLaptops: [],
        // Aapki main data list
      ),
    ),
  );
                  // Yahan aap filter logic laga sakte hain brand name use karke: brands[index]['name']
                },
                child: Container(
                  width: 90,
                  margin: EdgeInsets.only(right: 12, bottom: 10, top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Agar assets nahi hain toh Icon use karein, warna Image.asset
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.laptop, color: Colors.blue, size: 30), 
                      ),
                      SizedBox(height: 8),
                      Text(
                        brands[index]['name']!,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
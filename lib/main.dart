

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/providers/cart_provider.dart';
import 'package:laptop_harbor/providers/compare_provider.dart';
import 'package:laptop_harbor/providers/laptop_provider.dart';
import 'package:laptop_harbor/providers/theme_provider.dart';
import 'package:laptop_harbor/providers/wishlist_provider.dart';
// import 'package:laptop_harbor/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:laptop_harbor/firebase_options.dart';
// import 'package:laptop_harbor/providers/cart_provider.dart';
import 'package:laptop_harbor/services/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LaptopHarborApp());
}

class LaptopHarborApp extends StatelessWidget {
  const LaptopHarborApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
         ChangeNotifierProvider(create: (_) => ThemeProvider()), 
         ChangeNotifierProvider(create: (_)=> LaptopProvider()),
         
        ChangeNotifierProvider(create: (_) => CompareProvider()),
     
               ],
    
      child: MaterialApp(
        title: 'Laptop Harbor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),
          fontFamily: 'SF Pro',
        ),
        home: const AuthWrapper(),
      
      ),

    );
  }
}

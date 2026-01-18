// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // // Apni pages import karo
// // import 'package:laptop_harbor/auth/login_page.dart';
// // import 'package:laptop_harbor/pages/laptop_home_page.dart';

// // class Wrapper extends StatelessWidget {
// //   const Wrapper({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<User?>(
// //       stream: FirebaseAuth.instance.authStateChanges(),
// //       builder: (context, snapshot) {

// //         // ⏳ Loading
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Scaffold(
// //             body: Center(
// //               child: CircularProgressIndicator(),
// //             ),
// //           );
// //         }

// //         // ✅ User logged in
// //         if (snapshot.hasData) {
// //           return const LaptopHomePage();
// //         }

// //         // ❌ User not logged in
// //         return const LoginScreen();
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:laptop_harbor/auth/login_page.dart';
// import 'package:laptop_harbor/pages/laptop_home_page.dart';
// // import 'login_screen.dart';
// // import '../pages/home_page.dart';

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (snapshot.hasData) {
//           return const LaptopHomePage();
//         }

//         return const LoginScreen();
//       },
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor/auth/login_page.dart';
import 'package:laptop_harbor/pages/laptop_home_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  // Stream subscriptions ko track karne ke liye
  StreamSubscription<User?>? _authStreamSubscription;
  StreamSubscription? _wishlistStreamSubscription;
  StreamSubscription? _cartStreamSubscription;

  @override
  void initState() {
    super.initState();
    
    // Auth state changes listen karo
    _authStreamSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User login ho gaya, streams initialize karo
        _initializeUserStreams(user.uid);
      } else {
        // User logout ho gaya, streams dispose karo
        _disposeUserStreams();
      }
    });
  }

  // User-specific streams initialize karo
  void _initializeUserStreams(String userId) {
    try {
      // Wishlist stream
      _wishlistStreamSubscription = FirebaseFirestore.instance
          .collection('wishlist')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
        // Wishlist data handle karo
        print('Wishlist items: ${snapshot.docs.length}');
      }, onError: (error) {
        if (error.toString().contains('permission-denied')) {
          // Logout ke time ye error aa sakta hai, ignore karo
          print('Wishlist stream permission denied (user logged out)');
        } else {
          print('Wishlist stream error: $error');
        }
      });

      // Cart stream (agar chahiye)
      _cartStreamSubscription = FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
        // Cart data handle karo
        print('Cart items: ${snapshot.docs.length}');
      }, onError: (error) {
        if (error.toString().contains('permission-denied')) {
          print('Cart stream permission denied (user logged out)');
        } else {
          print('Cart stream error: $error');
        }
      });
    } catch (e) {
      print('Error initializing streams: $e');
    }
  }

  // User streams dispose karo
  void _disposeUserStreams() {
    try {
      if (_wishlistStreamSubscription != null) {
        _wishlistStreamSubscription!.cancel();
        _wishlistStreamSubscription = null;
      }
      
      if (_cartStreamSubscription != null) {
        _cartStreamSubscription!.cancel();
        _cartStreamSubscription = null;
      }
    } catch (e) {
      print('Error disposing streams: $e');
    }
  }

  @override
  void dispose() {
    // Sabhi streams dispose karo
    _authStreamSubscription?.cancel();
    _disposeUserStreams();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const LaptopHomePage();
        }

        return const LoginScreen();
      },
    );
  }
}
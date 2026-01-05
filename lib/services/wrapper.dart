// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // Apni pages import karo
// import 'package:laptop_harbor/auth/login_page.dart';
// import 'package:laptop_harbor/pages/laptop_home_page.dart';

// class Wrapper extends StatelessWidget {
//   const Wrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {

//         // ⏳ Loading
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }

//         // ✅ User logged in
//         if (snapshot.hasData) {
//           return const LaptopHomePage();
//         }

//         // ❌ User not logged in
//         return const LoginScreen();
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_harbor/auth/login_page.dart';
import 'package:laptop_harbor/pages/laptop_home_page.dart';
// import 'login_screen.dart';
// import '../pages/home_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

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

        if (snapshot.hasData) {
          return const LaptopHomePage();
        }

        return const LoginScreen();
      },
    );
  }
}

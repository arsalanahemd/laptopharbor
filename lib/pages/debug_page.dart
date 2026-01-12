// Temporary debug screen banayein
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DebugCartScreen extends StatelessWidget {
  const DebugCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Cart')),
      body: FutureBuilder(
        future: _debugCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.data.toString(),
                  style: const TextStyle(fontFamily: 'Monospace', fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String> _debugCart() async {
    String result = '=== CART DEBUG ===\n\n';
    
    try {
      // 1. Check current user
      final user = FirebaseAuth.instance.currentUser;
      result += '👤 USER STATUS:\n';
      if (user == null) {
        result += '❌ No user logged in\n';
        return result;
      }
      result += '✅ User ID: ${user.uid}\n';
      result += '✅ Email: ${user.email}\n\n';
      
      // 2. Check cart collection
      result += '🛒 CART COLLECTION:\n';
      final cartRef = FirebaseFirestore.instance.collection('cart');
      final cartSnapshot = await cartRef
          .where('userId', isEqualTo: user.uid)
          .get();
      
      result += 'Total items in cart: ${cartSnapshot.docs.length}\n\n';
      
      // 3. List all cart items
      for (int i = 0; i < cartSnapshot.docs.length; i++) {
        final doc = cartSnapshot.docs[i];
        final data = doc.data();
        result += 'Item ${i + 1}:\n';
        result += '  Document ID: ${doc.id}\n';
        result += '  Laptop ID: ${data['laptopId']}\n';
        result += '  Quantity: ${data['quantity']}\n';
        result += '  Price: ${data['price']}\n';
        result += '  Added At: ${data['addedAt']}\n\n';
      }
      
      // 4. Check laptops collection
      result += '💻 LAPTOPS CHECK:\n';
      for (var doc in cartSnapshot.docs) {
        final laptopId = doc.data()['laptopId'];
        final laptopDoc = await FirebaseFirestore.instance
            .collection('laptops')
            .doc(laptopId)
            .get();
        
        if (laptopDoc.exists) {
          final laptopData = laptopDoc.data();
          result += '✅ Laptop "$laptopId" exists\n';
          result += '   Name: ${laptopData?['name']}\n';
          result += '   Brand: ${laptopData?['brand']}\n';
        } else {
          result += '❌ Laptop "$laptopId" NOT FOUND!\n';
        }
      }
      
      // 5. Check Firestore rules
      result += '\n🔐 FIRESTORE RULES CHECK:\n';
      try {
        // Try to write to cart
        await cartRef.add({
          'test': 'test',
          'userId': user.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });
        result += '✅ Write permission: OK\n';
      } catch (e) {
        result += '❌ Write permission error: $e\n';
      }
      
    } catch (e) {
      result += '\n❌ ERROR: $e\n';
    }
    
    return result;
  }
}

// Isko main.dart mein add karo temporary route ke taur pe
// MaterialApp(
//   routes: {
//     '/debug': (context) => DebugCartScreen(),
//   },
// )
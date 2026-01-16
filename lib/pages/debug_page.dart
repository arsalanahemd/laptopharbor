// // Temporary debug screen banayein
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DebugCartScreen extends StatelessWidget {
//   const DebugCartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Debug Cart')),
//       body: FutureBuilder(
//         future: _debugCart(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
          
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   snapshot.data.toString(),
//                   style: const TextStyle(fontFamily: 'Monospace', fontSize: 12),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<String> _debugCart() async {
//     String result = '=== CART DEBUG ===\n\n';
    
//     try {
//       // 1. Check current user
//       final user = FirebaseAuth.instance.currentUser;
//       result += '👤 USER STATUS:\n';
//       if (user == null) {
//         result += '❌ No user logged in\n';
//         return result;
//       }
//       result += '✅ User ID: ${user.uid}\n';
//       result += '✅ Email: ${user.email}\n\n';
      
//       // 2. Check cart collection
//       result += '🛒 CART COLLECTION:\n';
//       final cartRef = FirebaseFirestore.instance.collection('cart');
//       final cartSnapshot = await cartRef
//           .where('userId', isEqualTo: user.uid)
//           .get();
      
//       result += 'Total items in cart: ${cartSnapshot.docs.length}\n\n';
      
//       // 3. List all cart items
//       for (int i = 0; i < cartSnapshot.docs.length; i++) {
//         final doc = cartSnapshot.docs[i];
//         final data = doc.data();
//         result += 'Item ${i + 1}:\n';
//         result += '  Document ID: ${doc.id}\n';
//         result += '  Laptop ID: ${data['laptopId']}\n';
//         result += '  Quantity: ${data['quantity']}\n';
//         result += '  Price: ${data['price']}\n';
//         result += '  Added At: ${data['addedAt']}\n\n';
//       }
      
//       // 4. Check laptops collection
//       result += '💻 LAPTOPS CHECK:\n';
//       for (var doc in cartSnapshot.docs) {
//         final laptopId = doc.data()['laptopId'];
//         final laptopDoc = await FirebaseFirestore.instance
//             .collection('laptops')
//             .doc(laptopId)
//             .get();
        
//         if (laptopDoc.exists) {
//           final laptopData = laptopDoc.data();
//           result += '✅ Laptop "$laptopId" exists\n';
//           result += '   Name: ${laptopData?['name']}\n';
//           result += '   Brand: ${laptopData?['brand']}\n';
//         } else {
//           result += '❌ Laptop "$laptopId" NOT FOUND!\n';
//         }
//       }
      
//       // 5. Check Firestore rules
//       result += '\n🔐 FIRESTORE RULES CHECK:\n';
//       try {
//         // Try to write to cart
//         await cartRef.add({
//           'test': 'test',
//           'userId': user.uid,
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//         result += '✅ Write permission: OK\n';
//       } catch (e) {
//         result += '❌ Write permission error: $e\n';
//       }
      
//     } catch (e) {
//       result += '\n❌ ERROR: $e\n';
//     }
    
//     return result;
//   }
// }

// // Isko main.dart mein add karo temporary route ke taur pe
// // MaterialApp(
// //   routes: {
// //     '/debug': (context) => DebugCartScreen(),
// //   },
// // )

// lib/pages/debug_page.dart - FIXED VERSION

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DebugFirestorePage extends StatefulWidget {
  @override
  _DebugFirestorePageState createState() => _DebugFirestorePageState();
}

class _DebugFirestorePageState extends State<DebugFirestorePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _status = 'Initializing...';
  String _userId = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    final user = _auth.currentUser;
    
    setState(() {
      _userId = user?.uid ?? 'NO USER';
      _email = user?.email ?? 'NO EMAIL';
      _status = '👤 User: $_userId\n📧 Email: $_email';
    });

    if (user == null) {
      setState(() => _status += '\n❌ No user logged in');
      return;
    }

    setState(() => _status += '\n✅ User logged in');
  }

  void _testRead() async {
    setState(() => _status += '\n\n📖 Testing READ permission...');
    
    try {
      final snapshot = await _firestore.collection('wishlist').limit(1).get();
      setState(() => _status += '\n✅ READ: OK (${snapshot.docs.length} docs)');
    } catch (e) {
      setState(() => _status += '\n❌ READ ERROR: $e');
    }
  }

  void _testWrite() async {
    setState(() => _status += '\n\n✍️ Testing WRITE permission...');
    
    final user = _auth.currentUser;
    if (user == null) {
      setState(() => _status += '\n❌ No user for write test');
      return;
    }

    try {
      // Try to add a test document
      await _firestore.collection('wishlist').add({
        'userId': user.uid,
        'laptopId': 'test_laptop_123',
        'addedAt': FieldValue.serverTimestamp(),
        'test': true,
      });
      
      setState(() => _status += '\n✅ WRITE: Document added successfully');
      
      // Try to delete it
      final query = await _firestore.collection('wishlist')
          .where('userId', isEqualTo: user.uid)
          .where('laptopId', isEqualTo: 'test_laptop_123')
          .get();
          
      for (var doc in query.docs) {
        await doc.reference.delete();
      }
      
      setState(() => _status += '\n✅ DELETE: Document deleted successfully');
      
    } catch (e) {
      setState(() => _status += '\n❌ WRITE ERROR: $e');
    }
  }

  void _checkWishlistCollection() async {
    setState(() => _status += '\n\n📋 Checking wishlist collection...');
    
    try {
      // Method 1: Try to access wishlist collection
      final snapshot = await _firestore.collection('wishlist').limit(1).get();
      
      setState(() => _status += '\n✅ "wishlist" collection exists');
      setState(() => _status += '\n📊 Total documents: ${snapshot.size}');
      
      // Show sample data
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        setState(() => _status += '\n📄 Sample document:');
        setState(() => _status += '\n  ID: ${doc.id}');
        setState(() => _status += '\n  Data: ${doc.data()}');
      }
    } catch (e) {
      setState(() => _status += '\n❌ Collection check error: $e');
    }
  }

  void _checkLaptopsCollection() async {
    setState(() => _status += '\n\n💻 Checking laptops collection...');
    
    try {
      final snapshot = await _firestore.collection('laptops').limit(1).get();
      
      if (snapshot.docs.isNotEmpty) {
        setState(() => _status += '\n✅ "laptops" collection exists');
        setState(() => _status += '\n📊 Total laptops: ${snapshot.size}');
      } else {
        setState(() => _status += '\n⚠️ "laptops" collection exists but empty');
      }
    } catch (e) {
      setState(() => _status += '\n❌ Laptops collection error: $e');
    }
  }

  void _testAuthStatus() async {
    setState(() => _status += '\n\n🔐 Testing Auth Status...');
    
    final user = _auth.currentUser;
    
    if (user == null) {
      setState(() => _status += '\n❌ User is NULL - trying anonymous sign in...');
      
      try {
        final result = await _auth.signInAnonymously();
        setState(() => _status += '\n✅ Anonymous sign in successful');
        setState(() => _status += '\n👤 New User ID: ${result.user?.uid}');
        
        // Update user info
        _checkAuth();
      } catch (e) {
        setState(() => _status += '\n❌ Anonymous sign in failed: $e');
      }
    } else {
      setState(() => _status += '\n✅ User is authenticated');
      setState(() => _status += '\n👤 UID: ${user.uid}');
      setState(() => _status += '\n📧 Email: ${user.email ?? "No email"}');
      setState(() => _status += '\n✅ Email verified: ${user.emailVerified}');
      setState(() => _status += '\n📅 Created: ${user.metadata.creationTime}');
    }
  }

  void _clearAllTestData() async {
    setState(() => _status += '\n\n🧹 Clearing test data...');
    
    final user = _auth.currentUser;
    if (user == null) return;
    
    try {
      // Delete all test wishlist items
      final query = await _firestore.collection('wishlist')
          .where('userId', isEqualTo: user.uid)
          .where('test', isEqualTo: true)
          .get();
          
      setState(() => _status += '\n🗑️ Found ${query.docs.length} test documents');
      
      for (var doc in query.docs) {
        await doc.reference.delete();
      }
      
      setState(() => _status += '\n✅ Test data cleared');
    } catch (e) {
      setState(() => _status += '\n❌ Clear error: $e');
    }
  }

  void _viewAllWishlistItems() async {
    setState(() => _status += '\n\n📋 Viewing all wishlist items...');
    
    final user = _auth.currentUser;
    if (user == null) {
      setState(() => _status += '\n❌ No user logged in');
      return;
    }
    
    try {
      final snapshot = await _firestore.collection('wishlist')
          .where('userId', isEqualTo: user.uid)
          .get();
      
      setState(() => _status += '\n📊 Your wishlist items: ${snapshot.docs.length}');
      
      for (var doc in snapshot.docs) {
        final data = doc.data();
        setState(() => _status += '\n  • ID: ${doc.id}');
        setState(() => _status += '\n    Laptop: ${data['laptopId']}');
        setState(() => _status += '\n    Test: ${data['test'] ?? false}');
        setState(() => _status += '\n    ---');
      }
    } catch (e) {
      setState(() => _status += '\n❌ View error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Debug'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Status Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: SelectableText(
                _status,
                style: TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Buttons Grid
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildButton(
                  'Check Authentication',
                  _checkAuth,
                  Colors.blue,
                  Icons.verified_user,
                ),
                
                _buildButton(
                  'Test Read',
                  _testRead,
                  Colors.green,
                  Icons.read_more,
                ),
                
                _buildButton(
                  'Test Write/Delete',
                  _testWrite,
                  Colors.orange,
                  Icons.edit,
                ),
                
                _buildButton(
                  'Check Wishlist',
                  _checkWishlistCollection,
                  Colors.purple,
                  Icons.favorite,
                ),
                
                _buildButton(
                  'Check Laptops',
                  _checkLaptopsCollection,
                  Colors.blueGrey,
                  Icons.laptop,
                ),
                
                _buildButton(
                  'Auth Status',
                  _testAuthStatus,
                  Colors.red,
                  Icons.security,
                ),
                
                _buildButton(
                  'View Wishlist',
                  _viewAllWishlistItems,
                  Colors.pink,
                  Icons.list,
                ),
                
                _buildButton(
                  'Clear Test Data',
                  _clearAllTestData,
                  Colors.grey,
                  Icons.cleaning_services,
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Instructions
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.yellow),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🛠️ How to Fix Permission Errors:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.orange[900],
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildInstruction('1. Go to Firebase Console > Firestore > Rules'),
                  _buildInstruction('2. Copy these rules and paste:'),
                  
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SelectableText(
                      'rules_version = "2";\nservice cloud.firestore {\n  match /databases/{database}/documents {\n    match /{document=**} {\n      allow read, write: if true;\n    }\n  }\n}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  
                  _buildInstruction('3. Click "Publish" button'),
                  _buildInstruction('4. Wait 1-2 minutes for rules to propagate'),
                  _buildInstruction('5. Test with buttons above'),
                  
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  
                  Text(
                    '💡 Tips:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  _buildInstruction('• First click "Check Authentication"'),
                  _buildInstruction('• Then test Read, Write, Delete'),
                  _buildInstruction('• If still errors, check Firebase Console'),
                  _buildInstruction('• Make sure wishlist collection exists'),
                ],
              ),
            ),
            
            SizedBox(height: 10),
            
            // Quick Actions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🚀 Quick Actions:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Copy rules to clipboard
                              // Note: You need clipboard package for this
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Copy the rules from above')),
                              );
                            },
                            icon: Icon(Icons.copy, size: 16),
                            label: Text('Copy Rules'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, size: 16),
                            label: Text('Back'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[600],
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, Color color, IconData icon) {
    return SizedBox(
      width: 170,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(text, style: TextStyle(fontSize: 12)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text('• $text'),
    );
  }
}
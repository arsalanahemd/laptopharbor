// // lib/Admin/test_upload.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:laptop_harbor/models/laptop_model.dart';
// import 'package:laptop_harbor/services/firestore_service.dart';

// class TestUploadScreen extends StatefulWidget {
//   const TestUploadScreen({super.key});

//   @override
//   State<TestUploadScreen> createState() => _TestUploadScreenState();
// }

// class _TestUploadScreenState extends State<TestUploadScreen> {
//   final FirestoreService _firestoreService = FirestoreService();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   bool _isTesting = false;
//   String _testResult = '';

//   Future<void> _testUpload() async {
//     setState(() {
//       _isTesting = true;
//       _testResult = 'Testing...';
//     });

//     try {
//       // Create a test product
//       final testProduct = LaptopModel(
//         id: 'test_${DateTime.now().millisecondsSinceEpoch}',
//         name: 'Test Laptop ${DateTime.now().millisecondsSinceEpoch}',
//         brand: 'Test Brand',
//         imageUrl: 'https://via.placeholder.com/400',
//         price: 99999,
//         originalPrice: 119999,
//         processor: 'Test Processor',
//         ram: 8,
//         storage: 256,
//         display: 'Test Display',
//         rating: 4.0,
//         reviews: 0,
//         inStock: true,
//         features: ['Test Feature 1', 'Test Feature 2'],
//         category: 'Test',
//         isHotDeal: false,
//         isMostSale: false,
//         isNewArrival: true,
//         discount: 16.67,
//       );

//       // Upload test product
//       final productId = await _firestoreService.addProduct(testProduct);
      
//       setState(() {
//         _testResult = '✅ Test PASSED!\n'
//                      'Product uploaded successfully!\n'
//                      'Product ID: $productId\n'
//                      'Check Firebase Console to verify.';
//       });

//       // Wait 5 seconds and delete test product
//       await Future.delayed(const Duration(seconds: 5));
//       await _firestoreService.deleteProduct(productId);
      
//       setState(() {
//         _testResult += '\n\n🧹 Test product cleaned up!';
//       });

//     } catch (e) {
//       setState(() {
//         _testResult = '❌ Test FAILED!\nError: $e';
//       });
//     } finally {
//       setState(() => _isTesting = false);
//     }
//   }

//   Future<void> _checkDatabase() async {
//     setState(() {
//       _isTesting = true;
//       _testResult = 'Checking database...';
//     });

//     try {
//       final snapshot = await _firestore.collection('laptops').get();
      
//       final count = snapshot.docs.length;
      
//       setState(() {
//         _testResult = '📊 Database Check:\n'
//                      'Total Products: $count\n'
//                      'Documents Found: ${count > 0 ? "✅" : "❌"}';
        
//         if (count > 0) {
//           _testResult += '\n\n📋 Products List:';
//           for (var i = 0; i < snapshot.docs.length && i < 5; i++) {
//             final doc = snapshot.docs[i];
//             final data = doc.data();
//             _testResult += '\n${i + 1}. ${data['name']} - ₹${data['price']}';
//           }
//           if (snapshot.docs.length > 5) {
//             _testResult += '\n... and ${snapshot.docs.length - 5} more';
//           }
//         }
//       });
//     } catch (e) {
//       setState(() {
//         _testResult = '❌ Database Check FAILED!\nError: $e';
//       });
//     } finally {
//       setState(() => _isTesting = false);
//     }
//   }

//   Future<void> _testConnection() async {
//     setState(() {
//       _isTesting = true;
//       _testResult = 'Testing Firebase connection...';
//     });

//     try {
//       // Simple test query
//       await _firestore.collection('test_connection').limit(1).get();
      
//       setState(() {
//         _testResult = '✅ Firebase Connection: SUCCESS!\n'
//                      'Firestore is properly connected.';
//       });
//     } catch (e) {
//       setState(() {
//         _testResult = '❌ Firebase Connection: FAILED!\n'
//                      'Error: $e\n\n'
//                      'Possible issues:\n'
//                      '1. Firebase not initialized\n'
//                      '2. Internet connection\n'
//                      '3. Firebase rules\n'
//                      '4. Missing google-services.json';
//       });
//     } finally {
//       setState(() => _isTesting = false);
//     }
//   }

//   Future<void> _clearDatabase() async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Clear Database'),
//         content: const Text('Are you sure you want to clear ALL products?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Clear All', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );

//     if (confirmed == true) {
//       setState(() {
//         _isTesting = true;
//         _testResult = 'Clearing database...';
//       });

//       try {
//         final snapshot = await _firestore.collection('laptops').get();
//         final batch = _firestore.batch();
        
//         for (var doc in snapshot.docs) {
//           batch.delete(doc.reference);
//         }
        
//         await batch.commit();
        
//         setState(() {
//           _testResult = '✅ Database cleared!\n'
//                        'Removed ${snapshot.docs.length} products.';
//         });
//       } catch (e) {
//         setState(() {
//           _testResult = '❌ Error clearing database: $e';
//         });
//       } finally {
//         setState(() => _isTesting = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Database Testing Tool'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.home),
//             tooltip: 'Home',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Status Card
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     const Icon(Icons.bug_report, size: 60, color: Colors.blue),
//                     const SizedBox(height: 10),
//                     const Text(
//                       'Database Testing Tool',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         _testResult,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: _testResult.contains('✅') 
//                               ? Colors.green 
//                               : _testResult.contains('❌') 
//                                   ? Colors.red 
//                                   : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Test Buttons Grid
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 1.5,
//                 children: [
//                   _buildTestButton(
//                     icon: Icons.upload,
//                     title: 'Test Upload',
//                     color: Colors.blue,
//                     onTap: _testUpload,
//                     disabled: _isTesting,
//                   ),
//                   _buildTestButton(
//                     icon: Icons.favorite ,
//                     title: 'Check Database',
//                     color: Colors.green,
//                     onTap: _checkDatabase,
//                     disabled: _isTesting,
//                   ),
//                   _buildTestButton(
//                     icon: Icons.wifi,
//                     title: 'Test Connection',
//                     color: Colors.orange,
//                     onTap: _testConnection,
//                     disabled: _isTesting,
//                   ),
//                   _buildTestButton(
//                     icon: Icons.delete_forever,
//                     title: 'Clear Database',
//                     color: Colors.red,
//                     onTap: _clearDatabase,
//                     disabled: _isTesting,
//                   ),
//                   _buildTestButton(
//                     icon: Icons.list,
//                     title: 'View Products',
//                     color: Colors.purple,
//                     onTap: () {
//                       Navigator.pushNamed(context, '/products');
//                     },
//                     disabled: _isTesting,
//                   ),
//                   _buildTestButton(
//                     icon: Icons.admin_panel_settings,
//                     title: 'Admin Panel',
//                     color: Colors.teal,
//                     onTap: () {
//                       Navigator.pushNamed(context, '/admin');
//                     },
//                     disabled: _isTesting,
//                   ),
//                 ],
//               ),
//             ),

//             // Loading Indicator
//             if (_isTesting)
//               const Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     CircularProgressIndicator(),
//                     SizedBox(height: 10),
//                     Text('Please wait...'),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTestButton({
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//     bool disabled = false,
//   }) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: disabled ? null : onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 color.withOpacity(0.1),
//                 color.withOpacity(0.3),
//               ],
//             ),
//           ),
//           child: Opacity(
//             opacity: disabled ? 0.5 : 1.0,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, size: 40, color: color),
//                 const SizedBox(height: 8),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: color,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// // import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../models/order_model.dart';

// // class OrderService {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
  
// //   // Create new order
// //   Future<String> createOrder(Order order) async {
// //     try {
// //       await _firestore
// //           .collection('orders')
// //           .doc(order.id)
// //           .set(order.toMap());
      
// //       // Update user's orders list
// //       await _firestore
// //           .collection('users')
// //           .doc(order.userId)
// //           .collection('user_orders')
// //           .doc(order.id)
// //           .set({'orderId': order.id});
      
// //       return order.id;
// //     } catch (e) {
// //       throw Exception('Order failed: $e');
// //     }
// //   }
  
// //   // Get user orders
// //   Stream<List<Order>> getUserOrders() {
// //     final userId = _auth.currentUser!.uid;
    
// //     return _firestore
// //         .collection('orders')
// //         .where('userId', isEqualTo: userId)
// //         .orderBy('orderDate', descending: true)
// //         .snapshots()
// //         .map((snapshot) {
// //       return snapshot.docs.map((doc) {
// //         return Order.fromMap(doc.data());
// //       }).toList();
// //     });
// //   }
  
// //   // Get single order
// //   Future<Order> getOrder(String orderId) async {
// //     final doc = await _firestore.collection('orders').doc(orderId).get();
// //     return Order.fromMap(doc.data()!);
// //   }
  
// //   // Update order status (Admin only)
// //   Future<void> updateOrderStatus(String orderId, String status, {String? trackingNumber}) async {
// //     await _firestore.collection('orders').doc(orderId).update({
// //       'status': status,
// //       if (trackingNumber != null) 'trackingNumber': trackingNumber,
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //   }
  
// //   // Direct order from product (Buy Now)
// //   Future<String> createDirectOrder({
// //     required String productId,
// //     required String productName,
// //     required double price,
// //     required int quantity,
// //     required ShippingInfo shippingInfo,
// //   }) async {
// //     final orderId = DateTime.now().millisecondsSinceEpoch.toString();
// //     final userId = _auth.currentUser!.uid;
    
// //     final order = Order(
// //       id: orderId,
// //       userId: userId,
// //       items: [
// //         OrderItem(
// //           productId: productId,
// //           productName: productName,
// //           price: price,
// //           quantity: quantity,
// //         ),
// //       ],
// //       totalAmount: price * quantity,
// //       shippingInfo: shippingInfo,
// //       orderDate: DateTime.now(),
// //       paymentInfo: PaymentInfo(method: 'cod'),
// //     );
    
// //     return await createOrder(order);
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../models/order_model.dart';

// class OrderService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
  
//   // Create new order
//   Future<String> createOrder(Order order) async {
//     try {
//       debugPrint('Creating order: ${order.id}');
      
//       // Add server timestamp
//       final orderData = order.toMap();
//       orderData['createdAt'] = FieldValue.serverTimestamp();
//       orderData['updatedAt'] = FieldValue.serverTimestamp();
      
//       await _firestore
//           .collection('orders')
//           .doc(order.id)
//           .set(orderData);
      
//       // Also store in user's subcollection
//       await _firestore
//           .collection('users')
//           .doc(order.userId)
//           .collection('user_orders')
//           .doc(order.id)
//           .set({
//             'orderId': order.id,
//             'createdAt': FieldValue.serverTimestamp(),
//           });
      
//       debugPrint('Order created successfully: ${order.id}');
//       return order.id;
//     } catch (e) {
//       debugPrint('Error creating order: $e');
//       throw Exception('Order failed: $e');
//     }
//   }
  
//   // Get ALL orders for admin panel - FIXED
//   Stream<List<Order>> getAllOrders() {
//     debugPrint('Getting all orders...');
    
//     return _firestore
//         .collection('orders')
//         .snapshots()
//         .handleError((error) {
//           debugPrint('Error in getAllOrders stream: $error');
//           // Return empty stream using Stream.error or Stream.value
//           return Stream.value(QuerySnapshot);
//         })
//         .asyncMap((snapshot) async {
//           try {
//             debugPrint('Received ${snapshot.docs.length} orders');
            
//             if (snapshot.docs.isEmpty) {
//               return <Order>[];
//             }
            
//             List<Order> orders = [];
            
//             for (var doc in snapshot.docs) {
//               try {
//                 final data = doc.data();
                
//                 // Add debug logging
//                 debugPrint('Processing order ${doc.id}');
//                 debugPrint('Order data keys: ${data.keys.toList()}');
                
//                 // Parse order date properly
//                 DateTime orderDate;
                
//                 if (data['orderDate'] is String) {
//                   orderDate = DateTime.parse(data['orderDate']);
//                 } else if (data['orderDate'] is Timestamp) {
//                   orderDate = (data['orderDate'] as Timestamp).toDate();
//                 } else if (data['createdAt'] is Timestamp) {
//                   orderDate = (data['createdAt'] as Timestamp).toDate();
//                 } else {
//                   orderDate = DateTime.now();
//                   debugPrint('Warning: Using current date for order ${doc.id}');
//                 }
                
//                 // Create a new map with parsed date
//                 final processedData = Map<String, dynamic>.from(data);
//                 processedData['orderDate'] = orderDate;
                
//                 final order = Order.fromMap(processedData);
//                 orders.add(order);
                
//               } catch (e) {
//                 debugPrint('Error parsing order ${doc.id}: $e');
//                 debugPrint('Problematic data: ${doc.data()}');
//                 continue; // Skip this order but continue processing
//               }
//             }
            
//             // Sort by date (newest first) - Client side
//             orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
            
//             debugPrint('Successfully parsed ${orders.length} orders');
//             return orders;
            
//           } catch (e) {
//             debugPrint('Error in getAllOrders processing: $e');
//             return <Order>[]; // Return empty list on error
//           }
//         });
//   }
  
//   // Get orders by status for admin panel
//   Stream<List<Order>> getOrdersByStatus(String status) {
//     debugPrint('Getting orders with status: $status');
    
//     return _firestore
//         .collection('orders')
//         .where('status', isEqualTo: status)
//         .snapshots()
//         .handleError((error) {
//           debugPrint('Error in getOrdersByStatus stream: $error');
//           return Stream.value(QuerySnapshot);
//         })
//         .asyncMap((snapshot) async {
//           try {
//             debugPrint('Received ${snapshot.docs.length} orders with status $status');
            
//             if (snapshot.docs.isEmpty) {
//               return <Order>[];
//             }
            
//             List<Order> orders = [];
            
//             for (var doc in snapshot.docs) {
//               try {
//                 final data = doc.data();
                
//                 // Parse order date
//                 DateTime orderDate;
                
//                 if (data['orderDate'] is String) {
//                   orderDate = DateTime.parse(data['orderDate']);
//                 } else if (data['orderDate'] is Timestamp) {
//                   orderDate = (data['orderDate'] as Timestamp).toDate();
//                 } else if (data['createdAt'] is Timestamp) {
//                   orderDate = (data['createdAt'] as Timestamp).toDate();
//                 } else {
//                   orderDate = DateTime.now();
//                 }
                
//                 // Create a new map with parsed date
//                 final processedData = Map<String, dynamic>.from(data);
//                 processedData['orderDate'] = orderDate;
                
//                 final order = Order.fromMap(processedData);
//                 orders.add(order);
                
//               } catch (e) {
//                 debugPrint('Error parsing order ${doc.id}: $e');
//                 continue;
//               }
//             }
            
//             // Sort by date (newest first) - Client side
//             orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
            
//             return orders;
            
//           } catch (e) {
//             debugPrint('Error in getOrdersByStatus processing: $e');
//             return <Order>[];
//           }
//         });
//   }
  
//   // Get user orders - FIXED (No compound query)
//   Stream<List<Order>> getUserOrders() {
//     try {
//       final userId = _auth.currentUser!.uid;
//       debugPrint('Getting orders for user: $userId');
      
//       return _firestore
//           .collection('orders')
//           .where('userId', isEqualTo: userId)
//           .snapshots()
//           .handleError((error) {
//             debugPrint('Error in getUserOrders stream: $error');
//             return Stream.value(QuerySnapshot);
//           })
//           .asyncMap((snapshot) async {
//             try {
//               debugPrint('Received ${snapshot.docs.length} orders for user $userId');
              
//               if (snapshot.docs.isEmpty) {
//                 return <Order>[];
//               }
              
//               List<Order> orders = [];
              
//               for (var doc in snapshot.docs) {
//                 try {
//                   final data = doc.data();
                  
//                   // Parse order date
//                   DateTime orderDate;
                  
//                   if (data['orderDate'] is String) {
//                     orderDate = DateTime.parse(data['orderDate']);
//                   } else if (data['orderDate'] is Timestamp) {
//                     orderDate = (data['orderDate'] as Timestamp).toDate();
//                   } else if (data['createdAt'] is Timestamp) {
//                     orderDate = (data['createdAt'] as Timestamp).toDate();
//                   } else {
//                     orderDate = DateTime.now();
//                   }
                  
//                   // Create a new map with parsed date
//                   final processedData = Map<String, dynamic>.from(data);
//                   processedData['orderDate'] = orderDate;
                  
//                   final order = Order.fromMap(processedData);
//                   orders.add(order);
                  
//                 } catch (e) {
//                   debugPrint('Error parsing user order ${doc.id}: $e');
//                   continue;
//                 }
//               }
              
//               // Client side sorting
//               orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
              
//               return orders;
              
//             } catch (e) {
//               debugPrint('Error in getUserOrders processing: $e');
//               return <Order>[];
//             }
//           });
//     } catch (e) {
//       debugPrint('Error in getUserOrders: $e');
//       return Stream.value(<Order>[]);
//     }
//   }
  
//   // Get single order with better error handling
//   Future<Order> getOrder(String orderId) async {
//     try {
//       debugPrint('Getting order: $orderId');
      
//       final doc = await _firestore.collection('orders').doc(orderId).get();
      
//       if (!doc.exists) {
//         throw Exception('Order not found: $orderId');
//       }
      
//       final data = doc.data()!;
//       debugPrint('Order data found: ${data.keys.toList()}');
      
//       // Parse order date
//       DateTime orderDate;
      
//       if (data['orderDate'] is String) {
//         orderDate = DateTime.parse(data['orderDate']);
//       } else if (data['orderDate'] is Timestamp) {
//         orderDate = (data['orderDate'] as Timestamp).toDate();
//       } else if (data['createdAt'] is Timestamp) {
//         orderDate = (data['createdAt'] as Timestamp).toDate();
//       } else {
//         orderDate = DateTime.now();
//       }
      
//       // Create a new map with parsed date
//       final processedData = Map<String, dynamic>.from(data);
//       processedData['orderDate'] = orderDate;
      
//       return Order.fromMap(processedData);
      
//     } catch (e) {
//       debugPrint('Error getting order $orderId: $e');
//       rethrow;
//     }
//   }
  
//   // Update order status (Admin only) - IMPROVED
//   Future<void> updateOrderStatus(String orderId, String status, {String? trackingNumber}) async {
//     try {
//       debugPrint('Updating order $orderId to status: $status');
      
//       final updateData = <String, dynamic>{
//         'status': status,
//         'updatedAt': FieldValue.serverTimestamp(),
//       };
      
//       if (trackingNumber != null && trackingNumber.trim().isNotEmpty) {
//         updateData['trackingNumber'] = trackingNumber.trim();
//       }
      
//       await _firestore.collection('orders').doc(orderId).update(updateData);
      
//       debugPrint('Order $orderId updated successfully');
      
//       // Add to status history
//       try {
//         await _firestore
//             .collection('orders')
//             .doc(orderId)
//             .collection('status_history')
//             .add({
//               'status': status,
//               'timestamp': FieldValue.serverTimestamp(),
//               'updatedBy': _auth.currentUser?.uid,
//               'trackingNumber': trackingNumber,
//             });
//       } catch (e) {
//         debugPrint('Error adding to status history: $e');
//         // Don't throw, main update was successful
//       }
      
//     } catch (e) {
//       debugPrint('Error updating order status: $e');
//       throw Exception('Failed to update order status: $e');
//     }
//   }
  
//   // Direct order from product (Buy Now) - UPDATED
//   Future<String> createDirectOrder({
//     required String productId,
//     required String productName,
//     required double price,
//     required int quantity,
//     required ShippingInfo shippingInfo,
//     String? imageUrl,
//   }) async {
//     try {
//       final orderId = DateTime.now().millisecondsSinceEpoch.toString();
//       final userId = _auth.currentUser!.uid;
      
//       debugPrint('Creating direct order: $orderId for user: $userId');
      
//       final order = Order(
//         id: orderId,
//         userId: userId,
//         items: [
//           OrderItem(
//             productId: productId,
//             productName: productName,
//             price: price,
//             quantity: quantity,
//             imageUrl: imageUrl,
//           ),
//         ],
//         totalAmount: price * quantity,
//         shippingInfo: shippingInfo,
//         orderDate: DateTime.now(),
//         status: 'pending',
//         paymentInfo: PaymentInfo(method: 'cod'),
//       );
      
//       return await createOrder(order);
      
//     } catch (e) {
//       debugPrint('Error creating direct order: $e');
//       throw Exception('Direct order failed: $e');
//     }
//   }
  
//   // Get order statistics for dashboard
//   Future<Map<String, dynamic>> getOrderStats() async {
//     try {
//       debugPrint('Getting order statistics...');
      
//       final snapshot = await _firestore.collection('orders').get();
//       final orders = snapshot.docs;
      
//       Map<String, int> statusCount = {
//         'pending': 0,
//         'confirmed': 0,
//         'processing': 0,
//         'shipped': 0,
//         'delivered': 0,
//         'cancelled': 0,
//         'total': orders.length,
//       };
      
//       double totalRevenue = 0;
      
//       for (var doc in orders) {
//         try {
//           final data = doc.data();
//           final status = data['status']?.toString() ?? 'pending';
          
//           // Update status count
//           if (statusCount.containsKey(status)) {
//             statusCount[status] = statusCount[status]! + 1;
//           }
          
//           // Calculate revenue for delivered orders
//           if (status == 'delivered') {
//             final total = data['totalAmount'] is num 
//                 ? (data['totalAmount'] as num).toDouble() 
//                 : 0.0;
//             totalRevenue += total;
//           }
          
//         } catch (e) {
//           debugPrint('Error processing order for stats: $e');
//         }
//       }
      
//       return {
//         'statusCount': statusCount,
//         'totalRevenue': totalRevenue,
//         'averageOrderValue': orders.isNotEmpty && statusCount['delivered']! > 0 
//             ? totalRevenue / statusCount['delivered']! 
//             : 0,
//       };

      // ignore_for_file: avoid_print
      
//     } catch (e) {
//       debugPrint('Error getting order stats: $e');
//       return {
//         'statusCount': {},
//         'totalRevenue': 0,
//         'averageOrderValue': 0,
//       };
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Create new order
  Future<String> createOrder(Order order) async {
    try {
      // Add timestamps
      final orderData = order.toMap();
      
      await _firestore
          .collection('orders')
          .doc(order.id)
          .set(orderData);
      
      print('✅ Order created: ${order.id}');
      return order.id;
    } catch (e) {
      print('❌ Error creating order: $e');
      throw Exception('Order failed: $e');
    }
  }
  
  // Parse date from Firestore
  DateTime _parseFirestoreDate(dynamic dateValue) {
    if (dateValue == null) return DateTime.now();
    
    if (dateValue is String) {
      try {
        return DateTime.parse(dateValue);
      } catch (e) {
        return DateTime.now();
      }
    } else if (dateValue is Timestamp) {
      return dateValue.toDate();
    } else if (dateValue is DateTime) {
      return dateValue;
    }
    
    return DateTime.now();
  }
  
  // Get ALL orders for admin panel
  Stream<List<Order>> getAllOrders() {
    print('📦 Getting all orders...');
    
    return _firestore
        .collection('orders')
        .snapshots()
        .map((snapshot) {
          print('📦 Received ${snapshot.docs.length} orders');
          
          List<Order> orders = [];
          
          for (var doc in snapshot.docs) {
            try {
              final data = doc.data();
              print('📦 Processing order: ${doc.id}');
              print('📦 Data keys: ${data.keys.toList()}');
              
              final order = Order.fromMap(data);
              orders.add(order);
              print('✅ Successfully parsed order: ${order.id}');
            } catch (e) {
              print('❌ Error parsing order ${doc.id}: $e');
              print('❌ Data: ${doc.data()}');
            }
          }
          
          // Sort by date (newest first)
          orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
          
          print('📦 Returning ${orders.length} valid orders');
          return orders;
        });
  }
  
  // Get orders by status
  Stream<List<Order>> getOrdersByStatus(String status) {
    print('📦 Getting orders with status: $status');
    
    return _firestore
        .collection('orders')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) {
          print('📦 Received ${snapshot.docs.length} orders with status: $status');
          
          List<Order> orders = [];
          
          for (var doc in snapshot.docs) {
            try {
              final data = doc.data();
              final order = Order.fromMap(data);
              orders.add(order);
            } catch (e) {
              print('❌ Error parsing order ${doc.id}: $e');
            }
          }
          
          // Sort by date (newest first)
          orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
          
          return orders;
        });
  }
  
  // Get user orders
  Stream<List<Order>> getUserOrders() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      print('❌ No user ID found');
      return Stream.value([]);
    }
    
    print('📦 Getting orders for user: $userId');
    
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          print('📦 Received ${snapshot.docs.length} orders for user $userId');
          
          List<Order> orders = [];
          
          for (var doc in snapshot.docs) {
            try {
              final data = doc.data();
              print('📦 User order data: ${data.keys.toList()}');
              print('📦 OrderDate type: ${data['orderDate']?.runtimeType}');
              print('📦 OrderDate value: ${data['orderDate']}');
              
              final order = Order.fromMap(data);
              orders.add(order);
              print('✅ Successfully parsed user order: ${order.id}');
            } catch (e) {
              print('❌ Error parsing user order ${doc.id}: $e');
              print('❌ Full error: ${e.toString()}');
              print('❌ Stack trace: ${e.toString()}');
            }
          }
          
          // Sort by date (newest first)
          orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
          
          print('📦 User has ${orders.length} valid orders');
          return orders;
        });
  }
  
  // Get single order
  Future<Order> getOrder(String orderId) async {
    try {
      print('📦 Getting single order: $orderId');
      
      final doc = await _firestore.collection('orders').doc(orderId).get();
      
      if (!doc.exists) {
        throw Exception('Order not found: $orderId');
      }
      
      final data = doc.data()!;
      print('📦 Order data keys: ${data.keys.toList()}');
      
      return Order.fromMap(data);
    } catch (e) {
      print('❌ Error getting order $orderId: $e');
      rethrow;
    }
  }
  
  // Update order status
  Future<void> updateOrderStatus(String orderId, String status, {String? trackingNumber}) async {
    try {
      print('📦 Updating order $orderId to status: $status');
      
      final updateData = <String, dynamic>{
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      if (trackingNumber != null && trackingNumber.trim().isNotEmpty) {
        updateData['trackingNumber'] = trackingNumber.trim();
      }
      
      await _firestore.collection('orders').doc(orderId).update(updateData);
      
      print('✅ Order $orderId updated successfully');
    } catch (e) {
      print('❌ Error updating order status: $e');
      throw Exception('Failed to update order status: $e');
    }
  }
  
  // Direct order from product
  Future<String> createDirectOrder({
    required String productId,
    required String productName,
    required double price,
    required int quantity,
    required ShippingInfo shippingInfo,
    String? imageUrl,
  }) async {
    try {
      final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
      final userId = _auth.currentUser!.uid;
      
      print('📦 Creating direct order: $orderId');
      
      final order = Order(
        id: orderId,
        userId: userId,
        items: [
          OrderItem(
            productId: productId,
            productName: productName,
            price: price,
            quantity: quantity,
            imageUrl: imageUrl,
          ),
        ],
        totalAmount: price * quantity,
        shippingInfo: shippingInfo,
        status: 'pending',
        orderDate: DateTime.now(),
        paymentInfo: PaymentInfo(method: 'cod'),
      );
      
      return await createOrder(order);
    } catch (e) {
      print('❌ Error creating direct order: $e');
      throw Exception('Direct order failed: $e');
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Create new order
  Future<String> createOrder(Order order) async {
    try {
      await _firestore
          .collection('orders')
          .doc(order.id)
          .set(order.toMap());
      
      // Update user's orders list
      await _firestore
          .collection('users')
          .doc(order.userId)
          .collection('user_orders')
          .doc(order.id)
          .set({'orderId': order.id});
      
      return order.id;
    } catch (e) {
      throw Exception('Order failed: $e');
    }
  }
  
  // Get user orders
  Stream<List<Order>> getUserOrders() {
    final userId = _auth.currentUser!.uid;
    
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Order.fromMap(doc.data());
      }).toList();
    });
  }
  
  // Get single order
  Future<Order> getOrder(String orderId) async {
    final doc = await _firestore.collection('orders').doc(orderId).get();
    return Order.fromMap(doc.data()!);
  }
  
  // Update order status (Admin only)
  Future<void> updateOrderStatus(String orderId, String status, {String? trackingNumber}) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status,
      if (trackingNumber != null) 'trackingNumber': trackingNumber,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
  
  // Direct order from product (Buy Now)
  Future<String> createDirectOrder({
    required String productId,
    required String productName,
    required double price,
    required int quantity,
    required ShippingInfo shippingInfo,
  }) async {
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();
    final userId = _auth.currentUser!.uid;
    
    final order = Order(
      id: orderId,
      userId: userId,
      items: [
        OrderItem(
          productId: productId,
          productName: productName,
          price: price,
          quantity: quantity,
        ),
      ],
      totalAmount: price * quantity,
      shippingInfo: shippingInfo,
      orderDate: DateTime.now(),
      paymentInfo: PaymentInfo(method: 'cod'),
    );
    
    return await createOrder(order);
  }
}
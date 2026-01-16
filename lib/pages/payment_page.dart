import 'package:flutter/material.dart';
import 'package:laptop_harbor/pages/order_list_page.dart';
import 'package:provider/provider.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final ShippingInfo shippingInfo;
  final List<dynamic> orderItems;
  final bool isDirectOrder;
  
  const PaymentScreen({
    super.key,
    required this.totalAmount,
    required this.shippingInfo,
    required this.orderItems,
    required this.isDirectOrder,
  });
  
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'cod';
  bool _isProcessing = false;
  final OrderService _orderService = OrderService();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text('Cash on Delivery'),
                  value: 'cod',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Credit/Debit Card'),
                  value: 'card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('UPI'),
                  value: 'upi',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
        
        _isProcessing
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
                child: Text('Place Order'),
              ),
      ],
    );
  }
  
  Future<void> _placeOrder() async {
    setState(() {
      _isProcessing = true;
    });
    
    try {
      final orderId = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Convert cart items to order items
      final orderItems = widget.orderItems.map((item) {
        return OrderItem(
          productId: item.productId,
          productName: item.name,
          price: item.price,
          quantity: item.quantity,
          imageUrl: item.imageUrl,
        );
      }).toList();
      
      final order = Order(
        id: orderId,
        userId: 'current_user_id', // Get from FirebaseAuth
        items: orderItems,
        totalAmount: widget.totalAmount,
        shippingInfo: widget.shippingInfo,
        orderDate: DateTime.now(),
        paymentInfo: PaymentInfo(
          method: _selectedPaymentMethod,
          isPaid: _selectedPaymentMethod != 'cod',
        ),
      );
      
      await _orderService.createOrder(order);
      
      // Clear cart if not direct order
      if (!widget.isDirectOrder) {
        // Clear cart logic here
      }
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(orderId: orderId),
        ),
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order failed: $e')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }
}

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  
  const OrderConfirmationScreen({super.key, required this.orderId});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Confirmed')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 100),
              SizedBox(height: 20),
              Text('Order Placed Successfully!', 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Order ID: $orderId', style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => OrderListScreen()),
                    (route) => false,
                  );
                },
                child: Text('View My Orders'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
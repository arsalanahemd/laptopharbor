import 'package:flutter/material.dart';
import 'package:laptop_harbor/widgets/order_status.dart';
import '../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    OrderStatusWidget(status: order.status),
                    SizedBox(height: 16),
                    if (order.trackingNumber != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tracking Number:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(order.trackingNumber!),
                          SizedBox(height: 8),
                        ],
                      ),
                    Text('Order ID: ${order.id}'),
                    Text('Order Date: ${order.orderDate.toString()}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shipping Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(order.shippingInfo.fullName),
                    Text(order.shippingInfo.address),
                    Text('${order.shippingInfo.city}, ${order.shippingInfo.state} ${order.shippingInfo.zipCode}'),
                    Text(order.shippingInfo.phone),
                    Text(order.shippingInfo.email),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    ...order.items.map((item) {
                      return ListTile(
                        leading: item.imageUrl != null 
                            ? Image.network(item.imageUrl!, width: 40, height: 40)
                            : Icon(Icons.shopping_bag),
                        title: Text(item.productName),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        trailing: Text('\₹${(item.price * item.quantity).toStringAsFixed(2)}'),
                      );
                    }).toList(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('\₹${order.totalAmount.toStringAsFixed(2)}', 
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Method: ${order.paymentInfo.method.toUpperCase()}'),
                    Text('Status: ${order.paymentInfo.isPaid ? 'Paid' : 'Pending'}'),
                    if (order.paymentInfo.transactionId != null)
                      Text('Transaction ID: ${order.paymentInfo.transactionId}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
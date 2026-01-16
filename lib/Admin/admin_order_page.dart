// ignore_for_file: unused_local_variable, unused_element, duplicate_import, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';
import '../services/order_service.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  _AdminOrdersPageState createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  final OrderService _orderService = OrderService();
  String _selectedStatus = 'all';
  bool _isLoading = true;

  List<String> statusList = [
    'all',
    'pending',
    'confirmed',
    'processing',
    'shipped',
    'delivered',
    'cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Orders'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Status Filter
          Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.filter_list),
              ),
              items: statusList.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(
                    status == 'all' ? 'All Orders' : status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
          ),
          
          Expanded(
            child: StreamBuilder<List<Order>>(
              stream: _selectedStatus == 'all'
                  ? _orderService.getAllOrders()
                  : _orderService.getOrdersByStatus(_selectedStatus),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                  print('Stream Error: ${snapshot.error}');
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No orders found'),
                  );
                }
                
                final orders = snapshot.data!;
                
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return null;
                    
                    // return AdminOrderCard(
                    //   order: order,
                    //   onStatusUpdate: _updateOrderStatus,
                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _updateOrderStatus(String orderId, String newStatus, String? trackingNumber) async {
    try {
      await _orderService.updateOrderStatus(
        orderId, 
        newStatus, 
        trackingNumber: trackingNumber,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order status updated successfully!'),
          backgroundColor: Colors.green,
        )
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        )
      );
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'processing':
        return Colors.purple;
      case 'shipped':
        return Colors.indigo;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// AdminOrderCard same rahega...
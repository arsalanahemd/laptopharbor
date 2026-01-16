// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
// import '../models/order_model.dart';
// import '../services/order_service.dart';

// class AdminOrderScreen extends StatelessWidget {
//   final OrderService _orderService = OrderService();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Orders'),
//         actions: [
//           PopupMenuButton(
//             itemBuilder: (context) => [
//               PopupMenuItem(child: Text('All Orders')),
//               PopupMenuItem(child: Text('Pending')),
//               PopupMenuItem(child: Text('Processing')),
//               PopupMenuItem(child: Text('Shipped')),
//               PopupMenuItem(child: Text('Delivered')),
//             ],
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('orders')
//             .orderBy('orderDate', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final doc = snapshot.data!.docs[index];
//               final order = Order.fromMap(doc.data() as Map<String, dynamic>);
              
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text('Order #${order.id.substring(0, 8)}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Customer: ${order.shippingInfo.fullName}'),
//                       Text('Total: \₹${order.totalAmount.toStringAsFixed(2)}'),
//                       Chip(
//                         label: Text(order.status),
//                         backgroundColor: _getStatusColor(order.status),
//                       ),
//                     ],
//                   ),
//                   trailing: PopupMenuButton(
//                     itemBuilder: (context) => [
//                       PopupMenuItem(
//                         child: Text('Update Status'),
//                         onTap: () => _showUpdateStatusDialog(context, order.id, order.status),
//                       ),
//                       PopupMenuItem(
//                         child: Text('View Details'),
//                         onTap: () {
//                           // Navigate to order details
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
  
//   void _showUpdateStatusDialog(BuildContext context, String orderId, String currentStatus) {
//     String? selectedStatus = currentStatus;
//     final trackingController = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Update Order Status'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               DropdownButtonFormField<String>(
//                 value: selectedStatus,
//                 items: [
//                   DropdownMenuItem(value: 'pending', child: Text('Pending')),
//                   DropdownMenuItem(value: 'confirmed', child: Text('Confirmed')),
//                   DropdownMenuItem(value: 'processing', child: Text('Processing')),
//                   DropdownMenuItem(value: 'shipped', child: Text('Shipped')),
//                   DropdownMenuItem(value: 'delivered', child: Text('Delivered')),
//                   DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
//                 ],
//                 onChanged: (value) {
//                   selectedStatus = value;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: trackingController,
//                 decoration: InputDecoration(
//                   labelText: 'Tracking Number',
//                   hintText: 'Optional',
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await _orderService.updateOrderStatus(
//                   orderId, 
//                   selectedStatus!,
//                   trackingNumber: trackingController.text.isNotEmpty 
//                       ? trackingController.text 
//                       : null,
//                 );
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Status updated')),
//                 );
//               },
//               child: Text('Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }
  
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'pending': return Colors.orange;
//       case 'confirmed': return Colors.blue;
//       case 'processing': return Colors.purple;
//       case 'shipped': return Colors.indigo;
//       case 'delivered': return Colors.green;
//       case 'cancelled': return Colors.red;
//       default: return Colors.grey;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:laptop_harbor/Admin/admin_order_detail.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  final OrderService _orderService = OrderService();
  String _selectedFilter = 'all';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        actions: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedFilter,
                icon: const Icon(Icons.filter_list, color: Colors.white),
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black, fontSize: 14),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedFilter = newValue;
                    });
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'all',
                    child: Row(
                      children: [
                        Icon(Icons.list, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text('All Orders'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'pending',
                    child: Row(
                      children: [
                        Icon(Icons.pending, color: Colors.orange, size: 20),
                        SizedBox(width: 8),
                        Text('Pending'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'confirmed',
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text('Confirmed'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'processing',
                    child: Row(
                      children: [
                        Icon(Icons.build, color: Colors.purple, size: 20),
                        SizedBox(width: 8),
                        Text('Processing'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'shipped',
                    child: Row(
                      children: [
                        Icon(Icons.local_shipping, color: Colors.indigo, size: 20),
                        SizedBox(width: 8),
                        Text('Shipped'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'delivered',
                    child: Row(
                      children: [
                        Icon(Icons.done_all, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Text('Delivered'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'cancelled',
                    child: Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text('Cancelled'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      body: _buildOrdersList(),
    );
  }
  
  Widget _buildOrdersList() {
    Query query = FirebaseFirestore.instance
        .collection('orders')
        .orderBy('orderDate', descending: true);
    
    // Apply filter if not 'all'
    if (_selectedFilter != 'all') {
      query = query.where('status', isEqualTo: _selectedFilter);
    }
    
    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }
        
        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error.toString());
        }
        
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }
        
        final orders = snapshot.data!.docs;
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final doc = orders[index];
            final data = doc.data() as Map<String, dynamic>;
            
            try {
              return _buildOrderCard(data, doc.id);
            } catch (e) {
              print('Error parsing order ${doc.id}: $e');
              return _buildErrorCard(doc.id, e.toString());
            }
          },
        );
      },
    );
  }
  
  Widget _buildOrderCard(Map<String, dynamic> data, String orderId) {
    try {
      // Safely parse the data
      final order = Order.fromMap(data);
      
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminOrderDetailScreen(
                  orderId: orderId,
                  orderData: data,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Order #${orderId.substring(orderId.length - 8).toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text(
                        _getStatusText(order.status),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: _getStatusColor(order.status),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Customer Info
                Row(
                  children: [
                    const Icon(Icons.person, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        order.shippingInfo.fullName,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Order Info
                Row(
                  children: [
                    const Icon(Icons.shopping_bag, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      '${order.items.length} item${order.items.length > 1 ? 's' : ''}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      '₹${order.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Order Date
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(order.orderDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showUpdateStatusDialog(context, orderId, order.status),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.blue.shade700),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 4),
                            Text('Update Status'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminOrderDetailScreen(
                                orderId: orderId,
                                orderData: data,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.visibility, size: 16),
                            SizedBox(width: 4),
                            Text('View Details'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      print('Error building order card: $e');
      return _buildErrorCard(orderId, e.toString());
    }
  }
  
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.blue[700],
          ),
          const SizedBox(height: 16),
          const Text(
            'Loading Orders...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error Loading Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedFilter == 'all' 
                ? 'When orders are placed, they will appear here.'
                : 'No orders with status "${_selectedFilter}"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildErrorCard(String orderId, String error) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Error Loading Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 4),
            Text('ID: ${orderId.substring(orderId.length - 8)}'),
            Text('Error: $error'),
          ],
        ),
      ),
    );
  }
  
  void _showUpdateStatusDialog(BuildContext context, String orderId, String currentStatus) {
    String? selectedStatus = currentStatus;
    final trackingController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.update, color: Colors.blue),
              const SizedBox(width: 12),
              const Text('Update Order Status'),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select new status:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'pending',
                      child: Row(
                        children: [
                          Icon(Icons.pending, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Pending'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'confirmed',
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.blue),
                          SizedBox(width: 8),
                          Text('Confirmed'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'processing',
                      child: Row(
                        children: [
                          Icon(Icons.build, color: Colors.purple),
                          SizedBox(width: 8),
                          Text('Processing'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'shipped',
                      child: Row(
                        children: [
                          Icon(Icons.local_shipping, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text('Shipped'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'delivered',
                      child: Row(
                        children: [
                          Icon(Icons.done_all, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Delivered'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'cancelled',
                      child: Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Cancelled'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    selectedStatus = value;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tracking Number (optional):',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: trackingController,
                  decoration: InputDecoration(
                    hintText: 'Enter tracking number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.track_changes),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedStatus != null) {
                  try {
                    await _orderService.updateOrderStatus(
                      orderId,
                      selectedStatus!,
                      trackingNumber: trackingController.text.isNotEmpty
                          ? trackingController.text
                          : null,
                    );
                    
                    Navigator.pop(context);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Order status updated successfully'),
                        backgroundColor: Colors.green[700],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
              ),
              child: const Text('Update Status'),
            ),
          ],
        );
      },
    );
  }
  
  String _getStatusText(String status) {
    switch (status) {
      case 'pending': return 'Pending';
      case 'confirmed': return 'Confirmed';
      case 'processing': return 'Processing';
      case 'shipped': return 'Shipped';
      case 'delivered': return 'Delivered';
      case 'cancelled': return 'Cancelled';
      default: return status;
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending': return Colors.orange;
      case 'confirmed': return Colors.blue;
      case 'processing': return Colors.purple;
      case 'shipped': return Colors.indigo;
      case 'delivered': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
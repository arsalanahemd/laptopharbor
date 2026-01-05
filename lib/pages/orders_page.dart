import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrderPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Order> allOrders = [
    Order(
      id: 'LH-2024-001',
      productName: 'MacBook Pro M3',
      brand: 'Apple',
      price: 1999,
      quantity: 1,
      orderDate: DateTime.now().subtract(Duration(days: 2)),
      deliveryDate: DateTime.now().add(Duration(days: 3)),
      status: OrderStatus.processing,
      trackingNumber: 'TRK123456789',
    ),
    Order(
      id: 'LH-2024-002',
      productName: 'Dell XPS 15',
      brand: 'Dell',
      price: 1499,
      quantity: 1,
      orderDate: DateTime.now().subtract(Duration(days: 10)),
      deliveryDate: DateTime.now().subtract(Duration(days: 2)),
      status: OrderStatus.delivered,
      trackingNumber: 'TRK987654321',
    ),
    Order(
      id: 'LH-2024-003',
      productName: 'ThinkPad X1 Carbon',
      brand: 'Lenovo',
      price: 1299,
      quantity: 1,
      orderDate: DateTime.now().subtract(Duration(days: 5)),
      deliveryDate: DateTime.now().add(Duration(days: 1)),
      status: OrderStatus.shipped,
      trackingNumber: 'TRK456789123',
    ),
    Order(
      id: 'LH-2024-004',
      productName: 'ROG Zephyrus G14',
      brand: 'ASUS',
      price: 1699,
      quantity: 1,
      orderDate: DateTime.now().subtract(Duration(days: 1)),
      deliveryDate: DateTime.now().add(Duration(days: 5)),
      status: OrderStatus.pending,
      trackingNumber: 'TRK789123456',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Order> getFilteredOrders(OrderStatus? status) {
    if (status == null) return allOrders;
    return allOrders.where((order) => order.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(null),
                _buildOrdersList(OrderStatus.processing),
                _buildOrdersList(OrderStatus.shipped),
                _buildOrdersList(OrderStatus.delivered),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E293B), Color(0xFF1E40AF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Orders',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${allOrders.length} total orders',
            style: TextStyle(
              color: Colors.blue[200],
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            // Search orders
          },
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.blue[700],
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Colors.blue[700],
        indicatorWeight: 3,
        tabs: [
          Tab(text: 'All (${allOrders.length})'),
          Tab(text: 'Processing (${getFilteredOrders(OrderStatus.processing).length})'),
          Tab(text: 'Shipped (${getFilteredOrders(OrderStatus.shipped).length})'),
          Tab(text: 'Delivered (${getFilteredOrders(OrderStatus.delivered).length})'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(OrderStatus? status) {
    final orders = getFilteredOrders(status);
    
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 100, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No Orders Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You don\'t have any orders yet',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: orders[index]);
      },
    );
  }
}

// Order Card Component
class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({required this.order, super.key});

  Color _getStatusColor() {
    switch (order.status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  IconData _getStatusIcon() {
    switch (order.status) {
      case OrderStatus.pending:
        return Icons.schedule;
      case OrderStatus.processing:
        return Icons.sync;
      case OrderStatus.shipped:
        return Icons.local_shipping;
      case OrderStatus.delivered:
        return Icons.check_circle;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[50]!, Colors.blue[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: ${order.id}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Placed: ${_formatDate(order.orderDate)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _getStatusColor(), width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_getStatusIcon(), size: 16, color: _getStatusColor()),
                      SizedBox(width: 6),
                      Text(
                        order.status.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Product Info
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey[100]!, Colors.blue[50]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.laptop_mac,
                    size: 40,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.productName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        order.brand,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$${order.price}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Qty: ${order.quantity}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tracking Info
          if (order.status != OrderStatus.pending && order.status != OrderStatus.cancelled)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.local_shipping, color: Colors.blue[700], size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tracking Number',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          order.trackingNumber,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.copy, color: Colors.blue[700], size: 18),
                ],
              ),
            ),

          // Action Buttons
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                if (order.status != OrderStatus.delivered && order.status != OrderStatus.cancelled)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Track order
                      },
                      icon: Icon(Icons.my_location, size: 18),
                      label: Text('Track Order'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue[700],
                        side: BorderSide(color: Colors.blue[300]!),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                if (order.status != OrderStatus.delivered && order.status != OrderStatus.cancelled)
                  SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // View details
                    },
                    icon: Icon(Icons.receipt_long, size: 18),
                    label: Text('View Details'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Order Status Enum
enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

// Order Model
class Order {
  final String id;
  final String productName;
  final String brand;
  final double price;
  final int quantity;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final OrderStatus status;
  final String trackingNumber;

  Order({
    required this.id,
    required this.productName,
    required this.brand,
    required this.price,
    required this.quantity,
    required this.orderDate,
    required this.deliveryDate,
    required this.status,
    required this.trackingNumber,
  });
}
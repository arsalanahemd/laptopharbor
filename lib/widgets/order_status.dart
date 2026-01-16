import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  
  const OrderStatusWidget({super.key, required this.status});
  
  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData(status);
    
    return Column(
      children: [
        LinearProgressIndicator(
          value: statusData['progress'],
          backgroundColor: Colors.grey[200],
          color: statusData['color'],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatusStep('Pending', 1, statusData['progress'] >= 0.2),
            _buildStatusStep('Confirmed', 2, statusData['progress'] >= 0.4),
            _buildStatusStep('Processing', 3, statusData['progress'] >= 0.6),
            _buildStatusStep('Shipped', 4, statusData['progress'] >= 0.8),
            _buildStatusStep('Delivered', 5, statusData['progress'] >= 1.0),
          ],
        ),
        SizedBox(height: 8),
        Center(
          child: Chip(
            label: Text(
              statusData['text'],
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: statusData['color'],
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatusStep(String label, int step, bool isActive) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
  
  Map<String, dynamic> _getStatusData(String status) {
    switch (status) {
      case 'pending':
        return {'progress': 0.2, 'color': Colors.orange, 'text': 'Pending'};
      case 'confirmed':
        return {'progress': 0.4, 'color': Colors.blue, 'text': 'Confirmed'};
      case 'processing':
        return {'progress': 0.6, 'color': Colors.purple, 'text': 'Processing'};
      case 'shipped':
        return {'progress': 0.8, 'color': Colors.indigo, 'text': 'Shipped'};
      case 'delivered':
        return {'progress': 1.0, 'color': Colors.green, 'text': 'Delivered'};
      case 'cancelled':
        return {'progress': 0.0, 'color': Colors.red, 'text': 'Cancelled'};
      default:
        return {'progress': 0.0, 'color': Colors.grey, 'text': 'Unknown'};
    }
  }
}
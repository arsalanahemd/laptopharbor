// lib/widgets/database_monitor.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMonitor extends StatelessWidget {
  const DatabaseMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('laptops')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorCard('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingCard();
        }

        final products = snapshot.data!.docs;
        
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            children: [
              Icon(
                products.isNotEmpty ? Icons.check_circle : Icons.info,
                color: products.isNotEmpty ? Colors.green : Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                'Products: ${products.length}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: products.isNotEmpty ? Colors.green : Colors.blue,
                ),
              ),
              const Spacer(),
              if (products.isNotEmpty)
                IconButton(
                  onPressed: () {
                    _showProductsDialog(context, products);
                  },
                  icon: const Icon(Icons.list, size: 20),
                  tooltip: 'View Products',
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 8),
          const Text('Loading database...'),
        ],
      ),
    );
  }

  void _showProductsDialog(BuildContext context, List<QueryDocumentSnapshot> products) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Products in Database'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(product['name'] ?? 'No Name'),
                subtitle: Text('₹${product['price'] ?? 0}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
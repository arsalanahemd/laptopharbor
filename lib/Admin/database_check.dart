// lib/Admin/database_check.dart
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCheckScreen extends StatefulWidget {
  const DatabaseCheckScreen({super.key});

  @override
  State<DatabaseCheckScreen> createState() => _DatabaseCheckScreenState();
}

class _DatabaseCheckScreenState extends State<DatabaseCheckScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _totalProducts = 0;
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkDatabase();
  }

  Future<void> _checkDatabase() async {
    try {
      final snapshot = await _firestore.collection('laptops').get();
      
      setState(() {
        _totalProducts = snapshot.docs.length;
        _products = snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'name': data['name'] ?? 'No Name',
            'brand': data['brand'] ?? 'No Brand',
            'price': data['price'] ?? 0,
            'category': data['category'] ?? 'No Category',
          };
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error checking database: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Check'),
        actions: [
          IconButton(
            onPressed: _checkDatabase,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Database Status Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // const Icon(
                          //   // Icons.database,
                          //   // size: 50,
                          //   // color: Colors.blue,
                          // ),
                          const SizedBox(height: 10),
                          Text(
                            'Database Status',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _totalProducts > 0 ? Colors.green : Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Total Products: $_totalProducts',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _totalProducts > 0
                                ? '✅ Products found in database'
                                : '❌ No products found in database',
                            style: TextStyle(
                              fontSize: 16,
                              color: _totalProducts > 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Products List
                  Expanded(
                    child: _totalProducts > 0
                        ? ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final product = _products[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue[100],
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(product['name']),
                                  subtitle: Text(
                                    '${product['brand']} - ₹${product['price']}',
                                  ),
                                  trailing: Chip(
                                    label: Text(product['category']),
                                    backgroundColor: Colors.blue[50],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.warning,
                                  size: 60,
                                  color: Colors.orange[400],
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'No products found in database',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Use the admin panel to add products',
                                  style: TextStyle(color: Colors.grey),
                                ),
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
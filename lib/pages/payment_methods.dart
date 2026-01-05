import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Visa **** 1234'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Mastercard **** 5678'),
          ),
        ],
      ),
    );
  }
}

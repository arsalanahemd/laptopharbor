import 'package:flutter/material.dart';
import 'package:laptop_harbor/pages/compare_seach_bar.dart';
import 'package:provider/provider.dart';

import '../providers/compare_provider.dart';
import '../models/laptop_model.dart';

class CompareTestPage extends StatelessWidget {
  const CompareTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final compare = Provider.of<CompareProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Compare Test')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // SELECT BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CompareSearchScreen(isFirst: true),
                        ),
                      );
                    },
                    child: const Text('Select Laptop A'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CompareSearchScreen(isFirst: false),
                        ),
                      );
                    },
                    child: const Text('Select Laptop B'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // RESULT
            if (!compare.isReady)
              const Text('Select two laptops to compare'),

            if (compare.isReady)
              _CompareResult(
                first: compare.firstLaptop!,
                second: compare.secondLaptop!,
              ),
          ],
        ),
      ),
    );
  }
}

class _CompareResult extends StatelessWidget {
  final LaptopModel first;
  final LaptopModel second;

  const _CompareResult({required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),

        Text('Laptop A: ${first.name}'),
        Text('Laptop B: ${second.name}'),

        const SizedBox(height: 10),
        const Divider(),

        _row('Price', first.price.toString(), second.price.toString()),
        _row('Processor', first.processor, second.processor),
        _row('RAM', '${first.ram} GB', '${second.ram} GB'),
        _row('Storage', '${first.storage} GB', '${second.storage} GB'),
        _row('Rating', first.rating.toString(), second.rating.toString()),
      ],
    );
  }

  Widget _row(String title, String v1, String v2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(v1)),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              v2,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

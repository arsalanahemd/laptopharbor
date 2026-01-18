import 'package:flutter/material.dart';
import 'package:laptop_harbor/models/laptop_model.dart';

class CompareSlot extends StatelessWidget {
  final LaptopModel? laptop;
  final VoidCallback onSelect;

  const CompareSlot({super.key, required this.laptop, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    if (laptop == null) {
      return GestureDetector(
        onTap: onSelect,
        child: Container(
          height: 160,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: const Center(child: Text('+ Select Laptop')),
        ),
      );
    }

    return Column(
      children: [
        Image.network(laptop!.imageUrl, height: 80),
        Text(laptop!.name, maxLines: 2),
        Text(laptop!.formattedPrice),
      ],
    );
  }
}

    import 'package:flutter/material.dart';

class BrandFilter extends StatelessWidget {
  final List<String> brands;
  final String selectedBrand;
  final Function(String) onBrandSelected;

  const BrandFilter({super.key, required this.brands, required this.selectedBrand, required this.onBrandSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: brands.length,
        itemBuilder: (_, i) {
          final brand = brands[i];
          final isSelected = selectedBrand == brand;
          return GestureDetector(
            onTap: () => onBrandSelected(brand),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected ? const LinearGradient(colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)]) : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: isSelected ? Colors.transparent : Colors.grey[300]!, width: 2),
                boxShadow: isSelected ? [BoxShadow(color: const Color(0xFFFF416C).withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))] : [],
              ),
              child: Text(brand, style: TextStyle(color: isSelected ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13)),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/filter_dialog.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearchOpen;
  final TextEditingController controller;
  final VoidCallback onSearchToggle;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterTap;
  final bool hasActiveFilters;

  const CustomAppBar({
    super.key,
    required this.isSearchOpen,
    required this.controller,
    required this.onSearchToggle,
    required this.onSearchChanged,
    required this.onFilterTap,
    required this.hasActiveFilters,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearchOpen
          ? TextField(
              controller: controller,
              autofocus: true,
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search laptops...',
                border: InputBorder.none,
              ),
            )
          : const Text('Laptop Harbor',
              style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(isSearchOpen ? Icons.close : Icons.search),
          onPressed: onSearchToggle,
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: onFilterTap,
            ),
            if (hasActiveFilters)
              const Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
              ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearchOpen;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchToggle;
  final VoidCallback onFilterClick;
  final VoidCallback onMenuClick;
  final VoidCallback onCartClick;
  final String title;
  final String subtitle;
  final int cartCount;

  const CustomAppBar({
    super.key,
    required this.isSearchOpen,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchToggle,
    required this.onFilterClick,
    required this.onMenuClick,
    required this.onCartClick,
    this.title = 'Laptop Harbor',
    this.subtitle = 'Premium Laptops',
    this.cartCount = 0, required Null Function() onNotificationClick, required Null Function() onSearchClick, required Null Function() onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 TOP BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onMenuClick,
                  icon: const Icon(Icons.menu, color: Colors.white),
                ),

                Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                Stack(
                  children: [
                    IconButton(
                      onPressed: onCartClick,
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                    if (cartCount > 0)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$cartCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// 🔍 SEARCH BAR
            Row(
              children: [
                Expanded(
                  child: isSearchOpen
                      ? TextField(
                          controller: searchController,
                          autofocus: true,
                          onChanged: onSearchChanged,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Search laptops...',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        )
                      : InkWell(
                          onTap: onSearchToggle,
                          child: Row(
                            children: const [
                              Icon(Icons.search, color: Colors.white70),
                              SizedBox(width: 8),
                              Text(
                                'Search laptops...',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onFilterClick,
                  icon: const Icon(Icons.tune, color: Colors.white),
                ),
                if (isSearchOpen)
                  IconButton(
                    onPressed: onSearchToggle,
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(isSearchOpen ? 140 : 120);
}

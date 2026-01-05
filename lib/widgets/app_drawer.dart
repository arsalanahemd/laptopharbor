
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onClose;
  final Map<String, String>? profile;

  const AppDrawer({
    super.key,
    required this.onClose,
    this.profile,
  });

  void handleMenuClick(String label) {
    print('Clicked: $label');
    // Add your navigation logic here
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.home, 'label': 'Home', 'color': Colors.grey[700]},
      {'icon': Icons.laptop, 'label': 'All Laptops', 'color': Colors.grey[700]},
      // {'icon': Icons.monitor, 'label': 'Brands', 'color': Colors.grey[700]},
      // {'icon': Icons.inventory_2, 'label': 'Accessories', 'color': Colors.grey[700]},
      // {'icon': Icons.local_offer, 'label': 'Deals & Offers', 'color': Colors.grey[700], 'badge': 'Hot'},
      // {'icon': Icons.sports_esports, 'label': 'Gaming Laptops', 'color': Colors.grey[700]},
      // {'icon': Icons.business_center, 'label': 'Business Laptops', 'color': Colors.grey[700]},
      {'icon': Icons.favorite, 'label': 'Favorites', 'color': Colors.grey[700]},
      {'icon': Icons.settings, 'label': 'My Account', 'color': Colors.blue[600], 'active': true},
      {'icon': Icons.help_outline, 'label': "FAQ's", 'color': Colors.grey[700]},
      {'icon': Icons.phone, 'label': 'Contact Us', 'color': Colors.grey[700]},
      // {'icon': Icons.public, 'label': 'Region', 'color': Colors.grey[700]},
    ];

    return Drawer(
      width: 320,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header - Profile Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey[50]!, Colors.blue[50]!],
                ),
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF60A5FA), Color(0xFF4F46E5)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        profile?['avatar'] ?? 'https://api.dicebear.com/7.x/avataaars/svg?seed=User',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, color: Colors.white, size: 32);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile?['name'] ?? 'Guest User',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          profile?['title'] ?? 'User',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(Icons.close, color: Colors.grey[600]),
                    splashRadius: 20,
                  ),
                ],
              ),
            ),

            // Logo Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF1E293B), Color(0xFF1E3A8A)],
                ),
                border: Border(bottom: BorderSide(color: Color(0xFF334155))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.laptop, color: Color(0xFF2563EB), size: 24),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'LAPTOP',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            'HARBOR',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF93C5FD),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    'v1.0',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF93C5FD),
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isActive = item['active'] == true;
                  final color = item['color'] as Color? ?? Colors.grey[700]!;

                  return InkWell(
                    onTap: () => handleMenuClick(item['label'] as String),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.blue[50] : null,
                        border: isActive
                            ? const Border(left: BorderSide(color: Color(0xFF2563EB), width: 4))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 20,
                            color: isActive ? Colors.blue[600] : color,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              item['label'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isActive ? Colors.blue[600] : const Color(0xFF374151),
                              ),
                            ),
                          ),
                          if (item['badge'] != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFF97316), Color(0xFFEF4444)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                item['badge'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Footer
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Column(
                children: [
                  // Settings & Logout
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => handleMenuClick('Settings'),
                          child: Row(
                            children: [
                              Icon(Icons.settings, size: 20, color: Colors.grey[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Settings',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('|', style: TextStyle(color: Colors.grey[300])),
                        InkWell(
                          onTap: () => handleMenuClick('Logout'),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Region Selector
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey[200]!)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.public, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 12),
                        Text(
                          'Region',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            foregroundColor: Colors.blue[700],
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            minimumSize: const Size(0, 28),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'USA',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            foregroundColor: Colors.grey[700],
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            minimumSize: const Size(0, 28),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'PK',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage Example:
// Scaffold(
//   appBar: AppBar(title: Text('Laptop Harbor')),
//   drawer: AppDrawer(
//     onClose: () => Navigator.of(context).pop(),
//     profile: {
//       'name': 'John Doe',
//       'title': 'Premium Member',
//       'avatar': 'https://example.com/avatar.jpg',
//     },
//   ),
//   body: Center(child: Text('Main Content')),
// );
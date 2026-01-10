// import 'package:flutter/material.dart';
// // import 'package:laptop_harborAdmin/admin_product.dart';
// import 'package:laptop_harbor/admin/admin_product.dart';
// // import 'package:laptop_harbor/ad';

// // Main Admin Dashboard Screen (Mobile Responsive)
// class AdminDashboard extends StatefulWidget {
//   const AdminDashboard({super.key});

//   @override
//   State<AdminDashboard> createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   int _selectedIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   final List<Widget> _pages = [
//     const DashboardHomePage(),
//     const AddProductsPage(), // ✅ Imported from admin_product_form.dart
//     const OrdersPage(),
//     const UsersPage(),
//     const SettingsPage(),
//   ];

//   final List<NavItem> _navItems = [
//     NavItem(icon: Icons.dashboard, label: 'Dashboard'),
//     NavItem(icon: Icons.laptop, label: 'Products'),
//     NavItem(icon: Icons.shopping_bag, label: 'Orders'),
//     NavItem(icon: Icons.people, label: 'Users'),
//     NavItem(icon: Icons.settings, label: 'Settings'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 900;

//     return Scaffold(
//       key: _scaffoldKey,
//       // Mobile Drawer
//       drawer: isMobile
//           ? Drawer(
//               child: AdminSidebar(
//                 selectedIndex: _selectedIndex,
//                 navItems: _navItems,
//                 onItemSelected: (index) {
//                   setState(() => _selectedIndex = index);
//                   Navigator.pop(context); // Close drawer
//                 },
//               ),
//             )
//           : null,
//       body: Row(
//         children: [
//           // Desktop Sidebar (hidden on mobile)
//           if (!isMobile)
//             AdminSidebar(
//               selectedIndex: _selectedIndex,
//               navItems: _navItems,
//               onItemSelected: (index) {
//                 setState(() => _selectedIndex = index);
//               },
//             ),
//           // Main Content
//           Expanded(
//             child: Column(
//               children: [
//                 // Top Bar
//                 AdminTopBar(
//                   isMobile: isMobile,
//                   onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
//                 ),
//                 // Page Content
//                 Expanded(child: _pages[_selectedIndex]),
//               ],
//             ),
//           ),
//         ],
//       ),
//       // Mobile Bottom Navigation
//       bottomNavigationBar: isMobile
//           ? BottomNavigationBar(
//               currentIndex: _selectedIndex,
//               onTap: (index) => setState(() => _selectedIndex = index),
//               type: BottomNavigationBarType.fixed,
//               selectedItemColor: const Color(0xFF3B82F6),
//               unselectedItemColor: const Color(0xFF94A3B8),
//               items: _navItems
//                   .map(
//                     (item) => BottomNavigationBarItem(
//                       icon: Icon(item.icon),
//                       label: item.label,
//                     ),
//                   )
//                   .toList(),
//             )
//           : null,
//     );
//   }
// }

// // Nav Item Model
// class NavItem {
//   final IconData icon;
//   final String label;

//   NavItem({required this.icon, required this.label});
// }

// // Sidebar Component
// class AdminSidebar extends StatelessWidget {
//   final int selectedIndex;
//   final List<NavItem> navItems;
//   final Function(int) onItemSelected;

//   const AdminSidebar({
//     super.key,
//     required this.selectedIndex,
//     required this.navItems,
//     required this.onItemSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 260,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 10,
//             offset: const Offset(2, 0),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             // Logo
//             Container(
//               padding: const EdgeInsets.all(24),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF3B82F6), Color(0xFF4F46E5)],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.laptop,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           'LAPTOP HARBOR',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Admin Panel',
//                           style: TextStyle(
//                             color: Color(0xFF94A3B8),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(color: Color(0xFF334155), height: 1),
//             // Navigation Items
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 itemCount: navItems.length,
//                 itemBuilder: (context, index) {
//                   final item = navItems[index];
//                   final isSelected = selectedIndex == index;
//                   return _buildNavItem(
//                     item,
//                     isSelected,
//                     () => onItemSelected(index),
//                   );
//                 },
//               ),
//             ),
//             // User Profile
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 border: Border(top: BorderSide(color: Color(0xFF334155))),
//               ),
//               child: Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Color(0xFF3B82F6),
//                     child: Icon(Icons.person, color: Colors.white),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           'Admin User',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Text(
//                           'admin@laptopharbor.com',
//                           style: TextStyle(
//                             color: Color(0xFF94A3B8),
//                             fontSize: 11,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(NavItem item, bool isSelected, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               item.icon,
//               color: isSelected ? Colors.white : const Color(0xFF94A3B8),
//               size: 22,
//             ),
//             const SizedBox(width: 12),
//             Text(
//               item.label,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : const Color(0xFF94A3B8),
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Top Bar Component (Responsive)
// class AdminTopBar extends StatelessWidget {
//   final bool isMobile;
//   final VoidCallback? onMenuPressed;

//   const AdminTopBar({super.key, this.isMobile = false, this.onMenuPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: isMobile ? 16 : 24,
//         vertical: 16,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Menu button (mobile only)
//           if (isMobile)
//             IconButton(onPressed: onMenuPressed, icon: const Icon(Icons.menu)),
//           // Search Bar
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8FAFC),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: const Color(0xFFE2E8F0)),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: isMobile
//                             ? 'Search...'
//                             : 'Search products, orders, users...',
//                         border: InputBorder.none,
//                         hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (!isMobile) ...[
//             const SizedBox(width: 16),
//             // Notification Button
//             IconButton(
//               onPressed: () {},
//               icon: Stack(
//                 children: [
//                   const Icon(Icons.notifications_outlined, size: 24),
//                   Positioned(
//                     right: 0,
//                     top: 0,
//                     child: Container(
//                       width: 8,
//                       height: 8,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFEF4444),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Messages Button
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.message_outlined, size: 24),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// // Dashboard Home Page (Responsive)
// class DashboardHomePage extends StatelessWidget {
//   const DashboardHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 900;

//     return SingleChildScrollView(
//       padding: EdgeInsets.all(isMobile ? 16 : 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Dashboard Overview',
//             style: TextStyle(
//               fontSize: isMobile ? 24 : 28,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//             ),
//           ),
//           const SizedBox(height: 24),
//           // Stats Cards (Responsive Grid)
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final crossAxisCount = isMobile ? 2 : 4;
//               return GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: crossAxisCount,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: isMobile ? 1.2 : 1.5,
//                 children: const [
//                   StatCard(
//                     title: 'Products',
//                     value: '248',
//                     icon: Icons.laptop,
//                     color: Color(0xFF3B82F6),
//                     percentage: '+12%',
//                     isPositive: true,
//                   ),
//                   StatCard(
//                     title: 'Orders',
//                     value: '1,234',
//                     icon: Icons.shopping_bag,
//                     color: Color(0xFF10B981),
//                     percentage: '+8%',
//                     isPositive: true,
//                   ),
//                   StatCard(
//                     title: 'Users',
//                     value: '856',
//                     icon: Icons.people,
//                     color: Color(0xFF8B5CF6),
//                     percentage: '+18%',
//                     isPositive: true,
//                   ),
//                   StatCard(
//                     title: 'Revenue',
//                     value: '\$45.2K',
//                     icon: Icons.attach_money,
//                     color: Color(0xFFF59E0B),
//                     percentage: '+5%',
//                     isPositive: true,
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 24),
//           // Recent Activity (Responsive Layout)
//           if (isMobile)
//             Column(
//               children: const [
//                 RecentOrdersWidget(),
//                 SizedBox(height: 16),
//                 TopProductsWidget(),
//               ],
//             )
//           else
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Expanded(flex: 2, child: RecentOrdersWidget()),
//                 SizedBox(width: 24),
//                 Expanded(child: TopProductsWidget()),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

// // Stat Card Widget (Responsive)
// class StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;
//   final String percentage;
//   final bool isPositive;

//   const StatCard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//     required this.percentage,
//     required this.isPositive,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 900;

//     return Container(
//       padding: EdgeInsets.all(isMobile ? 16 : 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(isMobile ? 8 : 12),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon, color: color, size: isMobile ? 20 : 24),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: isPositive
//                       ? const Color(0xFF10B981).withOpacity(0.1)
//                       : const Color(0xFFEF4444).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   percentage,
//                   style: TextStyle(
//                     color: isPositive
//                         ? const Color(0xFF10B981)
//                         : const Color(0xFFEF4444),
//                     fontWeight: FontWeight.w600,
//                     fontSize: isMobile ? 10 : 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: const Color(0xFF64748B),
//                   fontSize: isMobile ? 12 : 14,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: isMobile ? 20 : 28,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xFF1E293B),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Recent Orders Widget
// class RecentOrdersWidget extends StatelessWidget {
//   const RecentOrdersWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 900;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Recent Orders',
//             style: TextStyle(
//               fontSize: isMobile ? 16 : 18,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildOrderItem(
//             'ORD-001',
//             'MacBook Pro M3',
//             '\$1,999',
//             'Pending',
//             isMobile,
//           ),
//           _buildOrderItem(
//             'ORD-002',
//             'Dell XPS 15',
//             '\$1,499',
//             'Completed',
//             isMobile,
//           ),
//           _buildOrderItem(
//             'ORD-003',
//             'ThinkPad X1',
//             '\$1,299',
//             'Processing',
//             isMobile,
//           ),
//           _buildOrderItem(
//             'ORD-004',
//             'ASUS ROG',
//             '\$1,699',
//             'Shipped',
//             isMobile,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderItem(
//     String orderId,
//     String product,
//     String price,
//     String status,
//     bool isMobile,
//   ) {
//     Color statusColor;
//     switch (status) {
//       case 'Pending':
//         statusColor = const Color(0xFFF59E0B);
//         break;
//       case 'Completed':
//         statusColor = const Color(0xFF10B981);
//         break;
//       case 'Processing':
//         statusColor = const Color(0xFF3B82F6);
//         break;
//       case 'Shipped':
//         statusColor = const Color(0xFF8B5CF6);
//         break;
//       default:
//         statusColor = const Color(0xFF64748B);
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   orderId,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF1E293B),
//                     fontSize: isMobile ? 12 : 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   product,
//                   style: TextStyle(
//                     color: const Color(0xFF64748B),
//                     fontSize: isMobile ? 11 : 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (!isMobile)
//             Text(
//               price,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF1E293B),
//               ),
//             ),
//           const SizedBox(width: 12),
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: isMobile ? 8 : 12,
//               vertical: isMobile ? 4 : 6,
//             ),
//             decoration: BoxDecoration(
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Text(
//               status,
//               style: TextStyle(
//                 color: statusColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: isMobile ? 10 : 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Top Products Widget
// class TopProductsWidget extends StatelessWidget {
//   const TopProductsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 900;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Top Products',
//             style: TextStyle(
//               fontSize: isMobile ? 16 : 18,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildProductItem('MacBook Pro', '89 sales', isMobile),
//           _buildProductItem('Dell XPS', '76 sales', isMobile),
//           _buildProductItem('ThinkPad', '65 sales', isMobile),
//           _buildProductItem('ASUS ROG', '58 sales', isMobile),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductItem(String name, String sales, bool isMobile) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             name,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF1E293B),
//               fontSize: isMobile ? 13 : 15,
//             ),
//           ),
//           Text(
//             sales,
//             style: TextStyle(
//               color: const Color(0xFF64748B),
//               fontSize: isMobile ? 12 : 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Placeholder Pages
// class OrdersPage extends StatelessWidget {
//   const OrdersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Orders Page'));
//   }
// }

// class UsersPage extends StatelessWidget {
//   const UsersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Users Page'));
//   }
// }

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Settings Page'));
//   }
// }
// lib/screens/admin/admin_dashboard.dart
// lib/screens/admin/admin_dashboard.dart (Updated)
// lib/Admin/admin.dart

import 'package:flutter/material.dart';
import 'package:laptop_harbor/Admin/database_check.dart';
import 'package:laptop_harbor/Admin/database_monitor.dart';
import 'package:laptop_harbor/Admin/product_form.dart';
import 'package:laptop_harbor/Admin/products_list.dart';
import 'package:laptop_harbor/services/firestore_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final FirestoreService _firestoreService = FirestoreService();
  
  int _totalProducts = 0;
  int _hotDeals = 0;
  int _newArrivals = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);
    
    try {
      final laptops = await _firestoreService.getAllLaptops();
      setState(() {
        _totalProducts = laptops.length;
        _hotDeals = laptops.where((l) => l.isHotDeal).length;
        _newArrivals = laptops.where((l) => l.isNewArrival).length;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error loading stats: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshData() async {
    await _firestoreService.clearCache();
    await _loadStats();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Data refreshed'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Data',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DatabaseCheckScreen(),
                ),
              );
            },
            icon: const Icon(Icons.beach_access),
            tooltip: 'Check Database',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Database Monitor Widget
              const Padding(
                padding: EdgeInsets.all(16),
                child: DatabaseMonitor(),
              ),
              
              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              title: 'Total Products',
                              value: '$_totalProducts',
                              icon: Icons.inventory,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              title: 'Hot Deals',
                              value: '$_hotDeals',
                              icon: Icons.local_fire_department,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              title: 'New Arrivals',
                              value: '$_newArrivals',
                              icon: Icons.new_releases,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
              ),
              
              const SizedBox(height: 16),
              
              // Dashboard Action Cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildDashboardCard(
                    context,
                    icon: Icons.add_circle_outline,
                    title: 'Add Product',
                    subtitle: 'Create new listing',
                    color: Colors.blue,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductFormScreen(),
                        ),
                      );
                      
                      // Refresh stats if product was added
                      if (result == true) {
                        _loadStats();
                      }
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.list_alt,
                    title: 'View Products',
                    subtitle: 'Manage inventory',
                    color: Colors.green,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsListScreen(),
                        ),
                      );
                      
                      // Refresh stats if any changes were made
                      if (result == true) {
                        _loadStats();
                      }
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.storage,
                    title: 'Database',
                    subtitle: 'View database info',
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DatabaseCheckScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.analytics_outlined,
                    title: 'Analytics',
                    subtitle: 'View statistics',
                    color: Colors.teal,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Analytics coming soon!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 80), // Bottom padding
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductFormScreen(),
            ),
          );
          
          if (result == true) {
            _loadStats();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
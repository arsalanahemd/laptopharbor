
// // ignore_for_file: use_super_parameters

// import 'package:flutter/material.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTabChange;

//   const CustomBottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onTabChange,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       NavBarItem(icon: Icons.home, label: 'Home'),
//       NavBarItem(icon: Icons.laptop, label: 'Laptops'),
//       NavBarItem(icon: Icons.shopping_bag, label: 'Orders'),
//       NavBarItem(icon: Icons.favorite, label: 'Wishlist'),
//       NavBarItem(icon: Icons.person, label: 'Profile'),
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, -4),
//           ),
//         ],
//         border: const Border(
//           top: BorderSide(color: Color(0xFFF3F4F6)),
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Navigation Items
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: items.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final item = entry.value;
//                   final isSelected = selectedIndex == index;

//                   return Expanded(
//                     child: _buildNavItem(
//                       item: item,
//                       isSelected: isSelected,
//                       onTap: () => onTabChange(index),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//             // Bottom Indicator
//             _buildBottomIndicator(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required NavBarItem item,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           gradient: isSelected
//               ? const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Color(0xFF3B82F6), Color(0xFF4F46E5)],
//                 )
//               : null,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Icon Container with Background
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 gradient: isSelected
//                     ? const LinearGradient(
//                         colors: [Color(0xFF3B82F6), Color(0xFF4F46E5)],
//                       )
//                     : null,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: const Color(0xFF3B82F6).withOpacity(0.3),
//                           blurRadius: 12,
//                           offset: const Offset(0, 4),
//                         ),
//                       ]
//                     : null,
//               ),
//               child: Icon(
//                 item.icon,
//                 color: isSelected ? Colors.white : Colors.grey[500],
//                 size: 24,
//               ),
//             ),
//             const SizedBox(height: 4),
//             // Label
//             AnimatedDefaultTextStyle(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               style: TextStyle(
//                 fontSize: isSelected ? 12.5 : 12,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? const Color(0xFF2563EB) : Colors.grey[500],
//               ),
//               child: Text(item.label),
//             ),
//             // Active Indicator Line
//             if (isSelected)
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 margin: const EdgeInsets.only(top: 4),
//                 width: 48,
//                 height: 3,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF3B82F6), Color(0xFF4F46E5)],
//                   ),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomIndicator() {
//     return Center(
//       child: Container(
//         width: 128,
//         height: 4,
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFFCBD5E1), Color(0xFF93C5FD)],
//           ),
//           borderRadius: BorderRadius.circular(2),
//         ),
//       ),
//     );
//   }
// }

// // Model class for navigation items
// class NavBarItem {
//   final IconData icon;
//   final String label;

//   NavBarItem({
//     required this.icon,
//     required this.label,
//   });
// }

// // Usage Example:
// // CustomBottomNavBar(
// //   selectedIndex: 0,
// //   onTabChange: (index) {
// //     print('Tab changed to: $index');
// //     // Handle navigation here
// //   },
// // )
// ignore_for_file: use_super_parameters

// import 'package:flutter/material.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTabChange;

//   const CustomBottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onTabChange,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       NavBarItem(icon: Icons.home_outlined, selectedIcon: Icons.home, label: 'Home'),
//       NavBarItem(icon: Icons.laptop_outlined, selectedIcon: Icons.laptop, label: 'Laptops'),
//       NavBarItem(icon: Icons.shopping_bag_outlined, selectedIcon: Icons.shopping_bag, label: 'Orders'),
//       NavBarItem(icon: Icons.favorite_outline, selectedIcon: Icons.favorite, label: 'Wishlist'),
//       NavBarItem(icon: Icons.person_outline, selectedIcon: Icons.person, label: 'Profile'),
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: SizedBox(
//           height: 65,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: items.asMap().entries.map((entry) {
//               final index = entry.key;
//               final item = entry.value;
//               final isSelected = selectedIndex == index;

//               return _buildNavItem(
//                 item: item,
//                 isSelected: isSelected,
//                 onTap: () => onTabChange(index),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required NavBarItem item,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return Flexible(
//       child: InkWell(
//         onTap: onTap,
//         splashColor: Colors.blue.withOpacity(0.1),
//         highlightColor: Colors.transparent,
//         child: Center(
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             curve: Curves.easeInOut,
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             decoration: BoxDecoration(
//               color: isSelected 
//                 ? const Color(0xFFE0F2FE) 
//                 : Colors.transparent,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Icon
//                 Icon(
//                   isSelected ? item.selectedIcon : item.icon,
//                   color: isSelected 
//                     ? const Color(0xFF0284C7)
//                     : const Color(0xFF64748B),
//                   size: 22,
//                 ),
//                 // Label - Only show when selected
//                 if (isSelected) ...[
//                   const SizedBox(width: 6),
//                   Text(
//                     item.label,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF0284C7),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Model class for navigation items
// class NavBarItem {
//   final IconData icon;
//   final IconData selectedIcon;
//   final String label;

//   NavBarItem({
//     required this.icon,
//     required this.selectedIcon,
//     required this.label,
//   });
// }
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      NavBarItem(icon: Icons.home_outlined, selectedIcon: Icons.home, label: 'Home'),
      NavBarItem(icon: Icons.laptop_outlined, selectedIcon: Icons.laptop, label: 'Laptops'),
      NavBarItem(icon: Icons.shopping_bag_outlined, selectedIcon: Icons.shopping_bag, label: 'Orders'),
      NavBarItem(icon: Icons.favorite_outline, selectedIcon: Icons.favorite, label: 'Wishlist'),
      NavBarItem(icon: Icons.person_outline, selectedIcon: Icons.person, label: 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            
            // Responsive logic based on screen width
            bool isTablet = screenWidth > 600;
            bool isSmallScreen = screenWidth < 350;
            
            return SizedBox(
              height: isTablet ? 75 : 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = selectedIndex == index;

                  return _buildNavItem(
                    item: item,
                    isSelected: isSelected,
                    onTap: () => onTabChange(index),
                    isTablet: isTablet,
                    isSmallScreen: isSmallScreen,
                    screenWidth: screenWidth,
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required NavBarItem item,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isTablet,
    required bool isSmallScreen,
    required double screenWidth,
  }) {
    // Calculate responsive padding based on screen width
    double horizontalPadding = _calculatePadding(screenWidth);
    
    return Flexible(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.blue.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isTablet ? 12 : 8,
            ),
            decoration: BoxDecoration(
              color: isSelected 
                ? const Color(0xFFE0F2FE) 
                : Colors.transparent,
              borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with responsive size
                Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  color: isSelected 
                    ? const Color(0xFF0284C7)
                    : const Color(0xFF64748B),
                  size: isTablet ? 26 : (isSmallScreen ? 20 : 22),
                ),
                
                // Label - Show based on screen size
                if (isSelected || isTablet) ...[
                  SizedBox(width: isTablet ? 8 : 6),
                  Flexible(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: isTablet ? 14 : 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? const Color(0xFF0284C7) : const Color(0xFF64748B),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculatePadding(double screenWidth) {
    if (screenWidth < 320) {
      return 4.0; // Very small screens
    } else if (screenWidth < 375) {
      return 6.0; // Small screens
    } else if (screenWidth < 600) {
      return 10.0; // Normal mobile screens
    } else if (screenWidth < 900) {
      return 14.0; // Tablets
    } else {
      return 20.0; // Large tablets/desktops
    }
  }
}

// Model class for navigation items
class NavBarItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  NavBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
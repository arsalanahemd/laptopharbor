// // lib/widgets/app_drawer.dart

// // ignore_for_file: use_build_context_synchronously, avoid_print

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:laptop_harbor/pages/profile_page.dart';
// import 'package:laptop_harbor/pages/orders_page.dart';
// import 'package:laptop_harbor/pages/wishlist_page.dart';
// import 'package:laptop_harbor/pages/Setting_page.dart';
// import 'package:laptop_harbor/pages/Help_Support_Page.dart';
// import 'package:laptop_harbor/services/auth_service.dart';

// class AppDrawer extends StatefulWidget {
//   final VoidCallback onClose;
//   final Map<String, String>? profile; // Optional fallback

//   const AppDrawer({
//     super.key,
//     required this.onClose,
//     this.profile,
//   });

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // User data
//   String _userName = 'Guest';
//   String _userEmail = '';
//   String _userInitials = 'G';
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     setState(() => _isLoading = true);

//     try {
//       final user = _auth.currentUser;

//       if (user != null) {
//         // Set email from Firebase Auth
//         _userEmail = user.email ?? '';

//         // Try to load from Firestore
//         final userDoc = await _firestore
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         if (userDoc.exists && mounted) {
//           final data = userDoc.data()!;
//           setState(() {
//             _userName = data['name'] ?? user.displayName ?? 'User';
//             _userInitials = _getInitials(_userName);
//             _isLoading = false;
//           });
//         } else {
//           // Fallback to Firebase Auth
//           setState(() {
//             _userName = user.displayName ?? 'User';
//             _userInitials = _getInitials(_userName);
//             _isLoading = false;
//           });
//         }
//       } else {
//         // Guest mode
//         setState(() {
//           _userName = 'Guest';
//           _userEmail = 'Please login';
//           _userInitials = 'G';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('❌ Error loading drawer data: $e');
//       if (mounted) {
//         setState(() {
//           _userName = 'User';
//           _userEmail = '';
//           _userInitials = 'U';
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   String _getInitials(String name) {
//     if (name.isEmpty) return 'U';
    
//     final parts = name.trim().split(' ');
//     if (parts.length > 1) {
//       return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
//     }
//     return parts[0][0].toUpperCase();
//   }

//   Future<void> _handleLogout() async {
//     try {
//       await AuthService().logout();
      
//       if (mounted) {
//         Navigator.of(context).pushReplacementNamed('/login');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('❌ Logout failed: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           // ================= HEADER =================
//           _buildHeader(),

//           // ================= MENU ITEMS =================
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildMenuItem(
//                   icon: Icons.person_outline,
//                   title: 'My Profile',
//                   onTap: () {
//                     Navigator.pop(context); // Close drawer
//                     Future.delayed(const Duration(milliseconds: 100), () {
//                       if (mounted) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ProfilePage(),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//                 _buildMenuItem(
//                   icon: Icons.shopping_bag_outlined,
//                   title: 'My Orders',
//                   badge: '3',
//                   onTap: () {
//                     Navigator.pop(context); // Close drawer
//                     Future.delayed(const Duration(milliseconds: 100), () {
//                       if (mounted) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const OrderPage(),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//                 _buildMenuItem(
//                   icon: Icons.favorite_border,
//                   title: 'Wishlist',
//                   onTap: () {
//                     Navigator.pop(context); // Close drawer
//                     Future.delayed(const Duration(milliseconds: 100), () {
//                       if (mounted) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const WishlistPage(),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//                 const Divider(height: 1),
//                 _buildMenuItem(
//                   icon: Icons.settings_outlined,
//                   title: 'Settings',
//                   onTap: () {
//                     Navigator.pop(context); // Close drawer
//                     Future.delayed(const Duration(milliseconds: 100), () {
//                       if (mounted) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SettingsPage(),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//                 _buildMenuItem(
//                   icon: Icons.help_outline,
//                   title: 'Help & Support',
//                   onTap: () {
//                     Navigator.pop(context); // Close drawer
//                     Future.delayed(const Duration(milliseconds: 100), () {
//                       if (mounted) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const HelpSupportPage(),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//                 _buildMenuItem(
//                   icon: Icons.info_outline,
//                   title: 'About',
//                   onTap: () {
//                     Navigator.pop(context);
//                     _showAboutDialog();
//                   },
//                 ),
//               ],
//             ),
//           ),

//           // ================= LOGOUT BUTTON =================
//           const Divider(height: 1),
//           _buildMenuItem(
//             icon: Icons.logout,
//             title: 'Logout',
//             color: Colors.red,
//             onTap: () {
//               Navigator.pop(context);
//               _showLogoutDialog();
//             },
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF1E293B), Color(0xFF1E40AF)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Menu',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: widget.onClose,
//                     icon: const Icon(Icons.close, color: Colors.white),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
              
//               // Profile Avatar
//               _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context); // Close drawer first
//                         Future.delayed(const Duration(milliseconds: 100), () {
//                           if (mounted) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const ProfilePage(),
//                               ),
//                             );
//                           }
//                         });
//                       },
//                       child: Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: LinearGradient(
//                             colors: [Colors.blue[400]!, Colors.indigo[600]!],
//                           ),
//                           border: Border.all(color: Colors.white, width: 3),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             _userInitials,
//                             style: const TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//               const SizedBox(height: 12),
              
//               // User Name
//               Text(
//                 _userName,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 4),
              
//               // User Email
//               Text(
//                 _userEmail,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.blue[100],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
              
//               // View Profile Button
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pop(context); // Close drawer first
//                   Future.delayed(const Duration(milliseconds: 100), () {
//                     if (mounted) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ProfilePage(),
//                         ),
//                       );
//                     }
//                   });
//                 },
//                 icon: const Icon(Icons.person, size: 18),
//                 label: const Text('View Profile'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.blue[700],
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 10,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     String? badge,
//     Color? color,
//   }) {
//     return ListTile(
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: (color ?? Colors.blue).withOpacity(0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(
//           icon,
//           color: color ?? Colors.blue[700],
//           size: 24,
//         ),
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: color ?? Colors.grey[800],
//         ),
//       ),
//       trailing: badge != null
//           ? Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 badge,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//               color: Colors.grey[400],
//             ),
//       onTap: onTap,
//     );
//   }

//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _handleLogout();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//             ),
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAboutDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('About Laptop Harbor'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Version 1.0.0',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Your one-stop shop for premium laptops and tech devices.',
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Icon(Icons.email, size: 18, color: Colors.blue[700]),
//                 const SizedBox(width: 8),
//                 const Text('support@laptopharbor.com'),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// lib/widgets/app_drawer.dart

// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor/pages/profile_page.dart';
import 'package:laptop_harbor/pages/wishlist_page.dart';
import 'package:laptop_harbor/pages/Setting_page.dart';
import 'package:laptop_harbor/pages/Help_Support_Page.dart';
import 'package:laptop_harbor/services/auth_service.dart';
import 'dart:math' as math;

class AppDrawer extends StatefulWidget {
  final VoidCallback onClose;
  final Map<String, String>? profile;

  const AppDrawer({
    super.key,
    required this.onClose,
    this.profile,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User data
  String _userName = 'Guest';
  String _userEmail = '';
  String _userInitials = 'G';
  bool _isLoading = true;

  // Animation controllers
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _slideController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _initAnimations();
  }

  void _initAnimations() {
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      final user = _auth.currentUser;

      if (user != null) {
        _userEmail = user.email ?? '';

        final userDoc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists && mounted) {
          final data = userDoc.data()!;
          setState(() {
            _userName = data['name'] ?? user.displayName ?? 'User';
            _userInitials = _getInitials(_userName);
            _isLoading = false;
          });
        } else {
          setState(() {
            _userName = user.displayName ?? 'User';
            _userInitials = _getInitials(_userName);
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _userName = 'Guest';
          _userEmail = 'Please login';
          _userInitials = 'G';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Error loading drawer data: $e');
      if (mounted) {
        setState(() {
          _userName = 'User';
          _userEmail = '';
          _userInitials = 'U';
          _isLoading = false;
        });
      }
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  Future<void> _handleLogout() async {
    try {
      await AuthService().logout();
      
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('❌ Logout failed: $e'),
                ),
              ],
            ),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Drawer(
        child: Stack(
          children: [
            // Animated gradient background for header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 320,
              child: AnimatedBuilder(
                animation: _waveController,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1E293B),
                          const Color(0xFF1E40AF),
                          Color.lerp(
                            const Color(0xFF1E40AF),
                            const Color(0xFF3B82F6),
                            (_waveController.value * 0.3),
                          )!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Floating particles
            ...List.generate(12, (index) => _buildFloatingParticle(index)),
            // Main content
            Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildMenuItems()),
                _buildLogoutSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    final random = math.Random(index);
    final size = 3.0 + random.nextDouble() * 6;
    final initialX = random.nextDouble() * 280;
    final initialY = random.nextDouble() * 320;

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Positioned(
          left: initialX + (_floatingAnimation.value * (index % 3)),
          top: initialY + (_floatingAnimation.value * (index % 4)),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1 + (index % 3) * 0.1),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.white, Colors.blue[100]!],
                  ).createShader(bounds),
                  child: const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: widget.onClose,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Profile Avatar with pulse animation
            _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(milliseconds: 100), () {
                              if (mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilePage(),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Colors.blue[400]!, Colors.indigo[600]!],
                              ),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 20,
                                  spreadRadius: 3,
                                  offset: const Offset(0, 8),
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                _userInitials,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 16),
            
            // User Name
            Text(
              _userName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            
            // User Email
            Text(
              _userEmail,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            
            // View Profile Button with gradient
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[50]!],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.pop(context);
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 18, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Text(
                          'View Profile',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        children: [
          _buildGlassMenuItem(
            icon: Icons.person_outline,
            title: 'My Profile',
            gradient: LinearGradient(
              colors: [Colors.blue[50]!, Colors.blue[100]!],
            ),
            iconColor: Colors.blue[700]!,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                }
              });
            },
          ),
          const SizedBox(height: 8),
          _buildGlassMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            badge: '3',
            gradient: LinearGradient(
              colors: [Colors.orange[50]!, Colors.orange[100]!],
            ),
            iconColor: Colors.orange[700]!,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                // if (mounted) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const CheckoutScreen(),
                //     ),
                //   );
                // }
              });
            },
          ),
          const SizedBox(height: 8),
          _buildGlassMenuItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            gradient: LinearGradient(
              colors: [Colors.pink[50]!, Colors.pink[100]!],
            ),
            iconColor: Colors.pink[700]!,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishlistPage(),
                    ),
                  );
                }
              });
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: Colors.grey[300], height: 1),
          ),
          const SizedBox(height: 16),
          _buildGlassMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.grey[200]!],
            ),
            iconColor: Colors.grey[700]!,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                }
              });
            },
          ),
          const SizedBox(height: 8),
          _buildGlassMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            gradient: LinearGradient(
              colors: [Colors.green[50]!, Colors.green[100]!],
            ),
            iconColor: Colors.green[700]!,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpSupportPage(),
                    ),
                  );
                }
              });
            },
          ),
          const SizedBox(height: 8),
          _buildGlassMenuItem(
            icon: Icons.info_outline,
            title: 'About',
            gradient: LinearGradient(
              colors: [Colors.purple[50]!, Colors.purple[100]!],
            ),
            iconColor: Colors.purple[700]!,
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGlassMenuItem({
    required IconData icon,
    required String title,
    required LinearGradient gradient,
    required Color iconColor,
    required VoidCallback onTap,
    String? badge,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: iconColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.red[400]!, Colors.red[600]!],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout, color: Colors.white, size: 22),
                  SizedBox(width: 12),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.logout, color: Colors.red[700]),
            ),
            const SizedBox(width: 12),
            const Text('Logout'),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[700],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.red[400]!, Colors.red[600]!],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.pop(context);
                  _handleLogout();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.laptop_mac, color: Colors.blue[700]),
            ),
            const SizedBox(width: 12),
            const Text('About Laptop Harbor'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your one-stop shop for premium laptops and tech devices.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.email, size: 20, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'support@laptopharbor.com',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.blue[800]!],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
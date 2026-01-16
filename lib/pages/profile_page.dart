// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:laptop_harbor/pages/Help_Support_Page.dart';
// import 'package:laptop_harbor/pages/Setting_page.dart';
// import 'package:laptop_harbor/pages/payment_methods.dart';
// import 'package:laptop_harbor/pages/shipping_address.dart';
// import 'package:laptop_harbor/pages/wishlist_page.dart';
// import 'package:laptop_harbor/services/auth_service.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
//   bool isEditing = false;
//   bool _isLoading = true;
  
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _addressController = TextEditingController();

//   String _userInitials = 'U';
//   int _pendingOrders = 0;
//   int _deliveredOrders = 0;
//   int _processingOrders = 0;

//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late AnimationController _scaleController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     _loadUserData();
//   }

//   void _setupAnimations() {
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );

//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeOutCubic,
//     ));

//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     _scaleController.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserData() async {
//     setState(() => _isLoading = true);

//     try {
//       final user = _auth.currentUser;
      
//       if (user != null) {
//         _emailController.text = user.email ?? 'No email';

//         final userDoc = await _firestore
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         if (userDoc.exists) {
//           final data = userDoc.data()!;
          
//           setState(() {
//             _nameController.text = data['name'] ?? user.displayName ?? 'User';
//             _phoneController.text = data['phone'] ?? '';
//             _addressController.text = data['address'] ?? '';
            
//             final name = _nameController.text;
//             if (name.isNotEmpty) {
//               final parts = name.split(' ');
//               _userInitials = parts.length > 1
//                   ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
//                   : parts[0][0].toUpperCase();
//             }
//           });
//         } else {
//           await _createUserProfile(user);
//         }

//         await _loadOrderStats(user.uid);
//       }

//       // Start animations
//       _fadeController.forward();
//       _slideController.forward();
//       _scaleController.forward();

//     } catch (e) {
//       print('❌ Error loading user data: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to load profile: $e'),
//             backgroundColor: Colors.red[600],
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//         );
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _createUserProfile(User user) async {
//     try {
//       await _firestore.collection('users').doc(user.uid).set({
//         'name': user.displayName ?? 'User',
//         'email': user.email,
//         'phone': '',
//         'address': '',
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });

//       setState(() {
//         _nameController.text = user.displayName ?? 'User';
//       });
//     } catch (e) {
//       print('❌ Error creating profile: $e');
//     }
//   }

//   Future<void> _loadOrderStats(String userId) async {
//     try {
//       final ordersSnapshot = await _firestore
//           .collection('orders')
//           .where('userId', isEqualTo: userId)
//           .get();

//       int pending = 0;
//       int delivered = 0;
//       int processing = 0;

//       for (var doc in ordersSnapshot.docs) {
//         final status = doc.data()['status'] as String? ?? '';
        
//         if (status == 'pending') {
//           pending++;
//         } else if (status == 'delivered') {
//           delivered++;
//         } else if (status == 'processing') {
//           processing++;
//         }
//       }

//       setState(() {
//         _pendingOrders = pending;
//         _deliveredOrders = delivered;
//         _processingOrders = processing;
//       });
//     } catch (e) {
//       print('❌ Error loading order stats: $e');
//     }
//   }

//   void _toggleEdit() {
//     setState(() {
//       isEditing = !isEditing;
//     });
//   }

//   Future<void> _saveProfile() async {
//     final user = _auth.currentUser;
//     if (user == null) return;

//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );

//       await _firestore.collection('users').doc(user.uid).update({
//         'name': _nameController.text.trim(),
//         'phone': _phoneController.text.trim(),
//         'address': _addressController.text.trim(),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });

//       await user.updateDisplayName(_nameController.text.trim());

//       final name = _nameController.text;
//       if (name.isNotEmpty) {
//         final parts = name.split(' ');
//         _userInitials = parts.length > 1
//             ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
//             : parts[0][0].toUpperCase();
//       }

//       if (mounted) {
//         Navigator.pop(context);
        
//         setState(() {
//           isEditing = false;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.white),
//                 SizedBox(width: 12),
//                 Text('Profile updated successfully!'),
//               ],
//             ),
//             backgroundColor: Colors.green[600],
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             margin: const EdgeInsets.all(16),
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         Navigator.pop(context);
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.toString()}'),
//             backgroundColor: Colors.red[600],
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _cancelEdit() async {
//     await _loadUserData();
//     setState(() {
//       isEditing = false;
//     });
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
//             content: Text('Logout failed: $e'),
//             backgroundColor: Colors.red[600],
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         backgroundColor: const Color(0xFFF5F7FA),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TweenAnimationBuilder<double>(
//                 tween: Tween(begin: 0.0, end: 1.0),
//                 duration: const Duration(seconds: 2),
//                 builder: (context, value, child) {
//                   return Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // Outer rotating circle
//                       Transform.rotate(
//                         angle: value * 2 * 3.14159,
//                         child: Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.blue[300]!,
//                               width: 3,
//                             ),
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.blue[400]!,
//                                 Colors.transparent,
//                               ],
//                               stops: const [0.5, 0.5],
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Inner pulsing circle
//                       Container(
//                         width: 60 + (value * 10),
//                         height: 60 + (value * 10),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.blue[400]!.withOpacity(1 - value * 0.3),
//                               Colors.blue[600]!.withOpacity(1 - value * 0.3),
//                             ],
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.blue.withOpacity(0.3),
//                               blurRadius: 20 * value,
//                               spreadRadius: 5 * value,
//                             ),
//                           ],
//                         ),
//                         child: const Icon(
//                           Icons.person_rounded,
//                           color: Colors.white,
//                           size: 32,
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//                 onEnd: () {
//                   setState(() {});
//                 },
//               ),
//               const SizedBox(height: 32),
//               TweenAnimationBuilder<double>(
//                 tween: Tween(begin: 0.0, end: 1.0),
//                 duration: const Duration(milliseconds: 1500),
//                 builder: (context, value, child) {
//                   return Opacity(
//                     opacity: value,
//                     child: const Text(
//                       'Loading profile...',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF64748B),
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: RefreshIndicator(
//           onRefresh: _loadUserData,
//           color: Colors.blue[600],
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               children: [
//                 _buildProfileHeader(),
//                 const SizedBox(height: 24),
//                 SlideTransition(
//                   position: _slideAnimation,
//                   child: _buildOrderStats(),
//                 ),
//                 const SizedBox(height: 20),
//                 SlideTransition(
//                   position: _slideAnimation,
//                   child: _buildProfileDetails(),
//                 ),
//                 const SizedBox(height: 20),
//                 SlideTransition(
//                   position: _slideAnimation,
//                   child: _buildMenuOptions(),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildLogoutButton(),
//                 const SizedBox(height: 80),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileHeader() {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         // Background gradient container
//         Container(
//           height: 280,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue[600]!, Colors.blue[800]!],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
        
//         // Profile content
//         SafeArea(
//           child: Column(
//             children: [
//               // Top actions bar
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Profile',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: IconButton(
//                         icon: const Icon(Icons.settings_outlined, color: Colors.white),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => const SettingsPage()),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
              
//               const SizedBox(height: 20),
              
//               // Profile picture
//               ScaleTransition(
//                 scale: _scaleAnimation,
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [Colors.white, Colors.blue[50]!],
//                         ),
//                         border: Border.all(color: Colors.white, width: 4),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 20,
//                             offset: const Offset(0, 8),
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           _userInitials,
//                           style: TextStyle(
//                             fontSize: 36,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue[700],
//                           ),
//                         ),
//                       ),
//                     ),
//                     if (isEditing)
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Colors.blue[400]!, Colors.blue[600]!],
//                             ),
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white, width: 2.5),
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt_rounded,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
              
//               const SizedBox(height: 16),
              
//               // Name
//               if (isEditing)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.white.withOpacity(0.3)),
//                     ),
//                     child: TextField(
//                       controller: _nameController,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Enter name',
//                         hintStyle: TextStyle(color: Colors.white60),
//                         isDense: true,
//                         contentPadding: EdgeInsets.symmetric(vertical: 8),
//                       ),
//                     ),
//                   ),
//                 )
//               else
//                 Text(
//                   _nameController.text.isNotEmpty ? _nameController.text : 'User',
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
              
//               const SizedBox(height: 8),
              
//               // Email badge
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.25),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.email_outlined,
//                       size: 14,
//                       color: Colors.white.withOpacity(0.9),
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       _emailController.text,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white.withOpacity(0.95),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
              
//               const SizedBox(height: 20),
              
//               // Edit/Save buttons
//               if (!isEditing)
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 40),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.15),
//                         blurRadius: 12,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: _toggleEdit,
//                       borderRadius: BorderRadius.circular(14),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.edit_rounded, size: 18, color: Colors.blue[700]),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Edit Profile',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.blue[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               else
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _cancelEdit,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white.withOpacity(0.2),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: const BorderSide(color: Colors.white, width: 1.5),
//                         ),
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.close_rounded, size: 18),
//                           SizedBox(width: 6),
//                           Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     ElevatedButton(
//                       onPressed: _saveProfile,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.green[600],
//                         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.check_rounded, size: 18),
//                           SizedBox(width: 6),
//                           Text('Save', style: TextStyle(fontWeight: FontWeight.w600)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
              
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOrderStats() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           Expanded(child: _buildStatCard('Pending', '$_pendingOrders', Icons.schedule_rounded, Colors.orange)),
//           const SizedBox(width: 14),
//           Expanded(child: _buildStatCard('Delivered', '$_deliveredOrders', Icons.check_circle_rounded, Colors.green)),
//           const SizedBox(width: 14),
//           Expanded(child: _buildStatCard('Processing', '$_processingOrders', Icons.sync_rounded, Colors.blue)),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatCard(String label, String count, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.1),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: color, size: 26),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             count,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileDetails() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             _buildDetailItem(
//               Icons.email_outlined,
//               'Email',
//               _emailController,
//               TextInputType.emailAddress,
//               enabled: false,
//             ),
//             Divider(height: 1, color: Colors.grey[200]),
//             _buildDetailItem(
//               Icons.phone_outlined,
//               'Phone',
//               _phoneController,
//               TextInputType.phone,
//             ),
//             Divider(height: 1, color: Colors.grey[200]),
//             _buildDetailItem(
//               Icons.location_on_outlined,
//               'Address',
//               _addressController,
//               TextInputType.streetAddress,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailItem(
//     IconData icon,
//     String label,
//     TextEditingController controller,
//     TextInputType keyboardType, {
//     bool enabled = true,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(18),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue[50]!, Colors.blue[100]!.withOpacity(0.3)],
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: Colors.blue[700], size: 22),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 if (isEditing && enabled)
//                   TextField(
//                     controller: controller,
//                     keyboardType: keyboardType,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xFF2D3748),
//                     ),
//                     decoration: InputDecoration(
//                       isDense: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: Colors.grey[300]!),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                     ),
//                   )
//                 else
//                   Text(
//                     controller.text.isNotEmpty ? controller.text : 'Not set',
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: controller.text.isNotEmpty ? const Color(0xFF2D3748) : Colors.grey[400],
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuOptions() {
//     final menuItems = [
//       {'icon': Icons.shopping_bag_outlined, 'title': 'My Orders', 'page': null},
//       {'icon': Icons.favorite_border, 'title': 'Wishlist', 'page': const WishlistPage()},
//       {'icon': Icons.location_on_outlined, 'title': 'Shipping Address', 'page': const ShippingAddressPage()},
//       {'icon': Icons.payment_outlined, 'title': 'Payment Methods', 'page': const PaymentMethodsPage()},
//       {'icon': Icons.settings_outlined, 'title': 'Settings', 'page': const SettingsPage()},
//       {'icon': Icons.help_outline, 'title': 'Help & Support', 'page': const HelpSupportPage()},
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           children: menuItems.asMap().entries.map((entry) {
//             final index = entry.key;
//             final item = entry.value;
//             final isLast = index == menuItems.length - 1;
            
//             return Column(
//               children: [
//                 _buildMenuItem(
//                   item['icon'] as IconData,
//                   item['title'] as String,
//                   () {
//                     final page = item['page'];
//                     if (page != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => page as Widget),
//                       );
//                     }
//                   },
//                 ),
//                 if (!isLast) Divider(height: 1, color: Colors.grey[200]),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blue[50]!, Colors.blue[100]!.withOpacity(0.3)],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, color: Colors.blue[700], size: 22),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF2D3748),
//                   ),
//                 ),
//               ),
//               Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogoutButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red[400]!, Colors.red[600]!],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.withOpacity(0.3),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: ElevatedButton.icon(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 title: const Text(
//                   'Logout',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 content: const Text('Are you sure you want to logout?'),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _handleLogout();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red[600],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text('Logout'),
//                   ),
//                 ],
//               ),
//             );
//           },
//           icon: const Icon(Icons.logout_rounded, size: 20),
//           label: const Text(
//             'Logout',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             foregroundColor: Colors.white,
//             shadowColor: Colors.transparent,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             minimumSize: const Size(double.infinity, 54),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor/pages/Help_Support_Page.dart';
import 'package:laptop_harbor/pages/Setting_page.dart';
import 'package:laptop_harbor/pages/laptop_home_page.dart';
import 'package:laptop_harbor/pages/payment_methods.dart';
import 'package:laptop_harbor/pages/shipping_address.dart';
import 'package:laptop_harbor/pages/wishlist_page.dart';
import 'package:laptop_harbor/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  bool isEditing = false;
  bool _isLoading = true;
  
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String _userInitials = 'U';
  int _pendingOrders = 0;
  int _deliveredOrders = 0;
  int _processingOrders = 0;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadUserData();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      final user = _auth.currentUser;
      
      if (user != null) {
        _emailController.text = user.email ?? 'No email';

        final userDoc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final data = userDoc.data()!;
          
          setState(() {
            _nameController.text = data['name'] ?? user.displayName ?? 'User';
            _phoneController.text = data['phone'] ?? '';
            _addressController.text = data['address'] ?? '';
            
            final name = _nameController.text;
            if (name.isNotEmpty) {
              final parts = name.split(' ');
              _userInitials = parts.length > 1
                  ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
                  : parts[0][0].toUpperCase();
            }
          });
        } else {
          await _createUserProfile(user);
        }

        await _loadOrderStats(user.uid);
      }

      // Start animations
      _fadeController.forward();
      _slideController.forward();
      _scaleController.forward();

    } catch (e) {
      print('❌ Error loading user data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load profile: $e'),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createUserProfile(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'name': user.displayName ?? 'User',
        'email': user.email,
        'phone': '',
        'address': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      setState(() {
        _nameController.text = user.displayName ?? 'User';
      });
    } catch (e) {
      print('❌ Error creating profile: $e');
    }
  }

  Future<void> _loadOrderStats(String userId) async {
    try {
      final ordersSnapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      int pending = 0;
      int delivered = 0;
      int processing = 0;

      for (var doc in ordersSnapshot.docs) {
        final status = doc.data()['status'] as String? ?? '';
        
        if (status == 'pending') {
          pending++;
        } else if (status == 'delivered') {
          delivered++;
        } else if (status == 'processing') {
          processing++;
        }
      }

      setState(() {
        _pendingOrders = pending;
        _deliveredOrders = delivered;
        _processingOrders = processing;
      });
    } catch (e) {
      print('❌ Error loading order stats: $e');
    }
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      await _firestore.collection('users').doc(user.uid).update({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'address': _addressController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await user.updateDisplayName(_nameController.text.trim());

      final name = _nameController.text;
      if (name.isNotEmpty) {
        final parts = name.split(' ');
        _userInitials = parts.length > 1
            ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
            : parts[0][0].toUpperCase();
      }

      if (mounted) {
        Navigator.pop(context);
        
        setState(() {
          isEditing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Profile updated successfully!'),
              ],
            ),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _cancelEdit() async {
    await _loadUserData();
    setState(() {
      isEditing = false;
    });
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
            content: Text('Logout failed: $e'),
            backgroundColor: Colors.red[600],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer rotating circle
                      Transform.rotate(
                        angle: value * 2 * 3.14159,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue[300]!,
                              width: 3,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue[400]!,
                                Colors.transparent,
                              ],
                              stops: const [0.5, 0.5],
                            ),
                          ),
                        ),
                      ),
                      // Inner pulsing circle
                      Container(
                        width: 60 + (value * 10),
                        height: 60 + (value * 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue[400]!.withOpacity(1 - value * 0.3),
                              Colors.blue[600]!.withOpacity(1 - value * 0.3),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 20 * value,
                              spreadRadius: 5 * value,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  );
                },
                onEnd: () {
                  setState(() {});
                },
              ),
              const SizedBox(height: 32),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: const Text(
                      'Loading profile...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: RefreshIndicator(
          onRefresh: _loadUserData,
          color: Colors.blue[600],
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 24),
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildOrderStats(),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildProfileDetails(),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildMenuOptions(),
                ),
                const SizedBox(height: 20),
                _buildLogoutButton(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background gradient container
        Container(
          height: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.blue[800]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        
        // Profile content
        SafeArea(
          child: Column(
            children: [
              // Top actions bar with Back Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () {
                        // Navigator.pop(context); // Home screen par le jayega
                      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LaptopHomePage()),
      (Route<dynamic> route) => false,
    );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.settings_outlined, color: Colors.white),
                        onPressed: () {
                          // Navigator.push(
                            // context,
                            // MaterialPageRoute(builder: (_) => const SettingsPage()),
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Profile picture
              ScaleTransition(
                scale: _scaleAnimation,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blue[50]!],
                        ),
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _userInitials,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    ),
                    if (isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue[400]!, Colors.blue[600]!],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.5),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Name
              if (isEditing)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter name',
                        hintStyle: TextStyle(color: Colors.white60),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                )
              else
                Text(
                  _nameController.text.isNotEmpty ? _nameController.text : 'User',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              
              const SizedBox(height: 8),
              
              // Email badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _emailController.text,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Edit/Save buttons
              if (!isEditing)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _toggleEdit,
                      borderRadius: BorderRadius.circular(14),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit_rounded, size: 18, color: Colors.blue[700]),
                            const SizedBox(width: 8),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _cancelEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.close_rounded, size: 18),
                          SizedBox(width: 6),
                          Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green[600],
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_rounded, size: 18),
                          SizedBox(width: 6),
                          Text('Save', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _buildStatCard('Pending', '$_pendingOrders', Icons.schedule_rounded, Colors.orange)),
          const SizedBox(width: 14),
          Expanded(child: _buildStatCard('Delivered', '$_deliveredOrders', Icons.check_circle_rounded, Colors.green)),
          const SizedBox(width: 14),
          Expanded(child: _buildStatCard('Processing', '$_processingOrders', Icons.sync_rounded, Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildDetailItem(
              Icons.email_outlined,
              'Email',
              _emailController,
              TextInputType.emailAddress,
              enabled: false,
            ),
            Divider(height: 1, color: Colors.grey[200]),
            _buildDetailItem(
              Icons.phone_outlined,
              'Phone',
              _phoneController,
              TextInputType.phone,
            ),
            Divider(height: 1, color: Colors.grey[200]),
            _buildDetailItem(
              Icons.location_on_outlined,
              'Address',
              _addressController,
              TextInputType.streetAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    TextEditingController controller,
    TextInputType keyboardType, {
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[50]!, Colors.blue[100]!.withOpacity(0.3)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                if (isEditing && enabled)
                  TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3748),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                  )
                else
                  Text(
                    controller.text.isNotEmpty ? controller.text : 'Not set',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: controller.text.isNotEmpty ? const Color(0xFF2D3748) : Colors.grey[400],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOptions() {
    final menuItems = [
      {'icon': Icons.shopping_bag_outlined, 'title': 'My Orders', 'page': null},
      {'icon': Icons.favorite_border, 'title': 'Wishlist', 'page': const WishlistPage()},
      {'icon': Icons.location_on_outlined, 'title': 'Shipping Address', 'page': const ShippingAddressPage()},
      {'icon': Icons.payment_outlined, 'title': 'Payment Methods', 'page': const PaymentMethodsPage()},
      {'icon': Icons.settings_outlined, 'title': 'Settings', 'page': const SettingsPage()},
      {'icon': Icons.help_outline, 'title': 'Help & Support', 'page': const HelpSupportPage()},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: menuItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == menuItems.length - 1;
            
            return Column(
              children: [
                _buildMenuItem(
                  item['icon'] as IconData,
                  item['title'] as String,
                  () {
                    final page = item['page'];
                    if (page != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => page as Widget),
                      );
                    }
                  },
                ),
                if (!isLast) Divider(height: 1, color: Colors.grey[200]),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[50]!, Colors.blue[100]!.withOpacity(0.3)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.blue[700], size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red[400]!, Colors.red[600]!],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleLogout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.logout_rounded, size: 20),
          label: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 54),
          ),
        ),
      ),
    );
  }
}
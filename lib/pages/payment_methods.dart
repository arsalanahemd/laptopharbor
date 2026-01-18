// import 'package:flutter/material.dart';

// class PaymentMethodsPage extends StatefulWidget {
//   const PaymentMethodsPage({super.key});

//   @override
//   State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
// }

// class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
//   // Track selected payment method
//   int _selectedMethodIndex = 0;
  
//   // Payment methods data
//   final List<Map<String, dynamic>> _paymentMethods = [
//     {
//       'type': 'Visa',
//       'lastFour': '1234',
//       'icon': Icons.credit_card,
//       'color': const Color(0xFF1A1F71),
//       'gradient': [const Color(0xFF1A1F71), const Color(0xFF3A4FBC)],
//       'expiry': '05/25',
//       'holder': 'John Doe'
//     },
//     {
//       'type': 'Mastercard',
//       'lastFour': '5678',
//       'icon': Icons.credit_card,
//       'color': const Color(0xFFEB001B),
//       'gradient': [const Color(0xFFF79E1B), const Color(0xFFEB001B)],
//       'expiry': '11/26',
//       'holder': 'John Doe'
//     },
//     {
//       'type': 'PayPal',
//       'lastFour': '',
//       'icon': Icons.payment,
//       'color': const Color(0xFF003087),
//       'gradient': [const Color(0xFF003087), const Color(0xFF009CDE)],
//       'expiry': '',
//       'holder': 'john.doe@email.com'
//     },
//     {
//       'type': 'Apple Pay',
//       'lastFour': '',
//       'icon': Icons.phone_iphone,
//       'color': const Color(0xFF000000),
//       'gradient': [const Color(0xFF000000), const Color(0xFF434343)],
//       'expiry': '',
//       'holder': 'iPhone 12 Pro'
//     },
//   ];

//   // Track animation states
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     // Simulate loading animation
//     Future.delayed(const Duration(milliseconds: 300), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Payment Methods',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.5,
//           ),
//         ),
//         backgroundColor: const Color(0xFF1E293B),
//         elevation: 0,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Add new payment method
//               _showAddMethodDialog(context);
//             },
//             icon: const Icon(Icons.add, size: 26),
//           ),
//         ],
//       ),
//       body: Container(
//         color: const Color(0xFFF8FAFC),
//         child: Column(
//           children: [
//             // Animated header
//             _buildAnimatedHeader(),
            
//             // Payment cards list with animation
//             Expanded(
//               child: _isLoading
//                   ? _buildLoadingShimmer()
//                   : _buildPaymentMethodsList(),
//             ),
            
//             // Action buttons
//             _buildActionButtons(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//       decoration: const BoxDecoration(
//         color: Color(0xFF1E293B),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: AnimatedOpacity(
//         duration: const Duration(milliseconds: 500),
//         opacity: _isLoading ? 0 : 1,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Your Payment Methods',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Manage your saved payment options',
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.8),
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Animated indicator
//             Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.green[300], size: 16),
//                 const SizedBox(width: 8),
//                 Text(
//                   '${_paymentMethods.length} methods available',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingShimmer() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 4,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: AnimatedOpacity(
//             duration: Duration(milliseconds: 300 + (index * 200)),
//             opacity: 0.7,
//             child: Container(
//               height: 120,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentMethodsList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       physics: const BouncingScrollPhysics(),
//       itemCount: _paymentMethods.length,
//       itemBuilder: (context, index) {
//         final method = _paymentMethods[index];
//         final isSelected = _selectedMethodIndex == index;
        
//         return AnimatedContainer(
//           duration: Duration(milliseconds: 300 + (index * 100)),
//           curve: Curves.easeInOut,
//           margin: EdgeInsets.only(
//             bottom: 16,
//             left: isSelected ? 0 : 8,
//             right: isSelected ? 0 : 8,
//           ),
//           transform: Matrix4.identity()..scale(isSelected ? 1.0 : 0.98),
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedMethodIndex = index;
//               });
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: (method['gradient'] as List<Color>),
//                 ),
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: method['color'].withOpacity(0.4),
//                           blurRadius: 15,
//                           offset: const Offset(0, 5),
//                         ),
//                       ]
//                     : [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 8,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//               ),
//               child: Stack(
//                 children: [
//                   // Card content
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Card header
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Icon(
//                               method['icon'],
//                               color: Colors.white,
//                               size: 32,
//                             ),
//                             AnimatedSwitcher(
//                               duration: const Duration(milliseconds: 300),
//                               child: isSelected
//                                   ? Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 12,
//                                         vertical: 6,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.2),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Icon(
//                                             Icons.check,
//                                             color: Colors.white,
//                                             size: 16,
//                                           ),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             'Selected',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : const SizedBox.shrink(),
//                             ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 24),
                        
//                         // Card number
//                         Text(
//                           method['type'] == 'Visa' || method['type'] == 'Mastercard'
//                               ? '•••• •••• •••• ${method['lastFour']}'
//                               : method['holder'],
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 1.5,
//                           ),
//                         ),
                        
//                         const SizedBox(height: 20),
                        
//                         // Card footer
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'CARD HOLDER',
//                                   style: TextStyle(
//                                     color: Colors.white.withOpacity(0.7),
//                                     fontSize: 10,
//                                     letterSpacing: 1,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   method['holder'].split('@').first,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
                            
//                             if (method['type'] == 'Visa' || method['type'] == 'Mastercard')
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'EXPIRES',
//                                     style: TextStyle(
//                                       color: Colors.white.withOpacity(0.7),
//                                       fontSize: 10,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     method['expiry'],
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 10),
                        
//                         // Card type
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Text(
//                             method['type'],
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Delete button (only on selected card)
//                   if (isSelected)
//                     Positioned(
//                       top: 10,
//                       right: 10,
//                       child: GestureDetector(
//                         onTap: () {
//                           _showDeleteConfirmation(context, index);
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           padding: const EdgeInsets.all(6),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.delete_outline,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildActionButtons() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Edit button
//           Expanded(
//             child: AnimatedOpacity(
//               duration: const Duration(milliseconds: 500),
//               opacity: _isLoading ? 0 : 1,
//               child: OutlinedButton(
//                 onPressed: () {
//                   // Edit selected payment method
//                   _showEditDialog(context, _selectedMethodIndex);
//                 },
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   side: BorderSide(color: Colors.grey[300]!),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Edit',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
          
//           const SizedBox(width: 16),
          
//           // Use this method button
//           Expanded(
//             child: AnimatedOpacity(
//               duration: const Duration(milliseconds: 500),
//               opacity: _isLoading ? 0 : 1,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Use selected payment method
//                   _showSuccessDialog(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 39, 116, 238),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Use This Method',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddMethodDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Add Payment Method',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Choose a payment method to add:',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
                
//                 // Payment method options
//                 _buildAddMethodOption(
//                   context,
//                   'Credit/Debit Card',
//                   Icons.credit_card,
//                   Colors.blue,
//                 ),
//                 _buildAddMethodOption(
//                   context,
//                   'PayPal',
//                   Icons.payment,
//                   Colors.blue[800]!,
//                 ),
//                 _buildAddMethodOption(
//                   context,
//                   'Apple Pay',
//                   Icons.phone_iphone,
//                   Colors.black,
//                 ),
//                 _buildAddMethodOption(
//                   context,
//                   'Google Pay',
//                   Icons.phone_android,
//                   Colors.purple,
//                 ),
                
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Cancel'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAddMethodOption(
//       BuildContext context, String title, IconData icon, Color color) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//         // Simulate adding a new method with animation
//         setState(() {
//           _paymentMethods.add({
//             'type': title.split('/').first,
//             'lastFour': '4321',
//             'icon': icon,
//             'color': color,
//             'gradient': [color, Color.lerp(color, Colors.white, 0.2)!],
//             'expiry': '12/27',
//             'holder': 'John Doe'
//           });
//           _selectedMethodIndex = _paymentMethods.length - 1;
//         });
        
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('$title added successfully'),
//             backgroundColor: Colors.green,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.grey[50],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey[200]!),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, color: color),
//             ),
//             const SizedBox(width: 16),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const Spacer(),
//             const Icon(Icons.chevron_right, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.red[50],
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.delete_outline,
//                     color: Colors.red[600],
//                     size: 36,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Remove Payment Method?',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'This will remove ${_paymentMethods[index]['type']} ending in ${_paymentMethods[index]['lastFour']} from your payment methods.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Cancel'),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           setState(() {
//                             _paymentMethods.removeAt(index);
//                             if (_selectedMethodIndex >= _paymentMethods.length) {
//                               _selectedMethodIndex = _paymentMethods.length - 1;
//                             }
//                           });
                          
//                           // Show deletion message
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: const Text('Payment method removed'),
//                               backgroundColor: Colors.red,
//                               behavior: SnackBarBehavior.floating,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Remove'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showEditDialog(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: _paymentMethods[index]['color'].withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Icon(
//                         _paymentMethods[index]['icon'],
//                         color: _paymentMethods[index]['color'],
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Text(
//                       'Edit ${_paymentMethods[index]['type']}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'This feature is under development.',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF1E293B),
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Okay'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(32),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 500),
//                   curve: Curves.elasticOut,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.green[50],
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.check_circle,
//                     color: Colors.green[600],
//                     size: 48,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Payment Method Selected!',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   '${_paymentMethods[_selectedMethodIndex]['type']} is now your default payment method.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1E293B),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 16,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text('Continue'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  int _selectedMethodIndex = 0;
  bool _isLoading = true;

  // Aapki App ka Primary Blue
  static const Color primaryBlue = Color(0xFF2B7DE0);
  static const Color bgColor = Color(0xFFF4F7FA);

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'Visa',
      'lastFour': '1234',
      'icon': Icons.credit_card,
      'gradient': [const Color(0xFF2B7DE0), const Color(0xFF5AA2FF)],
      'expiry': '05/25',
      'holder': 'John Doe'
    },
    {
      'type': 'Mastercard',
      'lastFour': '5678',
      'icon': Icons.credit_card,
      'gradient': [const Color(0xFFF79E1B), const Color(0xFFEB001B)],
      'expiry': '11/26',
      'holder': 'John Doe'
    },
    {
      'type': 'PayPal',
      'lastFour': '',
      'icon': Icons.account_balance_wallet_rounded,
      'gradient': [const Color(0xFF003087), const Color(0xFF009CDE)],
      'expiry': '',
      'holder': 'john.doe@email.com'
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Payment Methods', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline, size: 28),
          ),
        ],
      ),
      body: Column(
        children: [
          // Styled Header Section
          _buildHeader(),
          
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator(color: primaryBlue))
              : _buildMethodsList(),
          ),

          // Bottom Action Area
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
      decoration: const BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Payment Option',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text('Choose how you want to pay for your laptop',
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMethodsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      itemCount: _paymentMethods.length,
      itemBuilder: (context, index) {
        final method = _paymentMethods[index];
        final isSelected = _selectedMethodIndex == index;

        return GestureDetector(
          onTap: () => setState(() => _selectedMethodIndex = index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: method['gradient'],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected ? [
                BoxShadow(color: (method['gradient'][0] as Color).withOpacity(0.4), 
                blurRadius: 15, offset: const Offset(0, 8))
              ] : [],
              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(method['icon'], color: Colors.white, size: 35),
                    if (isSelected)
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 12,
                        child: Icon(Icons.check, color: primaryBlue, size: 16),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  method['type'] == 'PayPal' ? method['holder'] : '**** **** **** ${method['lastFour']}',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(method['type'] == 'PayPal' ? 'Account Email' : 'Card Holder',
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                    if (method['expiry'].isNotEmpty)
                      Text('Expiry', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(method['holder'].split('@')[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    Text(method['expiry'],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
        ),
        child: const Text('Confirm & Pay Now', 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
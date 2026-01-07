import 'package:flutter/material.dart';
import 'package:laptop_harbor/pages/Help_Support_Page.dart';
import 'package:laptop_harbor/pages/Setting_page.dart';
import 'package:laptop_harbor/pages/orders_page.dart';
import 'package:laptop_harbor/pages/payment_methods.dart';
import 'package:laptop_harbor/pages/shipping_address.dart';
import 'package:laptop_harbor/pages/wishlist_page.dart';
import 'package:laptop_harbor/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  
  // Controllers for editable fields
  final _nameController = TextEditingController(text: 'Roan Atkinson');
  final _emailController = TextEditingController(text: 'roan.atkinson@example.com');
  final _phoneController = TextEditingController(text: '+92 300 1234567');
  final _addressController = TextEditingController(text: 'Karachi, Pakistan');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveProfile() {
    // Save logic here
    setState(() {
      isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _cancelEdit() {
    // Reset controllers to original values
    _nameController.text = 'Roan Atkinson';
    _emailController.text = 'roan.atkinson@example.com';
    _phoneController.text = '+92 300 1234567';
    _addressController.text = 'Karachi, Pakistan';
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20),
            _buildOrderStats(),
            SizedBox(height: 20),
            _buildProfileDetails(),
            SizedBox(height: 20),
            _buildMenuOptions(),
            SizedBox(height: 20),
            _buildLogoutButton(),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Profile Picture
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.blue[400]!, Colors.indigo[600]!],
                      ),
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'RA',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[700],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16),
              // Name (Editable)
              if (isEditing)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter name',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              else
                Text(
                  _nameController.text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 8),
              Text(
                'Tech Enthusiast',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[100],
                ),
              ),
              SizedBox(height: 20),
              // Edit/Save Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isEditing)
                    ElevatedButton.icon(
                      onPressed: _toggleEdit,
                      icon: Icon(Icons.edit),
                      label: Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue[700],
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    )
                  else ...[
                    ElevatedButton.icon(
                      onPressed: _cancelEdit,
                      icon: Icon(Icons.close),
                      label: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _saveProfile,
                      icon: Icon(Icons.check),
                      label: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderStats() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _buildStatCard('Pending', '2', Icons.schedule, Colors.orange)),
          SizedBox(width: 12),
          Expanded(child: _buildStatCard('Delivered', '8', Icons.check_circle, Colors.green)),
          SizedBox(width: 12),
          Expanded(child: _buildStatCard('Processing', '3', Icons.sync, Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
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
            ),
            Divider(height: 1),
            _buildDetailItem(
              Icons.phone_outlined,
              'Phone',
              _phoneController,
              TextInputType.phone,
            ),
            Divider(height: 1),
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
    TextInputType keyboardType,
  ) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                if (isEditing)
                  TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  )
                else
                  Text(
                    controller.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildMenuItem(Icons.shopping_bag_outlined, 'My Orders', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderPage()));
            }),
             
            Divider(height: 1),
            _buildMenuItem(Icons.favorite_border, 'Wishlist', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistPage()));
            }),
            Divider(height: 1),
            _buildMenuItem(Icons.location_on_outlined, 'Shipping Address', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingAddressPage()));
            }),
            Divider(height: 1),
            _buildMenuItem(Icons.payment_outlined, 'Payment Methods', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodsPage()));
            }),
            Divider(height: 1),
            _buildMenuItem(Icons.settings_outlined, 'Settings', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
            }),
            Divider(height: 1),
            _buildMenuItem(Icons.help_outline, 'Help & Support', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportPage()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.blue[700], size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: const Color.fromARGB(255, 255, 255, 255)),
    );
  }

// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Navigator.pop(context);
                     await AuthService().logout();
                    // Perform logout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        },
        icon: Icon(Icons.logout),
        label: Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 63, 123, 250),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
      ),
    );
  }
}
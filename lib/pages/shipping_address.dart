import 'package:flutter/material.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  // Selected address track karne ke liye variable
  String selectedAddressId = '1';

  static const Color primaryBlue = Color(0xFF2B7DE0);
  static const Color bgColor = Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildAddressCard(
                  id: '1',
                  label: 'Home',
                  address: 'House #123, Block A, North Nazimabad',
                  city: 'Karachi, Pakistan',
                  icon: Icons.home_rounded,
                ),
                _buildAddressCard(
                  id: '2',
                  label: 'Office',
                  address: 'Software Park, 4th Floor, Main Boulevard',
                  city: 'Lahore, Pakistan',
                  icon: Icons.work_rounded,
                ),
                
                // Add New Address Outline Button
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_location_alt_outlined, color: primaryBlue),
                  label: const Text("Add New Address", style: TextStyle(color: primaryBlue)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryBlue),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Continue Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Continue to Payment", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard({
    required String id,
    required String label,
    required String address,
    required String city,
    required IconData icon,
  }) {
    bool isSelected = selectedAddressId == id;

    return GestureDetector(
      onTap: () => setState(() => selectedAddressId = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? primaryBlue : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon with Circle
              CircleAvatar(
                backgroundColor: isSelected ? primaryBlue : Colors.grey.shade100,
                child: Icon(icon, color: isSelected ? Colors.white : Colors.grey),
              ),
              const SizedBox(width: 16),
              
              // Address Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(address, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                    Text(city, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                  ],
                ),
              ),
              
              // Radio Selection
              Radio(
                value: id,
                groupValue: selectedAddressId,
                activeColor: primaryBlue,
                onChanged: (value) {
                  setState(() => selectedAddressId = value.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
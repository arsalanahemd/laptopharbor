import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  // Theme Colors (Aapki App ke color palette ke mutabiq)
  static const Color primaryBlue = Color(0xFF2B7DE0); // Vibrant Blue from your App Bar
  static const Color bgColor = Color(0xFFF4F7FA);    // Soft Grey background
  static const Color darkText = Color(0xFF1E293B);   // Navy for headings

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@laptopharbor.com',
      queryParameters: {'subject': 'Support Request'},
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Help & Support', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: primaryBlue, // Match with Home Page App Bar
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Blue Gradient Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryBlue, Color(0xFF5AA2FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(Icons.contact_support_rounded, size: 60, color: Colors.white),
                  SizedBox(height: 12),
                  Text("How can we help you?", 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Search for topics or contact us", 
                    style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // FAQ Section with consistent Blue accent
            _sectionHeader("Frequently Asked Questions"),
            const SizedBox(height: 12),
            _buildFAQTile("Order Tracking", "Check 'My Orders' for real-time updates."),
            _buildFAQTile("Warranty Policy", "Standard 1-year brand warranty on all laptops."),
            
            const SizedBox(height: 30),

            _sectionHeader("Direct Contact"),
            const SizedBox(height: 12),
            _buildContactCard(
              icon: Icons.alternate_email_rounded,
              title: "Email Support",
              subtitle: "support@laptopharbor.com",
              onTap: _launchEmail,
            ),
            _buildContactCard(
              icon: Icons.chat_outlined,
              title: "WhatsApp Chat",
              subtitle: "Available 24/7 for you",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 20, color: primaryBlue),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkText)),
      ],
    );
  }

  Widget _buildFAQTile(String q, String a) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: ExpansionTile(
        iconColor: primaryBlue,
        collapsedIconColor: primaryBlue,
        title: Text(q, style: const TextStyle(fontWeight: FontWeight.w600, color: darkText)),
        children: [Padding(padding: const EdgeInsets.all(16), child: Text(a))],
      ),
    );
  }

  Widget _buildContactCard({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundColor: primaryBlue.withOpacity(0.1), child: Icon(icon, color: primaryBlue)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
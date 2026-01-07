// import : 'package:flutter/material.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(title: Text('Account Settings')),
          ListTile(title: Text('Notifications')),
          ListTile(title: Text('Privacy & Security')),
        ],
      ),
    );
  }
}

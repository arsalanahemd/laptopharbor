// lib/services/user_service.dart

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null;

  /// Get user stream
  Stream<User?> get userStream => _auth.authStateChanges();

  /// Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      
      if (doc.exists) {
        return {
          'uid': user.uid,
          'name': doc.data()?['name'] ?? user.displayName ?? 'User',
          'email': user.email ?? '',
          'phone': doc.data()?['phone'] ?? '',
          'address': doc.data()?['address'] ?? '',
          'profilePicture': doc.data()?['profilePicture'],
        };
      }

      // Return basic info from Firebase Auth if Firestore doc doesn't exist
      return {
        'uid': user.uid,
        'name': user.displayName ?? 'User',
        'email': user.email ?? '',
        'phone': '',
        'address': '',
        'profilePicture': null,
      };
    } catch (e) {
      print('❌ Error getting user data: $e');
      return null;
    }
  }

  /// Create or update user profile
  Future<bool> updateUserProfile({
    required String name,
    String? phone,
    String? address,
    String? profilePicture,
  }) async {
    try {
      final user = currentUser;
      if (user == null) return false;

      // Update Firebase Auth display name
      await user.updateDisplayName(name);

      // Update Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': user.email,
        'phone': phone,
        'address': address,
        'profilePicture': profilePicture,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('❌ Error updating user profile: $e');
      return false;
    }
  }

  /// Get user initials
  String getUserInitials(String name) {
    if (name.isEmpty) return 'U';
    
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  /// Stream user data
  Stream<DocumentSnapshot> getUserDataStream() {
    final user = currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    
    return _firestore.collection('users').doc(user.uid).snapshots();
  }

  /// Check if profile is complete
  Future<bool> isProfileComplete() async {
    try {
      final userData = await getUserData();
      if (userData == null) return false;

      return userData['name']?.isNotEmpty == true &&
             userData['email']?.isNotEmpty == true &&
             userData['phone']?.isNotEmpty == true;
    } catch (e) {
      return false;
    }
  }
}
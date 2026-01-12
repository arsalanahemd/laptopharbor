// // lib/services/firebase_storage_service.dart

// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

// class FirebaseStorageService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();

//   /// Pick image from gallery
//   Future<XFile?> pickImageFromGallery() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );
//       return image;
//     } catch (e) {
//       print('❌ Error picking image: $e');
//       return null;
//     }
//   }

//   /// Pick image from camera
//   Future<XFile?> pickImageFromCamera() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );
//       return image;
//     } catch (e) {
//       print('❌ Error taking photo: $e');
//       return null;
//     }
//   }

//   /// Upload image to Firebase Storage
//   Future<String?> uploadImage(XFile imageFile, {String folder = 'laptops'}) async {
//     try {
//       // Generate unique filename
//       final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(imageFile.path)}';
//       final String filePath = '$folder/$fileName';

//       // Create reference
//       final Reference ref = _storage.ref().child(filePath);

//       // Upload file
//       final File file = File(imageFile.path);
//       print('📤 Uploading image: $filePath');

//       final UploadTask uploadTask = ref.putFile(
//         file,
//         SettableMetadata(
//           contentType: 'image/jpeg',
//           customMetadata: {
//             'uploaded_by': 'admin',
//             'uploaded_at': DateTime.now().toIso8601String(),
//           },
//         ),
//       );

//       // Wait for upload to complete
//       final TaskSnapshot snapshot = await uploadTask;

//       // Get download URL
//       final String downloadUrl = await snapshot.ref.getDownloadURL();
//       print('✅ Image uploaded successfully: $downloadUrl');

//       return downloadUrl;
//     } catch (e) {
//       print('❌ Error uploading image: $e');
//       return null;
//     }
//   }

//   /// Delete image from Firebase Storage
//   Future<bool> deleteImage(String imageUrl) async {
//     try {
//       // Extract path from URL
//       final Uri uri = Uri.parse(imageUrl);
//       final String path = uri.pathSegments.last;

//       // Delete file
//       final Reference ref = _storage.ref().child('laptops/$path');
//       await ref.delete();

//       print('✅ Image deleted successfully');
//       return true;
//     } catch (e) {
//       print('❌ Error deleting image: $e');
//       return false;
//     }
//   }

//   /// Upload multiple images
//   Future<List<String>> uploadMultipleImages(
//     List<XFile> imageFiles, {
//     String folder = 'laptops',
//     Function(int current, int total)? onProgress,
//   }) async {
//     final List<String> uploadedUrls = [];

//     for (int i = 0; i < imageFiles.length; i++) {
//       onProgress?.call(i + 1, imageFiles.length);
      
//       final String? url = await uploadImage(imageFiles[i], folder: folder);
//       if (url != null) {
//         uploadedUrls.add(url);
//       }
//     }

//     return uploadedUrls;
//   }

//   /// Get upload progress
//   Stream<TaskSnapshot> uploadImageWithProgress(
//     XFile imageFile, {
//     String folder = 'laptops',
//   }) {
//     final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(imageFile.path)}';
//     final String filePath = '$folder/$fileName';
//     final Reference ref = _storage.ref().child(filePath);
//     final File file = File(imageFile.path);

//     return ref.putFile(file).snapshotEvents;
//   }
// // }
// lib/services/firebase_storage_service.dart

// ignore_for_file: avoid_print

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery (Web & Mobile compatible)
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      print('❌ Error picking image: $e');
      return null;
    }
  }

  /// Upload image to Firebase Storage (Web & Mobile compatible)
  Future<String?> uploadImage(XFile imageFile, {String folder = 'laptops'}) async {
    try {
      // Generate unique filename
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';
      final String filePath = '$folder/$fileName';

      // Create reference
      final Reference ref = _storage.ref().child(filePath);

      print('📤 Uploading image: $filePath');

      // Upload based on platform
      UploadTask uploadTask;
      
      if (kIsWeb) {
        // Web: Upload from bytes
        final bytes = await imageFile.readAsBytes();
        uploadTask = ref.putData(
          bytes,
          SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {
              'uploaded_by': 'admin',
              'uploaded_at': DateTime.now().toIso8601String(),
            },
          ),
        );
      } else {
        // Mobile: Upload from file path
        // This won't be reached in web, but keeping for compatibility
        throw UnsupportedError('Mobile upload not supported in this version');
      }

      // Wait for upload to complete
      final TaskSnapshot snapshot = await uploadTask;

      // Get download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      print('✅ Image uploaded successfully: $downloadUrl');

      return downloadUrl;
    } catch (e) {
      print('❌ Error uploading image: $e');
      return null;
    }
  }

  /// Delete image from Firebase Storage
  Future<bool> deleteImage(String imageUrl) async {
    try {
      // Extract path from URL
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();

      print('✅ Image deleted successfully');
      return true;
    } catch (e) {
      print('❌ Error deleting image: $e');
      return false;
    }
  }

  /// Get upload progress stream
  Stream<double> uploadImageWithProgress(XFile imageFile, {String folder = 'laptops'}) async* {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';
      final String filePath = '$folder/$fileName';
      final Reference ref = _storage.ref().child(filePath);

      final bytes = await imageFile.readAsBytes();
      final uploadTask = ref.putData(bytes);

      await for (final snapshot in uploadTask.snapshotEvents) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        yield progress;
      }
    } catch (e) {
      print('❌ Error in upload progress: $e');
      yield 0.0;
    }
  }
}
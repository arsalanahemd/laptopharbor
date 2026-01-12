// import 'package:flutter/material.dart';
// import '../../data/laptop_data.dart';
// import '../../services/firestore_service.dart';

// class UploadDataScreen extends StatelessWidget {
//   UploadDataScreen({super.key});

//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Upload Laptop Data")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final success = await _firestoreService.uploadFromLocalFile(laptopData);

//             if (success) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("🔥 All laptops uploaded to Firebase")),
//               );
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("❌ Upload failed")),
//               );
//             }
//           },
//           child: const Text("Upload to Firebase"),
//         ),
//       ),
//     );
//   }
// }

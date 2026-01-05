// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // REGISTER
//   Future<User?> registerWithEmail(
//       String email, String password) async {
//     try {
//       UserCredential result =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return result.user;
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   // LOGIN
//   Future<User?> loginWithEmail(
//       String email, String password) async {
//     try {
//       UserCredential result =
//           await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return result.user;
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   // LOGOUT
//   Future<void> logout() async {
//     await _auth.signOut();
//   }

//   Future login(String trim, String trim2) async {}

//   Future register(String trim, String trim2) async {}
// }
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      throw _errorMessage(e.code);
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      throw _errorMessage(e.code);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  String _errorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password must be at least 6 characters';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      default:
        return 'Authentication error';
    }
  }
}

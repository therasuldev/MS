// import 'package:firebase_auth/firebase_auth.dart';

// class UserService {
//   final FirebaseAuth _firebaseAuth;

//   UserService() : _firebaseAuth = FirebaseAuth.instance;

//   Future<void> signInWithCredentials(
//       {required String email, required String password}) {
//     return _firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   Future<UserCredential> signUp({
//     required String email,
//     required String password,
//   }) async {
//     return await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   Future<List<void>> signOut() async {
//     return Future.wait([_firebaseAuth.signOut()]);
//   }

//   Future<bool> isSignedIn() async {
//     final currentUser = _firebaseAuth.currentUser;
//     return currentUser != null;
//   }

//   Future<User?> getUser() async {
//     return _firebaseAuth.currentUser;
//   }
// }

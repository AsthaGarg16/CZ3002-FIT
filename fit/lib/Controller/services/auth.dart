// import 'package:fit/Controller/services/database.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../Entity/FitUser.dart';
//
//
// class AuthService {
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User _userFromFirebaseUser(User user) {
//     return user != null ? User(Email: User.email) : null;
//   }
//
//   // auth change user stream
//   Stream<User> get user {
//     return _auth.authStateChanges()
//     //.map((FirebaseUser user) => _userFromFirebaseUser(user));
//         .map(_userFromFirebaseUser);
//   }
//
//   Future registerWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User user = result.user;
//
//       //Create a new document for user with uid
//       await DatabaseService(uid: user.uid).updateUserData()
//       return _userFromFirebaseUser(user);
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }
//
//   // sign out
//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }
//
// }

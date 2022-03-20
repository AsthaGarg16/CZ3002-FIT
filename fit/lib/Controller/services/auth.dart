import 'package:fit/Controller/services/UserController.dart';
import 'package:fit/Controller/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UserController.dart';
import 'dart:io';
import '../../Entity/FitUser.dart';


class AuthService {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');

      }
      return false;
    } catch (e) {
      print('hello');
      print(e);
    }

    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
      await UserController.retrieveDetails(email);
      await UserController.setData();
      // print("something");
      // await UserController.readUserDetails(email);
      // print("blabla");
      // int fridgeDetails = UserController.userDetails.fridgeDetails;
      // bool vegan = UserController.userDetails.vegan;
      // bool vegetarian = UserController.userDetails.vegetarian;
      // bool dairyFree = UserController.userDetails.dairyFree;
      // bool glutenFree = UserController.userDetails.glutenFree;
      // print("fridgeDetails: $fridgeDetails");
      // print("Vegan: $vegan");
      // print("vegetarian: $vegetarian");
      // print("dairyFree: $dairyFree");
      // print("glutenFree: $glutenFree");
      print("login success");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future <String> getUser() async {
    return _auth.currentUser!.email!;
  }

// User _userFromFirebaseUser(User user) {
//   return user != null ? User(Email: User.email) : null;
// }
//
// // auth change user stream
// Stream<User> get user {
//   return _auth.authStateChanges()
//   //.map((FirebaseUser user) => _userFromFirebaseUser(user));
//       .map(_userFromFirebaseUser);
// }
//
// Future registerWithEmailAndPassword(String email, String password) async {
//   try {
//     UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     User user = result.user;
//
//     //Create a new document for user with uid
//     await DatabaseService(uid: user.uid).updateUserData()
//     return _userFromFirebaseUser(user);
//   } catch (error) {
//     print(error.toString());
//     return null;
//   }
// }
//


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Entity/FitUser.dart';

import '../../Entity/FitUser.dart';

class UserController{
  static final _firestore = FirebaseFirestore.instance;

  /// A firebase authentication instance to validate user login
  static final _auth = FirebaseAuth.instance;

  static CollectionReference fit = FirebaseFirestore.instance.collection('fit');

  /// A static User Account variable for details of logged in user
  static FitUser? user;

  static Future<void> addUseronSignup(
      String email, String name, int fridgeDetails, bool dairyFree, bool glutenFree, bool vegetarian, bool vegan) async {
    user = new FitUser(
        email: email,
        name: name,
        fridgeDetails: fridgeDetails,
        dairyFree: dairyFree,
        glutenFree: glutenFree,
        vegetarian: vegetarian,
        vegan: vegan );
    await fit
        .doc(email)
        .set({
      'email': email,
      'name': name,
      'fridgeDetails': fridgeDetails,
      'dairyFree': dairyFree,
      'glutenFree': glutenFree,
      'vegetarian': vegetarian,
      'vegan': vegan,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add  new user: $error"));
  }
  static Future<void> retrieveDetails(String email) async {
    print(email);
    await FirebaseFirestore.instance
        .collection('fit')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data());
        UserController.user = new FitUser(
            email: documentSnapshot['Email'],
            name: documentSnapshot['name'],
            fridgeDetails: documentSnapshot['fridgeDetails'],
            dairyFree: documentSnapshot['dairyFree'],
            glutenFree: documentSnapshot['glutenFree'],
            vegetarian: documentSnapshot['vegetarian'],
            vegan: documentSnapshot['vegan'] );
      } else {
        print('Document does not exist on the database');
      }
    });

    print(getProfileDetails());
  }

  //to get all profile details for the profile page
  /// Retrieves the user's profile details
  static Map<String, dynamic> getProfileDetails() {
    Map<String, dynamic> profileDetails = {
      'email': user?.email,
      'name': user?.name,
      'fridgeDetails': user?.fridgeDetails,
      'dairyFree': user?.dairyFree,
      'glutenFree': user?.glutenFree,
      'vegetarian': user?.vegetarian,
      'vegan': user?.vegan
    };
    return profileDetails;
  }

  /// Gets the user's emailID
  static String? getCurrentUserEmail() {
    return user?.email;
  }

  // static readUserDetails(String email) async {
  //   // FitUser userDetails = new FitUser();
  //
  //   await for (var snapshot in _firestore
  //       .collection('fit')
  //       .where('Email', isEqualTo: email)
  //       .snapshots()) {
  //     var documents = snapshot.docs;
  //     if (documents.isNotEmpty) {
  //       //print(docs.length);
  //       for (var Documents in documents) {
  //         if (Documents.id == email) {
  //           print('y');
  //           print('Hello There!');
  //           print('Doc id' + Documents.id);
  //           userDetails.vegan = Documents['Vegan'];
  //           userDetails.email = email;
  //           userDetails.vegetarian = Documents['Vegetarian'];
  //           userDetails.dairyFree = Documents['dairyFree'];
  //           userDetails.fridgeDetails = Documents['fridgeDetails'];
  //           userDetails.glutenFree = Documents['glutenFree'];
  //         }
  //       }
  //     }
  //   }
  // }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Entity/FitUser.dart';

import '../../Entity/FitUser.dart';

class UserController{
  static final _firestore = FirebaseFirestore.instance;

  /// A firebase authentication instance to validate user login
  static final _auth = FirebaseAuth.instance;

  /// A static User Account variable for details of logged in user
  static FitUser userDetails = new FitUser() ;

  static readUserDetails(String email) async {
    // FitUser userDetails = new FitUser();

    await for (var snapshot in _firestore
        .collection('fit')
        .where('Email', isEqualTo: email)
        .snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        //print(docs.length);
        for (var Documents in documents) {
          if (Documents.id == email) {
            print('y');
            print('Hello There!');
            print('Doc id' + Documents.id);
            userDetails.vegan = Documents['Vegan'];
            userDetails.email = email;
            userDetails.vegetarian = Documents['Vegetarian'];
            userDetails.dairyFree = Documents['dairyFree'];
            userDetails.fridgeDetails = Documents['fridgeDetails'];
            userDetails.glutenFree = Documents['glutenFree'];
          }
        }
      }
    }
  }
}
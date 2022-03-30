import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Entity/FoodWasteList.dart';

import '../../Entity/FoodWasteList.dart';
import '../../Entity/FoodWasteRecord.dart';
import 'UserController.dart';

class FoodWastageController{
  static Future<void> addFoodWasteRecord(
      String email,
      String name,
      int quantity,
      String unit,
      String thrownDate,){
    // String email = UserManager.getCurrentUserEmail();
    // UserManager.addGlucoseRecord(
    //   GlucoseRecord(
    //     dateTime: dateTime,
    //     glucoseLevel: glucoseLevel,
    //     beforeMeal: beforeMeal,
    //   ),
    // );

    UserController.addFoodWasteRecord(name, quantity, unit, thrownDate);
    return FirebaseFirestore.instance
        .collection('FoodWaste')
        .doc(email)
        .collection('WasteRecords')
        .add({
      'name': name,
      'quantity': quantity,
      'thrownDate': thrownDate,
      'unit':unit,

    })
        .then((value) => print('Food Waste Record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  static Future<FoodWasteList> getFoodWasteList(String email) async {
    List<FoodWasteRecord> recordsList = [];

    await FirebaseFirestore.instance
        .collection('FoodWaste')
        .doc(email)
        .collection('WasteRecords')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) async {
        recordsList.add(
          FoodWasteRecord(
            doc['name'],
            doc['quantity'],
            doc['unit'],
            doc['thrownDate']
          ),
        );
      })
    })
        .catchError((error) => print('Failed to get inventory: $error'));

    print("fooditems");
    for(FoodWasteRecord r in recordsList)
    {
      print("name"+ r.name+ "quan"+ r.quantity.toString()+ "thrownDate"+ r.thrownDate);
    }


    return new FoodWasteList(
      recordsList
    );
  }
}
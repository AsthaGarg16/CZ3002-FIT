import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Entity/Inventory.dart';
import '../../Entity/FoodRecord.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
class InventoryController{

  static CollectionReference foodImages = FirebaseFirestore.instance.collection('FoodImagesTable');
  static Future<String> fetchImageUrl(Map<String, dynamic> request) async {
    request['apiKey'] = '7df62bdc1ad34570b6ab05269bbef6bd';
    print(request);
    final response = await http.get(
      Uri.https('api.spoonacular.com', 'food/ingredients/search', request),
    );
    print("Status code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var res=json.decode(response.body)['results'];
      print(res);

      String imageUrl="https://spoonacular.com/cdn/ingredients_100x100/"+ res[0]["image"].toString();

      //add code to add the id and url in firebase
      return imageUrl;
    } else {
      //throw Exception('Failed to load recipe info');
      print("Ingredient does not exist in spoonacular");
      return " ";
    }
  }

  static Future<String> checkFoodImageCache(String name) async{

    String url="before assigned ";
   print(name);
   await foodImages
       .doc(name)
       .get()
       .then((DocumentSnapshot documentSnapshot) {
     if (documentSnapshot.exists) {
       print(documentSnapshot["ImageUrl"]);
       url=documentSnapshot["ImageUrl"];
       //return documentSnapshot.get("ImageUrl");

     }
   })
       .catchError((error) => print('Failed to get food cache: $error'));;
   return url;

 }

  static Future<void> addFoodRecord(
      String email,
      String name,
      int quantity,
      String unit,
      DateTime expiryDate,
      String imageUrl,
      int compNum){
    // String email = UserManager.getCurrentUserEmail();
    // UserManager.addGlucoseRecord(
    //   GlucoseRecord(
    //     dateTime: dateTime,
    //     glucoseLevel: glucoseLevel,
    //     beforeMeal: beforeMeal,
    //   ),
    // );
    return FirebaseFirestore.instance
        .collection('Inventory')
        .doc(email)
        .collection('FoodItems')
        .add({
      'name': name,
      'quantity': quantity,
      'expiryDate': expiryDate,
      'unit':unit,
      'imageUrl':imageUrl,
      'compNum':compNum
    })
        .then((value) => print('Food Record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  static Future<Inventory> getInventory(String email) async {
    List<FoodRecord> recordsList = [];

    await FirebaseFirestore.instance
        .collection('Inventory')
        .doc(email)
        .collection('FoodItems')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) async {
        recordsList.add(
          FoodRecord(
            doc['name'],
            doc['quantity'],
            doc['unit'],
            DateTime.fromMicrosecondsSinceEpoch(
          doc['expiryDate'].microsecondsSinceEpoch,
          ),
            doc['compNum'],
            doc['imageUrl'],
          ),
        );
      })
    })
        .catchError((error) => print('Failed to get inventory: $error'));

    print("fooditems");
    for(FoodRecord r in recordsList)
      {
        print("name"+ r.name+ "quan"+ r.expiryDate.toString());
      }


    return new Inventory(
     recordsList,
    );
  }

  // static Future<void> deleteFoodRecord(String email,String name, DateTime expiryDate) {
  //   //Query fooditemdel_query = FirebaseFirestore.instance.collection('Inventory').doc(email).collection("FoodItems").where("name",isNotEqualTo: false);
  //
  // }

  static Future<void> createFoodRecord (
      String email,
      String name,
      int quantity,
      String unit,
      DateTime expiryDate,
      String imageUrlQuery,
      int compNum) async{
    Map<String, dynamic> request = {
        "query": imageUrlQuery,
        "number": "1"
      };

    String imgUrl=await fetchImageUrl(request);
    await addFoodRecord(email,name,quantity,unit,expiryDate,imgUrl,compNum);

  }

  static Future<void> updateFoodRecord (
      String email,
      String name,
      int quantity,
      String unit,
      DateTime expiryDate,
      int compNum) async{

    await FirebaseFirestore.instance
        .collection('Inventory')
        .doc(email)
        .collection('FoodItems')
        .where("name",isEqualTo: name)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((document) async {
        if(document['expiryDate'].microsecondsSinceEpoch== expiryDate.microsecondsSinceEpoch){
          await FirebaseFirestore.instance
              .collection('Inventory')
              .doc(email)
              .collection('FoodItems')
              .doc(document.id)
              .update({'quantity':quantity,'compNum':compNum})
                  .then((value) => print("Food Record Updated"))
                  .catchError((error) => print("Failed to update user: $error"));
        }

      })
    })
        .catchError((error) => print('Failed to get inventory: $error'));

  }

  static Future<void> deleteFoodRecord (
      String email,
      String name,
      DateTime expiryDate) async{

    await FirebaseFirestore.instance
        .collection('Inventory')
        .doc(email)
        .collection('FoodItems')
        .where("name",isEqualTo: name)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((document) async {
        if(document['expiryDate'].microsecondsSinceEpoch== expiryDate.microsecondsSinceEpoch){
          await FirebaseFirestore.instance
              .collection('Inventory')
              .doc(email)
              .collection('FoodItems')
              .doc(document.id)
              .delete()
              .then((value) => print("Food Record deleted"))
              .catchError((error) => print("Failed to update user: $error"));
        }

      })
    })
        .catchError((error) => print('Failed to get inventory: $error'));

  }
}
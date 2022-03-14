import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Controller/services/UserController.dart';
import 'dart:io';
import '../../Entity/ShoppingList.dart';
import '../../Entity/FoodItem.dart';

class ShoppingListController{
  // static instantiateShoppingList(String email) {
  // FirebaseFirestore.instance.collection('ShoppingList').doc(email).set({});
  // }
  // String? email = UserController.getCurrentUserEmail();

  // static Future<void> addFoodItem(
  // String name,
  // int quantity,
  // String unit,
  // bool status,
  // bool inventory_status,
  // bool from_saved_recipes,
  // int quantity_from_saved,
  // String recipe_ID
  // ) {
  // String? email = UserController.getCurrentUserEmail();
  // UserController.addFoodItem(
  // FoodItem(
  // name: name,
  // quantity: quantity,
  // unit: unit,
  // status: status,
  // inventory_status: inventory_status,
  // from_saved_recipes: from_saved_recipes,
  // quantity_from_saved: quantity_from_saved,
  // recipe_ID: recipe_ID,
  // ),
  // );
  // return FirebaseFirestore.instance
  //     .collection('ShoppingList')
  //     .doc(email)
  //     .collection('FoodItem')
  //     .add({
  // 'name': name,
  // 'quantity': quantity,
  // 'unit': unit,
  // 'status': status,
  // 'inventory_status': inventory_status,
  // 'from_saved_recipes': from_saved_recipes,
  // 'quantity_from_saved': quantity_from_saved,
  // 'recipe_ID': recipe_ID,
  // })
  //     .then((value) => print('Food Item added!'))
  //     .catchError((error) => print('Failed to add record: $error'));
  // }

    static Future<void> addFoodItem(
    String email,
    String name,
    int quantity,
    String unit,
    bool status,
    bool inventory_status,
    bool from_saved_recipes,
    int quantity_from_saved,
    String recipe_ID){
  return FirebaseFirestore.instance
      .collection('ShoppingList')
      .doc(email)
      .collection('FoodItem')
      .add({
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'status': status,
      'inventory_status': inventory_status,
      'from_saved_recipes': from_saved_recipes,
      'quantity_from_saved': quantity_from_saved,
      'recipe_ID': recipe_ID,
  })
      .then((value) => print('Food Item added!'))
      .catchError((error) => print('Failed to add Item: $error'));
  }

  /// Retrieves the Data of the Shopping List
  // static Future<ShoppingList> getShoppingList(String email) async {
  // List<FoodItem> ItemList = [];
  //
  // await FirebaseFirestore.instance
  //     .collection('ShoppingList')
  //     .doc(email)
  //     .collection('FoodItem')
  //     .get()
  //     .then((QuerySnapshot querySnapshot) => {
  // querySnapshot.docs.forEach((doc) async {
  // ItemList.add(
  // FoodItem(
  // name: doc['name'],
  // quantity: doc['quantity'],
  // unit: doc['unit'],
  // status: doc['status'],
  // inventory_status: doc['inventory_status'],
  // from_saved_recipes: doc['from_saved_recipes'],
  // quantity_from_saved: doc['quantity_from_saved'] ,
  // recipe_ID: doc['recipe_ID'],
  // ),
  // );
  // })
  // })
  //     .catchError((error) => print('Failed to get shopping list: $error'));
  //
  // print("shoppingList:");
  // ItemList.forEach((record) {
  // print(record.name);
  // });
  // return new ShoppingList(
  // email: email,
  // FoodItemslist: ItemList,
  // );
  // }

  static Future<ShoppingList> getShoppingList(String email) async {
  List<FoodItem> ItemList = [];

  await FirebaseFirestore.instance
      .collection('ShoppingList')
      .doc(email)
      .collection('FoodItem')
      .get()
      .then((QuerySnapshot querySnapshot) => {
  querySnapshot.docs.forEach((doc) async {
  ItemList.add(
  FoodItem(
  doc['name'],
  doc['quantity'],
  doc['unit'],
  doc['status'],
  doc['inventory_status'],
  doc['from_saved_recipes'],
  doc['quantity_from_saved'] ,
  doc['recipe_ID'],
  ),
  );
  })
  })
      .catchError((error) => print('Failed to get inventory: $error'));

  print("fooditems");
  for(FoodItem r in ItemList)
  {
  print("name"+ r.name+ "quan"+ r.quantity.toString());
  }

  return new ShoppingList(
  ItemList,
  );
  }



static Future<void> updateFoodItem (
  String email,
  String name,
  int quantity,
  String unit,
  bool status,
  bool inventory_status,
  bool from_saved_recipes,
  int quantity_from_saved,
  String recipe_ID,
  int compNum) async{

  await FirebaseFirestore.instance
      .collection('ShoppingList')
      .doc(email)
      .collection('FoodItem')
      .where("name",isEqualTo: name)
      .get()
      .then((QuerySnapshot querySnapshot) => {
  querySnapshot.docs.forEach((document) async {
  if(document['recipe_ID'] == recipe_ID){
  await FirebaseFirestore.instance
      .collection('ShoppingList')
      .doc(email)
      .collection('FoodItem')
      .doc(document.id)
      .update({'quantity':quantity,'status':status,'inventory_status':inventory_status})
      .then((value) => print("Food Item Updated"))
      .catchError((error) => print("Failed to update user: $error"));
  }

  })
  })
      .catchError((error) => print('Failed to get shopping List: $error'));

  }


  static Future<void> deleteFoodItem (
  String email,
  String name,
  String recipe_ID) async{

  await FirebaseFirestore.instance
      .collection('ShoppingList')
      .doc(email)
      .collection('FoodItem')
      .where("name",isEqualTo: name)
      .get()
      .then((QuerySnapshot querySnapshot) => {
  querySnapshot.docs.forEach((document) async {
  if(document['recipe_ID']== recipe_ID){
  await FirebaseFirestore.instance
      .collection('ShoppingList')
      .doc(email)
      .collection('FoodItem')
      .doc(document.id)
      .delete()
      .then((value) => print("Food Item deleted"))
      .catchError((error) => print("Failed to update user: $error"));
  }

  })
  })
      .catchError((error) => print('Failed to get shopping list: $error'));

  }
}
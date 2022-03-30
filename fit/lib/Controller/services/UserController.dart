import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Controller/services/InventoryController.dart';
import 'package:fit/Controller/services/ShoppingListController.dart';
import 'package:fit/Controller/services/FoodWastageController.dart';
import 'package:fit/Entity/FitUser.dart';
import 'package:fit/Entity/FoodRecord.dart';
import 'package:fit/Entity/FoodWasteRecord.dart';
import 'package:fit/Entity/FoodWasteList.dart';
import 'package:fit/Entity/Inventory.dart';
import 'package:fit/Entity/ShoppingList.dart';
import 'package:fit/Entity/FoodItem.dart';

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

    // instantiateCollecOnSignup(email);
  }

  //to make entry to other tables with new email
  static instantiateCollecOnSignup(String email) {
    FirebaseFirestore.instance.collection('Inventory').doc(email).set({});
    FirebaseFirestore.instance.collection('ShoppingList').doc(email).set({});
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
            email: documentSnapshot['email'],
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
  static String getCurrentUserEmail() {
    return user!.email;
  }

  //setting user data on login
  static Future<void> setData() async {
    await setUserInventory();
    await setShoppingList();
    await setFoodWasteList();

  }

  /// Sets the user inventory
  static Future<void> setUserInventory() async {
    await InventoryController.getInventory(user!.email).then((userInventory) => {
      if (userInventory != null)
        user!.inv = userInventory
      else
        user!.inv = Inventory(<FoodRecord>[])
    });
  }

  static Future<void> setShoppingList() async {
    await ShoppingListController.getShoppingList(user!.email).then((userShoppingList) => {
      if (userShoppingList != null)
        user!.shop = userShoppingList
      else
        user!.shop = ShoppingList(<FoodItem>[])
    });
  }

  static Future<void> setFoodWasteList() async {
    await FoodWastageController.getFoodWasteList(user!.email).then((userWasteList) => {
      if (userWasteList != null)
        user!.foodWasteList = userWasteList
      else
        user!.foodWasteList = FoodWasteList(<FoodWasteRecord>[])
    });
  }

  static void addShoppingListItem(String name, int quantity, String unit, bool status, bool inventory_status,bool from_saved_recipes,int quantity_from_saved,String recipe_ID){
    user?.shop?.addRecord(name, quantity, unit, status, inventory_status, from_saved_recipes,quantity_from_saved,recipe_ID);
  }

  static void deleteShoppingListItem(String name, String recipe_ID){
    user?.shop?.deleteRecord(name, recipe_ID);
  }

  static void updateShoppingListItem(String name, int quantity, String unit, bool status, bool inventory_status,bool from_saved_recipes,int quantity_from_saved,String recipe_ID){
    user?.shop?.updateRecord(name, quantity, unit, status, inventory_status,from_saved_recipes,quantity_from_saved,recipe_ID);
  }


  static void addInventoryRecord(String name, int quantity, String unit, DateTime expiryDate, int compNumber, String imageUrl){
    user?.inv?.addRecord(name, quantity, unit, expiryDate, compNumber, imageUrl);
  }

  static void deleteInventoryRecord(String name, DateTime expiryDate){
    user?.inv?.deleteRecord(name, expiryDate);
  }

  static void updateInventoryRecord(String name, int quantity, String unit, int compNumber,DateTime expiryDate){
    user?.inv?.updateRecord(name, quantity, unit, expiryDate, compNumber);
  }

  static void addFoodWasteRecord(String name, int quantity, String unit, String thrownDate){
    user?.foodWasteList?.addRecord(name, quantity, unit, thrownDate);
  }
}
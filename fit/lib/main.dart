import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Controller/services/database.dart';
import 'package:flutter/material.dart';
import 'Controller/services/InventoryController.dart';
import 'Controller/services/ShoppingListController.dart';
import 'Controller/services/RecipeController.dart';
import '../../Entity/Inventory.dart';
import '../../Entity/FoodRecord.dart';
import '../../Entity/ShoppingList.dart';
import '../../Entity/FoodItem.dart';
import 'UI/EntryPage.dart';
import 'UI/RecipePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService databaseService = new DatabaseService();

  // Testing out databaseService.writeNewDocument() function
  // Map <String, dynamic> testing = {"testing": "123"};
  // CollectionReference collectionReference = firestore.collection("fit");
  // databaseService.writeNewDocument(collectionReference, testing);

  // Testing out databaseService.updateDocument() function
  // String email = "123456@gmail.com";
  // Map <String, dynamic> user = {"dairyFree": false,
  //                               "email": email,
  //                               "fridgeDetails": 3,
  //                               "glutenFree": false,
  //                               "name": "123456",
  //                               "vegan": false,
  //                               "vegetarian": true};
  // DocumentReference documentReference = firestore.collection("fit").doc(email);
  // databaseService.updateDocument(documentReference, user, false);

  // Testing out all of databaseService read/get functions
  // databaseService.getDocument(documentReference);
  // databaseService.getCollection(collectionReference);
  // databaseService.getField(documentReference, ["name"]);

  // Spoonacular InventoryController Testing
  // Map<String, dynamic> request = {
  //   "query": "Apple",
  //   "number": "1"
  // };
  // InventoryController ic= InventoryController();
  // String img=await InventoryController.checkFoodImageCache("apple");
  // print(img);
  // Inventory inv =await InventoryController.getInventory("nisha.rmanian@gmail.com");
  // for(FoodRecord r in inv.inventoryItems)
  // {
  //   print("name"+ r.name+ "quan"+ r.expiryDate.toString());
  // }
  // InventoryController.addFoodRecord("nisha.rmanian@gmail.com","apple",2,"",DateTime(2021,3,29),"https://spoonacular.com/cdn/ingredients_100x100/apple.jpg",1);
  // InventoryController.createFoodRecord("nisha.rmanian@gmail.com","banana",2,"",DateTime(2021,3,29),"banana",1);
  // InventoryController.deleteFoodRecord("nisha.rmanian@gmail.com","banana",DateTime(2021,3,31));
  // String imgUrl=await InventoryController.fetchImageUrl(request);
  // print(imgUrl);

// ShoppingListController Testing
//   ShoppingListController sc= ShoppingListController();
//   ShoppingList shop =await ShoppingListController.getShoppingList("nisha.rmanian@gmail.com");
//   for(FoodItem r in shop.FoodItemList)
//   {
//     print("name: "+ r.name+ " ,quan: "+ r.quantity.toString());
//   }
//   ShoppingListController.addFoodItem("someemail@email.com","milk",5,"",true,false,false,0,"0");
//   ShoppingListController.addFoodItem("someemail@email.com","orange",7,"",false,true,false,0,"0");
//   ShoppingListController.addFoodItem("someemail@email.com","apple",2,"",true,false,false,0,"0");
//   ShoppingListController.updateFoodItem("someemail@email.com","milk",3,"l",true,false,false,0,"0");
//   ShoppingListController.addFoodItem("someemail@email.com","banana",3,"count",false,false,false,0,"0");
//   ShoppingListController.addFoodItem("someemail@email.com","orange",70,"g",true,true,false,0,"0");
//   ShoppingListController.updateFoodItem("someemail@email.com","apple",3,"count",false,false,false,0,"0");
//
//   ShoppingListController.deleteFoodItem("trial2@email.com","banana","R1");

  // Spoonacular RecipeController Testing
  // RecipeController rc= RecipeController();
  // List<int> recipeIDs = await rc.fetchRecipeIDs("pasta,tuna,apple,chicken", "3");
  // print(recipeIDs);
  //
  // for(int i=0; i<recipeIDs.length; i++){
    // Map<String, dynamic> recipeInfo = await rc.fetchRecipeInfo(recipeIDs[i]);
    // print(recipeInfo);
    // List<String> recipeInstructions = await rc.fetchRecipeInstructions(recipeIDs[i]);
    // print(recipeInstructions);
    // rc.storeInFirestore(recipeInfo, recipeInstructions);
  // }
  // var recipeList = <Map<String, dynamic>> [];
  // List<int> recipeIDs = await rc.getSavedRecipesIDs("123456@gmail.com");
  // print(recipeIDs);
  // for (int i = 0; i < recipeIDs.length; i++) {
  //   Map<String, dynamic> recipeInfo = await rc.getSavedRecipeDisplayInfo("123456@gmail.com", recipeIDs[i]);
  //   recipeList.add(recipeInfo);
  // }
  // print(recipeList);
  // List<int> recipeIDs = await rc.searchRecipes("tuna pasta", "3");
  // print(recipeIDs);
  // var recipeList = <Map<String, dynamic>> [];
  // for(int i=0; i<recipeIDs.length; i++){
  //   Map<String, dynamic> recipeInfo = await rc.fetchDisplayRecipeInfo(recipeIDs[i]);
  //   recipeList.add(recipeInfo);
  // }
  // print(recipeList);

  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'FIT',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal[800],
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0),
          headline2: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 2.0),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              letterSpacing: 2.0),
          subtitle1: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5),
          subtitle2: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.5),
          labelMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.5),
          bodyText1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87),
          bodyText2: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        fontFamily: "mw",
      ),
      home: EntryPage(title: 'FIT'),
    );
  }
}

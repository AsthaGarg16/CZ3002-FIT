import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Controller/services/database.dart';
import 'package:flutter/cupertino.dart';
import '../../Entity/Preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeController {
  String url = 'api.spoonacular.com';
  String apiKey = '7df62bdc1ad34570b6ab05269bbef6bd';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService databaseService = new DatabaseService();

  RecipeController();

  Future<List<int>> fetchRecipeIDs(
      String includeIngredients, String number, Preferences preferences) async {
    Map<String, dynamic> request = {
      "includeIngredients": includeIngredients,
      "number": number,
      "sort": "max-used-ingredients",
      "sortDirection": "desc",
      "apiKey": apiKey
    };

    if (preferences.vegan && preferences.vegetarian) {
      request["diet"] = "vegan";
      print("I am vegan and vegetarian");
    } else if (preferences.vegetarian) {
      request["diet"] = "vegetarian";
      print("I am vegetarian");
    } else if (preferences.vegan) {
      request["diet"] = "vegan";
      print("I am vegan");
    }

    if (preferences.dairyFree && preferences.glutenFree) {
      request["intolerances"] = "dairy,gluten";
      print("I am dairy and gluten free");
    } else if (preferences.dairyFree) {
      request["intolerances"] = "dairy";
      print("I am dairy free");
    } else if (preferences.glutenFree) {
      request["intolerances"] = "gluten";
      print("I am gluten free");
    }

    switch (preferences.carbs) {
      case "Any":
        break;
      case "Low":
        request["minCarbs"] = "1";
        request["maxCarbs"] = "20";
        print("I am low carbs");
        break;
      case "Medium":
        request["minCarbs"] = "21";
        request["maxCarbs"] = "50";
        print("I am med carbs");
        break;
      case "High":
        request["minCarbs"] = "51";
        request["maxCarbs"] = "100";
        print("I am high carbs");
        break;
    }

    switch (preferences.protein) {
      case "Any":
        break;
      case "Low":
        request["minProtein"] = "1";
        request["maxProtein"] = "10";
        print("I am low protein");
        break;
      case "Medium":
        request["minProtein"] = "11";
        request["maxProtein"] = "30";
        print("I am med protein");
        break;
      case "High":
        request["minProtein"] = "31";
        request["maxProtein"] = "100";
        print("I am high protein");
        break;
    }

    switch (preferences.calories) {
      case "Any":
        break;
      case "Low":
        request["minCalories"] = "50";
        request["maxCalories"] = "500";
        print("I am low calories");
        break;
      case "Medium":
        request["minCalories"] = "501";
        request["maxCalories"] = "1000";
        print("I am med calories");
        break;
      case "High":
        request["minCalories"] = "1001";
        request["maxCalories"] = "3000";
        print("I am high calories");
        break;
    }

    final response = await http.get(
      Uri.https(url, 'recipes/complexSearch', request),
    );
    var growableList = <int>[];
    var num = int.parse(number);
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['results'];
      for (int i = 0; i < num; i++) {
        growableList.add(res[i]['id']);
      }
    }
    return growableList;
  }

  Future<List<int>> searchRecipes(String query) async {
    Map<String, dynamic> request = {"query": query, "apiKey": apiKey};
    final response = await http.get(
      Uri.https(url, 'recipes/complexSearch', request),
    );
    var growableList = <int>[];
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['results'];
      for (int i = 0; i < res.length; i++) {
        growableList.add(res[i]['id']);
      }
    }
    return growableList;
  }

  Future<Map<String, dynamic>> fetchDisplayRecipeInfo(int recipeID) async {
    Map<String, dynamic> request = {
      "apiKey": apiKey,
      "includeNutrition": "false"
    };
    String recipeId = recipeID.toString();
    final response = await http.get(
      Uri.https(url, 'recipes/' + recipeId + '/information', request),
    );
    Map<String, dynamic> details = {};
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      details['id'] = res['id'];
      details['title'] = res['title'];
      details['image'] = res['image'];
    }
    return details;
  }

  Future<Map<String, dynamic>> fetchRecipeInfo(int recipeID) async {
    Map<String, dynamic> request = {
      "apiKey": apiKey,
      "includeNutrition": "false"
    };
    String recipeId = recipeID.toString();
    final response = await http.get(
      Uri.https(url, 'recipes/' + recipeId + '/information', request),
    );
    Map<String, dynamic> details = {};
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      details['id'] = res['id'];
      details['title'] = res['title'];
      details['image'] = res['image'];
      details['servings'] = res['servings'];
      details['readyInMinutes'] = res['readyInMinutes'];
      var ingredientList = res['extendedIngredients'];
      var growableList = <String>[];
      for (int i = 0; i < ingredientList.length; i++) {
        growableList.add(ingredientList[i]['original']);
      }
      details['ingredients'] = growableList;
    }
    return details;
  }

  Future<List<String>> fetchRecipeInstructions(int recipeID) async {
    Map<String, dynamic> request = {"apiKey": apiKey};
    String recipeId = recipeID.toString();
    final response = await http.get(
      Uri.https(url, 'recipes/' + recipeId + '/analyzedInstructions', request),
    );
    var instructions = <String>[];
    if (response.statusCode == 200) {
      var res = json.decode(response.body)[0]['steps'];
      for (int i = 0; i < res.length; i++) {
        instructions.add(res[i]['step']);
      }
    }
    return instructions;
  }

  Future<void> storeInFirestore(Map<String, dynamic> recipeInfo,
      List<String> recipeInstructions, String email) async {
    recipeInfo['instructions'] = recipeInstructions;
    DocumentReference documentReference = firestore
        .collection("fit")
        .doc(email)
        .collection("SavedRecipes")
        .doc(recipeInfo['id'].toString());
    databaseService.updateDocument(documentReference, recipeInfo, false);
  }

  Future<List<int>> getSavedRecipesIDs(String email) async {
    var recipeIDs = <int>[];
    await FirebaseFirestore.instance
        .collection("fit")
        .doc(email)
        .collection("SavedRecipes")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                recipeIDs.add(doc["id"]);
              })
            })
        .catchError((error) => print('Failed to get saved recipes: $error'));
    print(recipeIDs);
    return recipeIDs;
  }

  Future<Map<String, dynamic>> getSavedRecipeDisplayInfo(
      String email, int recipeID) async {
    Map<String, dynamic> details = {};
    await FirebaseFirestore.instance
        .collection("fit")
        .doc(email)
        .collection("SavedRecipes")
        .doc(recipeID.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        details['id'] = documentSnapshot['id'];
        details['title'] = documentSnapshot['title'];
        details['image'] = documentSnapshot['image'];
      } else {
        print('Document does not exist on the database');
      }
    });
    return details;
  }

  Future<Map<String, dynamic>> getSavedRecipeInfo(
      String email, int recipeID) async {
    Map<String, dynamic> details = {};
    await FirebaseFirestore.instance
        .collection("fit")
        .doc(email)
        .collection("SavedRecipes")
        .doc(recipeID.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        details['id'] = documentSnapshot['id'];
        details['title'] = documentSnapshot['title'];
        details['image'] = documentSnapshot['image'];
        details['servings'] = documentSnapshot['servings'];
        details['readyInMinutes'] = documentSnapshot['readyInMinutes'];
        details['ingredients'] = documentSnapshot['ingredients'];
      } else {
        print('Document does not exist on the database');
      }
    });
    return details;
  }

  Future<List<String>> getSavedRecipeInstructions(
      String email, int recipeID) async {
    var instructions = [];
    await FirebaseFirestore.instance
        .collection("fit")
        .doc(email)
        .collection("SavedRecipes")
        .doc(recipeID.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        instructions = documentSnapshot['instructions'];
      } else {
        print('Document does not exist on the database');
      }
    });
    var newInstructions = new List<String>.from(instructions);
    print("this is new instructions");
    return newInstructions;
  }
}

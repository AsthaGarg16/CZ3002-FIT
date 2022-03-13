import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Controller/services/database.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeController {
  String url = 'api.spoonacular.com';
  String apiKey = '7df62bdc1ad34570b6ab05269bbef6bd';
  String email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService databaseService = new DatabaseService();

  RecipeController(this.email);

  Future <List<int>> fetchRecipeIDs(String includeIngredients, String number) async {
    Map<String, dynamic> request = {
      "includeIngredients": includeIngredients,
      "number": number,
      "sort": "max-used-ingredients",
      "sortDirection": "desc",
      "apiKey": apiKey
    };
    final response = await http.get(
      Uri.https(url, 'recipes/complexSearch', request),
    );
    var growableList = <int>[];
    var num = int.parse(number);
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['results'];
      for(int i=0;i<num;i++){
        growableList.add(res[i]['id']);
      }
    }
    return growableList;
  }

  Future <Map<String, dynamic>> fetchRecipeInfo(int recipeID) async {
    Map<String, dynamic> request = {
      "apiKey": apiKey,
      "includeNutrition": "false"
    };
    String recipeId = recipeID.toString();
    final response = await http.get(
      Uri.https(url, 'recipes/'+recipeId+'/information', request),
    );
    Map<String, dynamic> details = {};
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      details['id'] = res['id'];
      details['title'] = res['title'];
      details['servings'] = res['servings'];
      details['time to prepare (in min)'] = res['readyInMinutes'];
      var ingredientList = res['extendedIngredients'];
      var growableList = <Map>[];
      for(int i=0; i<ingredientList.length;i++){
        Map<String, dynamic> temp = {};
        temp['name'] = ingredientList[i]['name'];
        temp['amount'] = ingredientList[i]['amount'];
        temp['unit'] = ingredientList[i]['unit'];
        growableList.add(temp);
      }
      details['ingredients'] = growableList;
    }
    return details;
  }

  Future <Map<String, dynamic>> fetchRecipeInstructions(int recipeID) async {
    Map<String, dynamic> request = {
      "apiKey": apiKey
    };
    String recipeId = recipeID.toString();
    final response = await http.get(
      Uri.https(url, 'recipes/'+recipeId+'/analyzedInstructions', request),
    );
    Map<String, dynamic> instructions = {};
    if (response.statusCode == 200) {
      var res = json.decode(response.body)[0]['steps'];
      for(int i=0; i<res.length;i++){
        instructions[(i+1).toString()] = res[i]['step'];
      }
    }
    return instructions;
  }

  Future <void> storeInFirestore(Map<String, dynamic> recipeInfo, Map<String, dynamic> recipeInstructions) async {
    recipeInfo['instructions'] = recipeInstructions;
    DocumentReference documentReference = firestore.collection("fit").doc(email)
        .collection("SavedRecipes").doc(recipeInfo['id'].toString());
    databaseService.updateDocument(documentReference, recipeInfo, false);
  }

  Future <void> readFromFirestore(int recipeID) async {
    DocumentReference documentReference = firestore.collection("fit").doc(email)
        .collection("SavedRecipes").doc(recipeID.toString());
    databaseService.getDocument(documentReference);
  }
}
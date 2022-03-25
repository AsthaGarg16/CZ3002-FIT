import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Controller/services/auth.dart';
import '../Controller/services/database.dart';
import '../Controller/services/RecipeController.dart';
import 'package:fit/Controller/services/InventoryController.dart';
import 'AddRecipeIngredientDialog.dart';

class RecipeInstructionsPage extends StatefulWidget {
  final int recipeID;
  final bool saved;
  const RecipeInstructionsPage(
      {Key? key, required this.recipeID, required this.saved})
      : super(key: key);
  int getRecipeId() {
    return recipeID;
  }

  @override
  State<StatefulWidget> createState() {
    return _RecipeInstructionsPage();
  }
}

class _RecipeInstructionsPage extends State<RecipeInstructionsPage> {
  InventoryController inventoryController = InventoryController();
  RecipeController recipeController = RecipeController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService databaseService = DatabaseService();
  AuthService authService = AuthService();
  late Future<Map<String, dynamic>> RecipeDetails;
  late Future<List<String>> RecipeInstructions;
  late Map<String, dynamic> recipeDetails;
  late List<String> recipeInstructions;

  void initState() {
    if (widget.saved == false) {
      RecipeDetails = getRecipeDetails(widget.recipeID);
      RecipeDetails.then((value) {
        recipeDetails = value;
        print(recipeDetails);
      });
      RecipeInstructions = getRecipeInstructions(widget.recipeID);
      RecipeInstructions.then((value) {
        recipeInstructions = value;
        print(recipeInstructions);
      });
    } else {
      print("from db");
      RecipeDetails = asyncMethod1();
      RecipeDetails.then((value) {
        recipeDetails = value;
        print(recipeDetails);
      });
      RecipeInstructions = asyncMethod2();
      RecipeInstructions.then((value) {
        recipeInstructions = value;
        print(recipeInstructions);
      });
    }
    super.initState();
  }

  Future<Map<String, dynamic>> asyncMethod1() async {
    String email = await authService.getUser();
    print(email);
    return getSavedRecipeDetails(email, widget.recipeID);
  }

  Future<List<String>> asyncMethod2() async {
    String email = await authService.getUser();
    print(email);
    return getSavedRecipeInstructions(email, widget.recipeID);
  }

  bool _isStarred = false;
  IconData _starIcon = Icons.star_border_outlined;

  void addIngredientToShopList() {
    return;
  }

  void showAlertDialog(
      BuildContext context, String name, String quantity, String unit) {
    AddRecipeIngredientDialog alert = AddRecipeIngredientDialog(
      name: name,
      quantity: quantity,
      unit: unit,
      recipeID: widget.recipeID,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _onIsStarredChanged(bool newValue) async {
    _isStarred = newValue;
    AuthService authService = new AuthService();
    String email = await authService.getUser();

    if (_isStarred) {
      recipeController.storeInFirestore(
          recipeDetails, recipeInstructions, email);
      print("Added");
    } else {
      DocumentReference documentReference = firestore
          .collection("fit")
          .doc(email)
          .collection("SavedRecipes")
          .doc(widget.recipeID.toString());
      databaseService.deleteDocument(documentReference);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Future.wait([RecipeDetails, RecipeInstructions]),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                int servings = recipeDetails['servings'];
                int cookTime = recipeDetails['readyInMinutes'];
                List<Widget> ingredientsWidgetList =
                    recipeDetails['ingredients']
                        .map<Widget>((name) => Container(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                                onTap: () {
                                  print("Move ingredients to shopping list");
                                  var parts = name.split(' ');
                                  String amount = parts[0].trim();
                                  String unit = parts[1].trim();
                                  String ingredient =
                                      parts.sublist(2).join(' ').trim();
                                  print("amount: " + amount);
                                  print("unit: " + unit);
                                  print("ingredient: " + ingredient);
                                  return showAlertDialog(
                                      context, ingredient, amount, unit);
                                },
                                child: Text(
                                  name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ))))
                        .toList();
                List<Widget> recipeInstructionWidgetList = recipeInstructions
                    .map<Widget>((name) => Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          name,
                          style: Theme.of(context).textTheme.bodyText1,
                        )))
                    .toList();

                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                        title: Text(recipeDetails["title"]),
                        actions: <Widget>[
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (_isStarred) {
                                  _isStarred = false;
                                  _starIcon = Icons.star_border_outlined;
                                  _onIsStarredChanged(_isStarred);
                                } else {
                                  _isStarred = true;
                                  _starIcon = Icons.star;
                                  _onIsStarredChanged(_isStarred);
                                }
                              });
                            },
                            icon: Icon(_starIcon),
                          )
                        ]),
                    body: SingleChildScrollView(
                        child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(10),
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(60), // Image radius
                            child: Image.network(recipeDetails["image"],
                                fit: BoxFit.cover),
                          ),
                        ),
                        Text(
                          recipeDetails["title"],
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.accessibility,
                                color: Colors.black,
                              ),
                              Text(
                                "Servings: $servings",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Spacer(),
                              const Icon(Icons.access_alarm),
                              Text("Total time: $cookTime mins",
                                  style: Theme.of(context).textTheme.bodyText1)
                            ],
                          ),
                        ),
                        Text(
                          "Ingredients",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        ...ingredientsWidgetList,
                        Text(
                          "Directions",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        ...recipeInstructionWidgetList,
                      ],
                    )));
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}',
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  letterSpacing: 1.5)),
                        )
                      ]),
                );
              } else {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ]),
                );
              }
            }));
  }

  // Function to Call Backend for all recipe details (excluding instructions)
  // Returns map containing ID, title, ingredients etc
  Future<Map<String, dynamic>> getRecipeDetails(int recipeID) async {
    Map<String, dynamic> recipeDetails =
        await recipeController.fetchRecipeInfo(recipeID);
    print(recipeDetails);
    return recipeDetails;
  }

  Future<Map<String, dynamic>> getSavedRecipeDetails(
      String email, int recipeID) async {
    Map<String, dynamic> recipeDetails =
        await recipeController.getSavedRecipeInfo(email, recipeID);
    print(recipeDetails);
    return recipeDetails;
  }

  // Function to Call Backend for recipe instructions
  // Returns list of instructions
  Future<List<String>> getRecipeInstructions(int recipeID) async {
    var recipeInstructions = <String>[];
    recipeInstructions =
        await recipeController.fetchRecipeInstructions(recipeID);
    print(recipeInstructions);
    return recipeInstructions;
  }

  Future<List<String>> getSavedRecipeInstructions(
      String email, int recipeID) async {
    var recipeInstructions = <String>[];
    recipeInstructions =
        await recipeController.getSavedRecipeInstructions(email, recipeID);
    print(recipeInstructions);
    return recipeInstructions;
  }

  Future<bool> checkInInventory(String name) async {
    String email = await authService.getUser();
    String inventory = await inventoryController.getFoodItems(email);
    List<String> inventoryList = inventory.split(",");
    var parts = name.split(' ');
    String ingredient = parts.sublist(2).join(' ').trim();
    if (inventoryList.contains(ingredient)) {
      return false;
    }
    else{
      return true;
    }
  }
}

import 'package:fit/UI/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Controller/services/auth.dart';
import '../Controller/services/database.dart';
import '../Controller/services/RecipeController.dart';

class RecipeInstructionsPage extends StatefulWidget {
  final int recipeID;
  const RecipeInstructionsPage({Key? key, required this.recipeID})
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
  RecipeController recipeController = RecipeController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService databaseService = new DatabaseService();
  late Future<Map<String, dynamic>> RecipeDetails;
  late Future<List<String>> RecipeInstructions;
  late Map<String, dynamic> recipeDetails;
  late List<String> recipeInstructions;

  void initState() {
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
    super.initState();
  }

  bool _isStarred = false;
  IconData _starIcon = Icons.star_border_outlined;

  // final int recipeID = 1;
  // final String recipeName = "Spaghetti bolognese";
  // final String recipeImage = "assets/images/pasta.jpg";
  // final int servings = 4;
  // final int readyInMinutes = 40;

  // final List<String> instructions = [
  //   "Put a large saucepan on a medium heat and add 1 tbsp olive oil.",
  //   "Add 4 finely chopped bacon rashers and fry for 10 mins until golden and crisp.",
  //   "Reduce the heat and add the 2 onions, 2 carrots, 2 celery sticks, 2 garlic cloves and the leaves from 2-3 sprigs rosemary, all finely chopped, then fry for 10 mins. Stir the veg often until it softens.",
  //   "Increase the heat to medium-high, add 500g beef mince and cook stirring for 3-4 mins until the meat is browned all over.",
  //   "Add 2 tins plum tomatoes, the finely chopped leaves from ¾ small pack basil, 1 tsp dried oregano, 2 bay leaves, 2 tbsp tomato purée, 1 beef stock cube, 1 deseeded and finely chopped red chilli (if using), 125ml red wine and 6 halved cherry tomatoes. Stir with a wooden spoon, breaking up the plum tomatoes.",
  //   "Bring to the boil, reduce to a gentle simmer and cover with a lid. Cook for 1 hr 15 mins stirring occasionally, until you have a rich, thick sauce.",
  //   "Add the 75g grated parmesan, check the seasoning and stir."
  //       "Cook 400g of spaghetti following the pack instructions and stir into bolognese sauce."
  // ];
  // final List<String> ingredientsList = [
  //   "1 tbsp olive oil",
  //   "4 rashers smoked streaky bacon, finely chopped",
  //   "2 medium onions, finely chopped",
  //   "2 carrots, trimmed and finely chopped",
  //   "2 celery sticks, finely chopped",
  //   "2 garlic cloves finely chopped",
  //   "2-3 sprigs rosemary leaves picked and finely chopped",
  //   "500g beef mince"
  // ];
  void addIngredientToShopList() {
    return;
  }

  void _onIsStarredChanged(bool newValue) => setState(() async {
        _isStarred = newValue;
        AuthService authService = new AuthService();
        String email = await authService.getUser();

        if (_isStarred) {
          recipeController.storeInFirestore(
              recipeDetails, recipeInstructions, email);
          print("Added");
        } else {
          // TODO: remove the recipe
          // need the recipeID and email of user
          DocumentReference documentReference = firestore
              .collection("fit")
              .doc(email)
              .collection("SavedRecipes")
              .doc(widget.recipeID.toString());
          databaseService.deleteDocument(documentReference);
        }
      });

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
                        .map<Widget>((name) => new Container(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                                onTap: () {
                                  print("MOve ingredients to shopping list");
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

  // Function to Call Backend for recipe instructions
  // Returns list of instructions
  Future<List<String>> getRecipeInstructions(int recipeID) async {
    var recipeInstructions = <String>[];
    recipeInstructions =
        await recipeController.fetchRecipeInstructions(recipeID);
    print(recipeInstructions);
    return recipeInstructions;
  }
}

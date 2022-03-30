import 'package:fit/Controller/services/InventoryController.dart';
import 'package:fit/UI/FilterCheckbox.dart';
import 'package:fit/UI/UserProfilePage.dart';
import 'package:flutter/material.dart';
import 'RecipeCard.dart';
import 'RecipeInstructionsPage.dart';
import '../Controller/services/RecipeController.dart';
import '../Controller/services/auth.dart';
import '../../Entity/Preferences.dart';

class RecipePage extends StatefulWidget {
  RecipePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RecipePage();
  }
}

class _RecipePage extends State<StatefulWidget> {
  RecipeController recipeController = RecipeController();
  InventoryController inventoryController = InventoryController();
  AuthService authService = AuthService();
  late Future<List<Map<String, dynamic>>> RecipeList;
  List<Map<String, dynamic>> recipeList = [];
  bool savedRecipes = false;
  List<Map<String, dynamic>> oldRecipeList = [];

  bool _isStarredRecipes = false;
  IconData _starIcon = Icons.star_border_outlined;

  @override
  initState() {
    RecipeList = asyncMethod();
    RecipeList.then((value) {
      recipeList = value;
    });
    super.initState();
  }

  Future<List<Map<String, dynamic>>> asyncMethod() async {
    String email = await authService.getUser();
    print(email);
    String inventoryList = await inventoryController.getFoodItems(email);
    print(inventoryList);
    Preferences preferences =
        Preferences(false, false, false, false, "Any", "Any", "Any");
    return getRecipeList(inventoryList, "5", recipeController, preferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes", style: Theme.of(context).textTheme.subtitle1),
        automaticallyImplyLeading: false,
        // automaticallyImplyLeading: showBackButton,
        // title: customSearchBar,
        // centerTitle: centerTitle,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _starIcon,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () async {
              if (_isStarredRecipes) {
                _isStarredRecipes = false;
                savedRecipes = false;
                _starIcon = Icons.star_border_outlined;
                recipeList = oldRecipeList;
              } else {
                oldRecipeList = recipeList;
                String email = await authService.getUser();
                recipeList = await getSavedRecipeList(email, recipeController);
                savedRecipes = true;
                _starIcon = Icons.star;
                _isStarredRecipes = true;
              }
              setState(() {
                _starIcon;
                recipeList;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.portrait_rounded,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => UserProfilePage()));
            },
          ),

        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(children: <Widget>[
            Expanded(
                child: Scrollbar(
              isAlwaysShown: true,
              child: FutureBuilder(
                  future: Future.wait([RecipeList]),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView.builder(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return RecipeCard(
                              recipeName: recipeList[index]['title'].toString(),
                              recipeImage:
                                  recipeList[index]['image'].toString(),
                              recipeID: (recipeList[index]['id']) ?? -1,
                              onRecipeSelected: (int ID) {
                                print(ID);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeInstructionsPage(
                                          recipeID: ID,
                                          saved: savedRecipes,
                                        )));
                              },
                            );
                          });
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
                  }),
            ))
          ])),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              showSearch(
                  context: context, delegate: RecipeSearch(recipeController));
            },
            child: const Icon(Icons.search)),
        const SizedBox(height: 10),
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: () async {
            var foodPref = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FilterCheckbox();
                });
            String email = await authService.getUser();
            String inventoryList =
                await inventoryController.getFoodItems(email);
            recipeList = await getRecipeList(
                inventoryList, "5", recipeController, foodPref);
            print(recipeList);
            setState(() {
              recipeList;
            });
          },
          child: const Icon(Icons.filter_alt, size: 30.0),
        ),
      ]),
    );
  }
}

Future<String> getInventoryList(
    String email, InventoryController inventoryController) async {
  String inventoryList = await inventoryController.getFoodItems(email);
  print("Function Inventory: ");
  print(inventoryList);
  return inventoryList;
}

Future<String> getEmail(AuthService authService) async {
  String email = await authService.getUser();
  print("Function Email: ");
  print(email);
  return email;
}

Future<List<Map<String, dynamic>>> getRecipeList(
    String includeIngredients,
    String number,
    RecipeController recipeController,
    Preferences preferences) async {
  var recipeList = <Map<String, dynamic>>[];
  List<int> recipeIDs = await recipeController.fetchRecipeIDs(
      includeIngredients, number, preferences);
  print("Function IDs: ");
  print(recipeIDs);
  for (int i = 0; i < recipeIDs.length; i++) {
    Map<String, dynamic> recipeInfo =
        await recipeController.fetchDisplayRecipeInfo(recipeIDs[i]);
    recipeList.add(recipeInfo);
  }
  print("Function List: ");
  print(recipeList);
  return recipeList;
}

Future<List<Map<String, dynamic>>> getSavedRecipeList(
    String email, RecipeController recipeController) async {
  var recipeList = <Map<String, dynamic>>[];
  List<int> recipeIDs = await recipeController.getSavedRecipesIDs(email);
  print("Saved Recipes IDs: ");
  print(recipeIDs);
  for (int i = 0; i < recipeIDs.length; i++) {
    Map<String, dynamic> recipeInfo =
        await recipeController.getSavedRecipeDisplayInfo(email, recipeIDs[i]);
    recipeList.add(recipeInfo);
  }
  print("Saved Recipes List: ");
  print(recipeList);
  return recipeList;
}

Future<List<Map<String, dynamic>>> getSearchResult(
    String query, RecipeController recipeController) async {
  var recipeList = <Map<String, dynamic>>[];
  List<int> recipeIDs = await recipeController.searchRecipes(query);
  print("Function IDs: ");
  print(recipeIDs);
  for (int i = 0; i < recipeIDs.length; i++) {
    Map<String, dynamic> recipeInfo =
        await recipeController.fetchDisplayRecipeInfo(recipeIDs[i]);
    recipeList.add(recipeInfo);
  }
  print("Function List: ");
  print(recipeList);
  return recipeList;
}

class RecipeSearch extends SearchDelegate<String> {
  List<Map<String, dynamic>> recipeList = [];
  RecipeController recipeController;

  RecipeSearch(this.recipeController);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        // child: const Icon(Icons.filter_alt, size: 30.0),
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getSearchResult(query, recipeController),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("You have an error");
          return const Text("Something went wrong");
        } else if (snapshot.hasData) {
          recipeList = snapshot.data!;
          print(snapshot.data);
          return ListView.builder(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: recipeList.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  recipeName: recipeList[index]['title'].toString(),
                  recipeImage: recipeList[index]['image'].toString(),
                  recipeID: (recipeList[index]['id']) ?? -1,
                  onRecipeSelected: (int ID) {
                    print(ID);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecipeInstructionsPage(
                              recipeID: ID,
                              saved: false,
                            )));
                  },

                  //
                  //     context,
                  //     MaterialPageRoute(builder: (context) => RecipeInstructionPage(

                  //     ))
                  // },
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}

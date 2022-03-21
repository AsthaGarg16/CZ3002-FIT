import 'package:fit/UI/FilterCheckbox.dart';
import 'package:flutter/material.dart';
import 'RecipeCard.dart';
import 'RecipeInstructionsPage.dart';
import '../Controller/services/RecipeController.dart';


class RecipePage extends StatefulWidget {
  RecipePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RecipePage();
  }
}

class _RecipePage extends State<StatefulWidget> {
  RecipeController recipeController = new RecipeController("123456@gmail.com");
  List<Map<String, dynamic>> recipeList = [];
  @override
  initState() {
    getRecipeList("pasta,tuna,apple,chicken", "10", recipeController).then((value) {
      recipeList = value;
      print("Initialiser");
      print(value);
    });
    print(recipeList);
    super.initState();
  }

  // [
  //   {
  //     'id': 1,
  //     'title': 'Sphagetti Bolognese',
  //     'description': 'Meat and tomato based pasta',
  //     'image': 'assets/images/pasta.jpg'
  //   },
  //   {
  //     'id': 2,
  //     'title': 'Salad',
  //     'description': 'Healthy bowl of greens',
  //     'image': 'assets/images/salad.jpg'
  //   },
  //   {
  //     'id': 3,
  //     'title': 'Spaghetti Bolognese',
  //     'description': 'Meat and tomato based pasta',
  //     'image': 'assets/images/pasta.jpg'
  //   },
  //   {
  //     'id': 4,
  //     'title': 'Sphagetti Bolognese',
  //     'description': 'Meat and tomato based pasta',
  //     'image': 'assets/images/pasta.jpg'
  //   },
  //   {
  //     'id': 5,
  //     'title': 'Sphagetti Bolognese',
  //     'description': 'Meat and tomato based pasta',
  //     'image': 'assets/images/pasta.jpg'
  //   },
  //   {
  //     'id': 6,
  //     'title': 'Salad',
  //     'description': 'Healthy bowl of greens',
  //     'image': 'assets/images/salad.jpg'
  //   },
  //   {
  //     'id': 7,
  //     'title': 'Sphagetti Bolognese',
  //     'description': 'Meat and tomato based pasta',
  //     'image': 'assets/images/pasta.jpg'
  //   },
  //   {
  //     'id': 8,
  //     'title': 'Sphagetti Bolognese',
  //     'description': 'Meat and tomato based pasta',
  //     'image': 'assets/images/pasta.jpg'
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: ListView.builder(
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
                                        RecipeInstructionsPage()));
                              },

                              //
                              //     context,
                              //     MaterialPageRoute(builder: (context) => RecipeInstructionPage(

                              //     ))
                              // },
                            );
                          })))
            ],
          )),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: (){
                  showSearch(context: context, delegate: RecipeSearch(recipeController));
                },
                child: const Icon(Icons.search)
            ),
            const SizedBox(height:10),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterCheckbox();
                    }
                );
              },

              child: const Icon(Icons.filter_alt, size: 30.0),
            ),
          ]
      ),
    );
  }


}

Future<List<Map<String, dynamic>>> getRecipeList(
    String includeIngredients, String number, RecipeController recipeController) async {
  var recipeList = <Map<String, dynamic>>[];
  List<int> recipeIDs =
  await recipeController.fetchRecipeIDs(includeIngredients, number);
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
    return [IconButton(
        onPressed: (){
          query = "";
        },
        icon: const Icon(Icons.clear)
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, "");
        },
        // child: const Icon(Icons.filter_alt, size: 30.0),
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation
        )
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getRecipeList("pasta,tuna,apple,chicken", "3", recipeController),
      builder: (context, snapshot){
        if(snapshot.hasError){
          print("You have an error");
          return const Text("Something went wrong");
        }else if (snapshot.hasData){
          recipeList = snapshot.data!;
          print(snapshot.data);
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
                            RecipeInstructionsPage()));
                  },

                  //
                  //     context,
                  //     MaterialPageRoute(builder: (context) => RecipeInstructionPage(

                  //     ))
                  // },
                );
              });
        }else{
          return Center( child: CircularProgressIndicator());
        }
      },
    );


  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
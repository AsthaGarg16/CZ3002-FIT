import 'package:fit/UI/FilterCheckbox.dart';
import 'package:flutter/material.dart';
import 'RecipeCard.dart';
import 'RecipeInstructionsPage.dart';
import '../Controller/services/RecipeController.dart';

class RecipePage extends StatelessWidget {
  RecipeController recipeController = new RecipeController("123456@gmail.com");
  List<Map<String, dynamic>> recipeList = [];
  @override
  initState() async {
    recipeList = await getRecipeList("pasta,tuna,apple,chicken", "10");
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

  RecipePage({Key? key}) : super(key: key);

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
                              recipeDescription:
                                  recipeList[index]['description'].toString(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FilterCheckbox();
              });
        },
        child: const Icon(Icons.filter_alt, size: 30.0),
      ),
    );
  }

  Future <List<Map<String, dynamic>>> getRecipeList(String includeIngredients, String number) async {
    var recipeList = <Map<String, dynamic>> [];
    List<int> recipeIDs = await recipeController.fetchRecipeIDs(includeIngredients, number);
    for(int i=0; i<recipeIDs.length; i++){
      Map<String, dynamic> recipeInfo = await recipeController.fetchDisplayRecipeInfo(recipeIDs[i]);
      recipeList.add(recipeInfo);
    }
    print(recipeList);
    return recipeList;
  }
}

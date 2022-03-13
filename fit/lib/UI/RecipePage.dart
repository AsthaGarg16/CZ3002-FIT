import 'package:fit/UI/FilterCheckbox.dart';
import 'package:flutter/material.dart';
import 'RecipeCard.dart';
import 'RecipeInstructionsPage.dart';

class RecipePage extends StatelessWidget {
  List<Map<String, dynamic>> recipeList = [
    {
      'id': 1,
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'id': 2,
      'title': 'Salad',
      'description': 'Healthy bowl of greens',
      'image': 'assets/images/salad.jpg'
    },
    {
      'id': 3,
      'title': 'Spaghetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'id': 4,
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'id': 5,
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'id': 6,
      'title': 'Salad',
      'description': 'Healthy bowl of greens',
      'image': 'assets/images/salad.jpg'
    },
    {
      'id': 7,
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'id': 8,
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    }
  ];

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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recipes",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.white12,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.filter_alt),
                          color: Colors.black,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return FilterCheckbox();
                                });
                          },
                        ),
                      ),
                    ]),
                Expanded(
                    child: Scrollbar(
                        isAlwaysShown: true,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: recipeList.length,
                            itemBuilder: (context, index) {
                              return RecipeCard(
                                recipeName:
                                    recipeList[index]['title'].toString(),
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
            )));
  }
}

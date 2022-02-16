import 'package:flutter/material.dart';
import 'RecipeCard.dart';

class RecipePage extends StatelessWidget {
  List<Map<String, Object>> recipeList = [
    {
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'title': 'Salad',
      'description': 'Healthy bowl of greens',
      'image': 'assets/images/salad.jpg'
    },
    {
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
      'title': 'Salad',
      'description': 'Healthy bowl of greens',
      'image': 'assets/images/salad.jpg'
    },
    {
      'title': 'Sphagetti Bolognese',
      'description': 'Meat and tomato based pasta',
      'image': 'assets/images/pasta.jpg'
    },
    {
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
        appBar: AppBar(
          title: Text("FIT", style: Theme.of(context).textTheme.subtitle1),
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 20, color: Colors.white70)),
        ),
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
                          onPressed: () {},
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
                              );
                            })))
              ],
            )));
  }
}

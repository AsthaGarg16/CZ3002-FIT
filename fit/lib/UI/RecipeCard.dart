import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final int recipeID;
  final String recipeName;
  //final String recipeDescription;
  final String recipeImage;
  final Function(int) onRecipeSelected;

  const RecipeCard({
    Key? key,
    required this.recipeID,
    required this.recipeName,
    //required this.recipeDescription,
    required this.recipeImage,
    required this.onRecipeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 200,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
              onRecipeSelected(recipeID);
            },
            child: ListTile(
                contentPadding: EdgeInsets.all(8.0),
                title: Column(children: [
                  Text(recipeName,
                      style: Theme.of(context).textTheme.subtitle2),
                  SizedBox(height: 4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                      maxWidth: 200,
                      maxHeight: 200,
                    ),
                    child: Image.network(recipeImage),
                  )
                ])
                // subtitle: Text(recipeDescription,
                //     style: Theme.of(context).textTheme.bodyText1),
                ),
          ),
        ]),
      ),
    ));
  }
}

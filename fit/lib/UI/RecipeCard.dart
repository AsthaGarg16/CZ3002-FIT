import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String recipeName;
  final String recipeDescription;
  final String recipeImage;

  const RecipeCard(
      {Key? key,
      required this.recipeName,
      required this.recipeDescription,
      required this.recipeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
            },
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              leading: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset(recipeImage),
              ),
              title: Text(recipeName,
                  style: Theme.of(context).textTheme.subtitle2),
              subtitle: Text(recipeDescription,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
        ]),
      ),
    );
  }
}

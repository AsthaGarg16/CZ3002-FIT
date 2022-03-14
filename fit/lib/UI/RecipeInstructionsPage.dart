import 'package:flutter/material.dart';

class RecipeInstructionsPage extends StatefulWidget {
  RecipeInstructionsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RecipeInstructionsPage();
  }
}

class _RecipeInstructionsPage extends State<StatefulWidget> {
  bool _isClicked = false;
  IconData _starIcon = Icons.star_border_outlined;
  final int recipeID = 1;
  final String recipeName = "Spaghetti bolognese";
  final String recipeImage = "assets/images/pasta.jpg";
  final int servings = 4;
  final int readyInMinutes = 40;
  final String sourceName = 'BBC good food';
  final String sourceUrl =
      'https://www.bbcgoodfood.com/recipes/best-spaghetti-bolognese-recipe';
  final int aggregateLikes = 808;
  final List<String> instructions = [
    "Put a large saucepan on a medium heat and add 1 tbsp olive oil.",
    "Add 4 finely chopped bacon rashers and fry for 10 mins until golden and crisp.",
    "Reduce the heat and add the 2 onions, 2 carrots, 2 celery sticks, 2 garlic cloves and the leaves from 2-3 sprigs rosemary, all finely chopped, then fry for 10 mins. Stir the veg often until it softens.",
    "Increase the heat to medium-high, add 500g beef mince and cook stirring for 3-4 mins until the meat is browned all over.",
    "Add 2 tins plum tomatoes, the finely chopped leaves from ¾ small pack basil, 1 tsp dried oregano, 2 bay leaves, 2 tbsp tomato purée, 1 beef stock cube, 1 deseeded and finely chopped red chilli (if using), 125ml red wine and 6 halved cherry tomatoes. Stir with a wooden spoon, breaking up the plum tomatoes.",
    "Bring to the boil, reduce to a gentle simmer and cover with a lid. Cook for 1 hr 15 mins stirring occasionally, until you have a rich, thick sauce.",
    "Add the 75g grated parmesan, check the seasoning and stir."
        "Cook 400g of spaghetti following the pack instructions and stir into bolognese sauce."
  ];
  final List<String> ingredientsList = [
    "1 tbsp olive oil",
    "4 rashers smoked streaky bacon, finely chopped",
    "2 medium onions, finely chopped",
    "2 carrots, trimmed and finely chopped",
    "2 celery sticks, finely chopped",
    "2 garlic cloves finely chopped",
    "2-3 sprigs rosemary leaves picked and finely chopped",
    "500g beef mince"
  ];
  // const RecipeInstructionPage({
  //   Key? key,
  //   required this.recipeID,
  //   required this.recipeName,
  //   required this.imageUrl,
  //   required this.servings,
  //   required this.readyInMinutes,
  //   required this.sourceName,
  //   required this.sourceUrl,
  //   required this.aggregateLikes,
  //   required this.steps,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredientsWidgetList = ingredientsList
        .map((name) => new Container(
            padding: EdgeInsets.all(10),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            )))
        .toList();
    List<Widget> recipeInstructionWidgetList = instructions
        .map((name) => new Container(
            padding: EdgeInsets.all(20),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            )))
        .toList();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(recipeName), actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (_isClicked) {
                  _isClicked = false;
                  _starIcon = Icons.star_border_outlined;
                } else {
                  _isClicked = true;
                  _starIcon = Icons.star;
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
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(60), // Image radius
                child: Image.asset(recipeImage, fit: BoxFit.cover),
              ),
            ),
            Text(
              recipeName,
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
                  Text("Total time: $readyInMinutes mins",
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
    // TODO: implement build
    throw UnimplementedError();
  }
}

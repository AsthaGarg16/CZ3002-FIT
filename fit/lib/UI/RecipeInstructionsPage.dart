import 'package:flutter/material.dart';

class RecipeInstructionPage extends StatelessWidget {
  // final int recipeID;
  // final String title;
  // final String imageUrl;
  // final int servings;
  // final int readyInMinutes;
  // final String sourceName;
  // final String sourceUrl;
  // final int aggregateLikes;
  // final List steps;

  // const RecipeInstructionPage({
  //   Key? key,
  //   required this.recipeID,
  //   required this.title,
  //   required this.imageUrl,
  //   required this.servings,
  //   required this.readyInMinutes,
  //   required this.sourceName,
  //   required this.sourceUrl,
  //   required this.aggregateLikes,
  //   required this.steps,
  // }) : super(key: key);

  final int recipeID = 1;
  final String title = 'Spaghetti Bolognese';
  final String recipeImage = "assets/images/pasta.jpg";
  final int servings = 4;
  final int readyInMinutes = 120;
  final String sourceName = 'BBC good food';
  final String sourceUrl =
      'https://www.bbcgoodfood.com/recipes/best-spaghetti-bolognese-recipe';
  final int aggregateLikes = 808;
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
  final List<String> steps = [
    "Put a large saucepan on a medium heat and add 1 tbsp olive oil.",
    "Add 4 finely chopped bacon rashers and fry for 10 mins until golden and crisp.",
    "Reduce the heat and add the 2 onions, 2 carrots, 2 celery sticks, 2 garlic cloves and the leaves from 2-3 sprigs rosemary, all finely chopped, then fry for 10 mins. Stir the veg often until it softens.",
    "Increase the heat to medium-high, add 500g beef mince and cook stirring for 3-4 mins until the meat is browned all over.",
    "Add 2 tins plum tomatoes, the finely chopped leaves from ¾ small pack basil, 1 tsp dried oregano, 2 bay leaves, 2 tbsp tomato purée, 1 beef stock cube, 1 deseeded and finely chopped red chilli (if using), 125ml red wine and 6 halved cherry tomatoes. Stir with a wooden spoon, breaking up the plum tomatoes.",
    "Bring to the boil, reduce to a gentle simmer and cover with a lid. Cook for 1 hr 15 mins stirring occasionally, until you have a rich, thick sauce.",
    "Add the 75g grated parmesan, check the seasoning and stir."
        "Cook 400g of spaghetti following the pack instructions and stir into bolognese sauce."
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(title,style: Theme.of(context).textTheme.subtitle2),
      Container(child:Image.asset(recipeImage)),
      

    ],)
    // TODO: implement build
    throw UnimplementedError();
  }
}

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
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
              onRecipeSelected(recipeID);
            },
            child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: Offset(
                        0.0,
                        10.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: -6.0,
                    ),
                  ],
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.35),
                      BlendMode.multiply,
                    ),
                    image: NetworkImage(recipeImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          recipeName,
                          style: TextStyle(
                            fontFamily: 'mw',
                            fontSize: 24,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                )
                // child: Card(
                //   elevation: 10,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15.0),
                //   ),
                //   child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                //     InkWell(
                //       splashColor: Colors.blue.withAlpha(30),
                //       onTap: () {
                //         debugPrint('Card tapped.');
                //         onRecipeSelected(recipeID);
                //       },
                //       child: ListTile(
                //           contentPadding: EdgeInsets.all(6.0),
                //           title: Column(children: [
                //             Text(recipeName,
                //                 style: Theme.of(context).textTheme.subtitle2),
                //             SizedBox(height: 4),
                //             Wrap(direction: Axis.vertical, children: [
                //               ConstrainedBox(
                //                 constraints: const BoxConstraints(
                //                   minWidth: 60,
                //                   minHeight: 60,
                //                   maxWidth: 200,
                //                   maxHeight: 100,
                //                 ),
                //                 child: Image.network(recipeImage),
                //               ),
                //             ])
                //           ])
                //           // subtitle: Text(recipeDescription,
                //           //     style: Theme.of(context).textTheme.bodyText1),
                //           ),
                //     ),
                //   ]),
                // ),
                )));
  }
}

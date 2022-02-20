import 'package:flutter/material.dart';
import 'ShopListCard.dart';

class ShoppingList extends StatelessWidget {
  List<Map<String, Object>> shopList = [
    {
      'label': 'Spaghetti',
      'quantity': '200 g',
      'recipe': 'Spaghetti Bolognese',
      'isRecipe' : true,
    },
    {
      'label': 'Tomatoes',
      'quantity': '200 g',
      'recipe': '',
      'isRecipe' : false,
    },
    {
      'label': 'Chilli Flakes',
      'quantity': '50 g',
      'recipe': '',
      'isRecipe' : false,
    },
    {
      'label': 'Apples',
      'quantity': '5',
      'recipe': 'Fruit Bowl',
      'isRecipe' : true,
    },
  ];

  ShoppingList({Key? key}) : super(key: key);

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
                            shrinkWrap: true,
                            itemCount: shopList.length,
                            itemBuilder: (context, index) {
                              return ShopListWidget(
                                label:
                                shopList[index]['label'].toString(),
                                quantity: shopList[index]['quantity'].toString(),
                                recipe: shopList[index]['recipe'].toString(),
                                isRecipe: shopList[index]['isRecipe'].toString().toLowerCase() == 'true',
                              );
                            })))
              ],
            )));
  }
}
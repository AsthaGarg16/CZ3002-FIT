import 'dart:ui';

import 'package:flutter/material.dart';
import 'ShopListCard.dart';

class ShoppingList extends StatefulWidget {
  List<Map<String, Object>> shopList = [
    {
      'label': 'Spaghetti',
      'quantity': '200 g',
      'recipe': 'Spaghetti Bolognese',
      'isRecipe' : true,
      'value': false,
    },
    {
      'label': 'Tomatoes',
      'quantity': '200 g',
      'recipe': '',
      'isRecipe' : false,
    'value': false,
    },
    {
      'label': 'Chilli Flakes',
      'quantity': '50 g',
      'recipe': '',
      'isRecipe' : false,
    'value': false,
    },
    {
      'label': 'Apples',
      'quantity': '5',
      'recipe': 'Fruit Bowl',
      'isRecipe' : true,
      'value': false,
    },
  ];

  List<Map<String, Object>> shopListChecked = [
    {
      'label': 'Flour',
      'quantity': '200 g',
      'recipe': 'Spaghetti Bolognese',
      'isRecipe' : true,
      'value': true,
    },
    {
      'label': 'Onion',
      'quantity': '200 g',
      'recipe': '',
      'isRecipe' : false,
      'value': true,
    },
    {
      'label': 'Sunflower Oil',
      'quantity': '5 l',
      'recipe': '',
      'isRecipe' : false,
      'value': true,
    },
    {
      'label': 'Oranges',
      'quantity': '5',
      'recipe': 'Fruit Bowl',
      'isRecipe' : true,
      'value': true,
    },
  ];
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShoppingList> {
  void reorderData(int oldindex, int newindex){
    setState(() {
      if(newindex>oldindex){
        newindex-=1;
      }
      final items =widget.shopList.removeAt(oldindex);
      widget.shopList.insert(newindex, items);
    });
  }

  void sorting(){
    setState(() {
      widget.shopList.sort();
    });
  }


  @override
  Widget build(BuildContext context) {

    void _handleCheck(bool newValue)
    {
      setState(() {


      }
      );
    }

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
                        child: ReorderableListView(
                          children: <Widget>[
                            for(final list in widget.shopList)

                              ShopListWidget(
                                key:ValueKey(list),
                              label:
                              list['label'].toString(),
                              quantity: list['quantity'].toString(),
                              recipe: list['recipe'].toString(),
                              isRecipe: list['isRecipe'].toString().toLowerCase() == 'true',
                                value: list['value'].toString().toLowerCase() == 'true',
                                  labelColor: Colors.black87
                              ),
                            for(final list in widget.shopListChecked)

                              ShopListWidget(
                                  key:ValueKey(list),
                                  label:list['label'].toString(),
                                  quantity: list['quantity'].toString(),
                                  recipe: list['recipe'].toString(),
                                  isRecipe: list['isRecipe'].toString().toLowerCase() == 'true',
                                  value: list['value'].toString().toLowerCase() == 'true',
                                labelColor: Colors.teal,
                              ),

                          ],
                          onReorder: reorderData,


                            )))
              ],
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //_showMaterialDialog();
            // Add your onPressed code here!
          },

          child: const Icon(Icons.add, size:30.0),
        ));
  }
}
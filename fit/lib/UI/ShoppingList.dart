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
                        child: Column(
                          children: <Widget>[
                        ListView.builder(
                        shrinkWrap: true,
                            itemCount: widget.shopList.length,
                            itemBuilder: (context, index) {
                              return ShopListWidget(
                                  key:ValueKey(widget.shopList[index]),
                                  label:
                                  widget.shopList[index]['label'].toString(),
                                  quantity: widget.shopList[index]['quantity'].toString(),
                                  recipe: widget.shopList[index]['recipe'].toString(),
                                  isRecipe: widget.shopList[index]['isRecipe'].toString().toLowerCase() == 'true',
                                  value: widget.shopList[index]['value'].toString().toLowerCase() == 'true',
                                  labelColor: Colors.black87,
                                  onValueChanged: (){
                                    setState((){
                                      Map<String, Object> shopListItem = widget.shopList.removeAt(index);
                                      shopListItem["value"] = true;
                                      widget.shopListChecked.add(shopListItem);
                                      // print(widget.shopListChecked);
                                      // print(widget.shopList);
                                    });
                                  },
                              );
                            }),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.shopListChecked.length,
                                itemBuilder: (context, index) {
                                  return ShopListWidget(
                                      key:ValueKey(widget.shopListChecked[index]),
                                      label:
                                      widget.shopListChecked[index]['label'].toString(),
                                      quantity: widget.shopListChecked[index]['quantity'].toString(),
                                      recipe: widget.shopListChecked[index]['recipe'].toString(),
                                      isRecipe: widget.shopListChecked[index]['isRecipe'].toString().toLowerCase() == 'true',
                                      value: widget.shopListChecked[index]['value'].toString().toLowerCase() == 'true',
                                      labelColor: Colors.black87,
                                      onValueChanged: (index){

                                      },
                                  );
                                })
                          ]
                        )



            )),]),),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      //_showMaterialDialog();
                      // Add your onPressed code here!
                    },

                    child: const Icon(Icons.add, size:30.0),
                  )
    );
  }
}
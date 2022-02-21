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


    _dismissDialog() {
      Navigator.pop(context);
    }

    void _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Add item', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87), textAlign:TextAlign.center),
              content:  Container(

                  child: Column(
                  children:<Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Item name: ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87, letterSpacing: 0.5),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          obscureText: false,

                          decoration: InputDecoration(
                            isDense: true,

                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: (Colors.grey[400])!,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: (Colors.grey[400])!)),
                          ),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                          onChanged: (val) {
                            ;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 20.0
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Quantity: ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87, letterSpacing: 0.5),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          obscureText: false,

                          decoration: InputDecoration(
                            isDense: true,

                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: (Colors.grey[400])!,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: (Colors.grey[400])!)),
                          ),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                          onChanged: (val) {
                            ;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Unit: ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87, letterSpacing: 0.5),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          obscureText: false,

                          decoration: InputDecoration(
                            isDense: true,

                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: (Colors.grey[400])!,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: (Colors.grey[400])!)),
                          ),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                          onChanged: (val) {
                            ;
                          },
                        ),
                      ],
                    ),

                  ]
              )),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Save',style: TextStyle(fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
                ),
                MaterialButton(
                    onPressed: () {
                    _dismissDialog();
                    },
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                    child: const Text('Cancel', style: TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                )

              ],
            );
          });
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
                              )

                          ],
                          onReorder: reorderData,


                            )))
              ],
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showMaterialDialog();
            // Add your onPressed code here!
          },

          child: const Icon(Icons.add, size:30.0),
        ));
  }
}
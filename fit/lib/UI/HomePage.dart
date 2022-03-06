import 'dart:ui';
import 'package:flutter/material.dart';

import 'FoodInventory.dart';
import 'RecipePage.dart';
import 'ShoppingList.dart';
// import 'FoodWaste.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List _pages = [FoodInventory(), RecipePage(), ShoppingList(), FoodInventory()];
  final List titles = [
    'Food Inventory',
    'Recipe Recommendation',
    'Shopping List',
    'Food Waste'
  ];

  // Icon customIcon = const Icon(Icons.search, size: 20.0,);
  // bool searchFlag = false;


  @override
  Widget build(BuildContext context) {
    // Widget customSearchBar;
    // bool showBackButton;
    // bool centerTitle = true;
    //
    // if(searchFlag == false){
    //   customSearchBar = Text(titles[_currentIndex], style: Theme.of(context).textTheme.subtitle1);
    //   customIcon = const Icon(Icons.search, size: 22.0);
    //   showBackButton = true;
    //   centerTitle = true;
    // }else{
    //   centerTitle = false;
    //   showBackButton = false;
    //   customIcon = const Icon(Icons.cancel, size:22.0);
    //   customSearchBar = const ListTile(
    //     leading: Icon(
    //       Icons.search,
    //       color: Colors.white,
    //       size: 22,
    //     ),
    //     title: TextField(
    //       decoration: InputDecoration(
    //         // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    //         hintText: 'Search inventory',
    //         hintStyle: TextStyle(
    //             fontSize: 13.0,
    //             fontWeight: FontWeight.w100,
    //             color: Colors.white,
    //         ),
    //         border: InputBorder.none,
    //       ),
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //   );
    // }


    return Scaffold(
          appBar: AppBar(
            title: Text(titles[_currentIndex], style: Theme.of(context).textTheme.subtitle1),
            // automaticallyImplyLeading: showBackButton,
            // title: customSearchBar,
            // centerTitle: centerTitle,
            centerTitle: true,
            actions: _currentIndex == 0 ? <Widget>[
              IconButton(
                  onPressed: (){
                    showSearch(context: context, delegate: InventorySearch());
                  },
                  icon: const Icon(Icons.search)
              )
            ] : []
            // actions: _currentIndex == 0 ? [
            //   IconButton(
            //     onPressed: (){
            //       setState(() {
            //         if (customIcon.icon == Icons.search) {
            //           searchFlag = true;
            //         } else {
            //           searchFlag = false;
            //         }
            //       });
            //     },
            //     icon: customIcon,
            //   ),
            // ] : [],
          ),
          body: _pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: "Inventory",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_rounded),
                label: "Recipes",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: "Shopping List",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: "Food Waste",
              ),
            ],
          ),
        );
  }

  void onTabTapped(int index) {
    // searchFlag = false;
    setState(() {
      _currentIndex = index;
    });
  }
}
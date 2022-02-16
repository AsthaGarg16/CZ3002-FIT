import 'dart:ui';
import 'package:flutter/material.dart';

import 'FoodInventory.dart';
import 'RecipePage.dart';
// import 'ShoppingList.dart';
// import 'FoodWaste.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;
  final List _pages = [FoodInventory(), RecipePage(), FoodInventory(), FoodInventory()];
  final List titles = [
    'Food Inventory',
    'Recipe Recommendation',
    'Shopping List',
    'Food Waste'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(titles[_currentIndex]),
            centerTitle: true
          ),
          body: _pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: "Food Inventory",
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
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
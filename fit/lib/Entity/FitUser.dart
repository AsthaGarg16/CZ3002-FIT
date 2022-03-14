import 'package:fit/Entity/FoodRecord.dart';
import 'package:fit/Entity/ShoppingList.dart';

import 'Inventory.dart';
// need to check if date of birth and target range have been added to account details, profilepage and food preference
/// Entity representing the user, their personal details, and the logbooks, plans and reminders associated with them.
class FitUser {

  String _email;
  String _name;
  int  _fridgeDetails;
  bool _dairyFree;
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  late Inventory _inv;
  late ShoppingList _shop;

  Inventory get inv => _inv;

  set inv(Inventory value) {
    _inv = value;
  }

  ShoppingList get shop => _shop;

  set shop(ShoppingList value) {
    _shop = value;
  }

  FitUser({
    String name = " ",
    String email = " ",
    int fridgeDetails = 10,
    bool dairyFree = false,
    bool glutenFree = false,
    bool vegetarian = false,
    bool vegan = false
})
      : _name = name,
        _email = email,
       _fridgeDetails=fridgeDetails,
       _dairyFree=dairyFree,
       _glutenFree=glutenFree,
       _vegan=vegan,
       _vegetarian=vegetarian;


  String get name => _name;

  set name(String value) {
    _name = value;
  }


  String get email => _email;

  set email(String value) {
    _email = value;
  }

  int get fridgeDetails => _fridgeDetails;

  set fridgeDetails(int value) {
    _fridgeDetails = value;
  }

  bool get dairyFree => _dairyFree;

  set dairyFree(bool value) {
    _dairyFree = value;
  }

  bool get glutenFree => _glutenFree;

  set glutenFree(bool value) {
    _glutenFree = value;
  }

  bool get vegetarian => _vegetarian;

  set vegetarian(bool value) {
    _vegetarian = value;
  }

  bool get vegan => _vegan;

  set vegan(bool value) {
    _vegan = value;
  }
}

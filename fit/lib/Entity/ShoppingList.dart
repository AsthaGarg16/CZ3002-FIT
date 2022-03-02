import '../../Entity/FoodItem.dart';

class ShoppingList {
  String _email;
  List<FoodItem> _foodlist;

  ShoppingList(
      String email,
      List<FoodItem> foodlist
      )
      : _email = email,
      _foodlist = foodlist;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  List<FoodItem> get foodlist => _foodlist;

  set fooditem(List<FoodItem> value) {
    _foodlist = value;
  }
}

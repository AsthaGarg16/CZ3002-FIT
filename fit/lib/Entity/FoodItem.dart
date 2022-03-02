class FoodItem {

  String _name;
  int  _quantity;
  String _unit;
  bool _status;
  bool _inventory_status;
  bool _from_saved_recipes;
  String _recipeID;

  FoodItem(
      String name,
      int quantity,
      String unit,
      bool status,
      bool inventory_status,
      bool from_saved_recipes,
      String recipe_ID
      )
      : _name = name,
        _quantity = quantity,
        _unit = unit,
        _status = status,
        _inventory_status = inventory_status,
        _from_saved_recipes = from_saved_recipes,
        _recipeID = recipe_ID;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  String get unit => _unit;

  set unit(String value) {
    _unit = value;
  }

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  bool get inventory_status => _inventory_status;

  set inventory_status(bool value) {
    _inventory_status = value;
  }

  bool get from_saved_recipes => _from_saved_recipes;

  set from_saved_recipes(bool value) {
    _from_saved_recipes = value;
  }

  String get recipeID => _recipeID;

  set recipeID(String value) {
    _recipeID = value;
  }
}

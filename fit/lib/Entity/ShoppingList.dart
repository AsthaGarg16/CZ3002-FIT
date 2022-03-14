import '../../Entity/FoodItem.dart';

class ShoppingList {
  // String _email;
  List<FoodItem> _FoodItemList;

  ShoppingList(
      // String email,
      List<FoodItem> FoodItemList
      )
      // : _email = email,
         : _FoodItemList = FoodItemList;

  // String get email => _email;
  //
  // set email(String value) {
  //   _email = value;
  // }

  List<FoodItem> get FoodItemList => _FoodItemList;

  set FoodItemList(List<FoodItem> value) {
    _FoodItemList = value;
  }

  void addRecord(String name, int quantity, String unit, bool status, bool inventory_status, bool from_saved_recipes,
      int quantity_from_saved, String recipe_ID) {
    if (_FoodItemList == null)
      _FoodItemList = <FoodItem>[];

    FoodItem foodItem= FoodItem(name, quantity, unit, status, inventory_status,from_saved_recipes,quantity_from_saved,recipe_ID);
    _FoodItemList.add(foodItem);
  }

  void deleteRecord(String name,String recipe_ID) {

    for(var fR in _FoodItemList){
      if (fR.name==name && fR.recipe_ID== recipe_ID){

        _FoodItemList.remove(fR);
        return;

      }
    }
  }

  void updateRecord(String name, int quantity, String unit,bool status, bool inventory_status, bool from_saved_recipes,
      int quantity_from_saved, String recipe_ID) {

    for(var fR in _FoodItemList){
      if (fR.name==name && fR.recipe_ID== recipe_ID){
        fR.quantity=quantity;
        fR.recipe_ID=recipe_ID;
        fR.status=status;
        fR.inventory_status = inventory_status;

      }
    }
  }
}

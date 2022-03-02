
import 'package:fit/Entity/RecipeRecord.dart';

class RecipeRec {
  String _email;
  List<RecipeRecord> _recipeItems;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  RecipeRec(
      String email,
      List<RecipeRecord> recipeItems
      )
      : _email = email,
        _recipeItems= recipeItems;

  List < RecipeRecord > get recipeItems => _recipeItems;

  set recipeItems(List<RecipeRecord> value) {
    _recipeItems = value;
  }

  // inventoryMgr class- update to firebase, entity call and image retrieval will be done there
  void addRecord(String email, String recipeName, int recipeId, String recipeIngredient) {
    if (_recipeItems == null)
      _recipeItems = <RecipeRecord>[];

    RecipeRecord recipeRecord= RecipeRecord( email, recipeName, recipeId, recipeIngredient);
    _recipeItems.add(recipeRecord);
  }

  void deleteRecord(String recipeId) {

    for(var fR in _recipeItems){
      if (fR.recipeId==recipeId){

        _recipeItems.remove(fR);
        return;

      }
    }
  }

  void updateRecord(String recipeName, int recipeId, String recipeIngredient) {

    for(var fR in _recipeItems){
      if (fR.recipeId==recipeId ){
        fR.recipeName=recipeName;
        fR.recipeIngredient=recipeIngredient;
      }
    }
  }

}

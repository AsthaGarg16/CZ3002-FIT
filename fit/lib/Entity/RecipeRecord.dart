import 'package:fit/Entity/FoodRecord.dart';

class RecipeRecord {
  int _recipeId;
  String  _recipeName;
  String _recipeIngredient;
  String _email;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get recipeName => _recipeName;

  set recipeName(String value){
    _recipeName = value;
  }

  RecipeRecord(
      String email,
      String recipeName,
      int recipeId,
      String recipeIngredient
      )
      : _email = email,
        _recipeName = recipeName,
        _recipeId = recipeId,
        _recipeIngredient = recipeIngredient;


  int get recipeId => _recipeId;

  set recipeId(int value){
    _recipeId = value;
  }

  String get recipeIngredient => _recipeIngredient;

  set recipeIngredient(String value){
    _recipeIngredient = value;
  }


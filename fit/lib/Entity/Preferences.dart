class Preferences {

  bool _vegetarian;
  bool _vegan;
  bool _glutenFree;
  bool _dairyFree;
  String _carbs;
  String _protein;
  String _calories;

  Preferences(bool vegetarian, bool vegan, bool glutenFree, bool dairyFree,
      String carbs, String protein, String calories):
      _vegetarian = vegetarian,
  _vegan = vegan,
  _glutenFree = glutenFree,
  _dairyFree = dairyFree,
  _carbs = carbs,
  _protein = protein,
  _calories = calories;

  bool get vegetarian => _vegetarian;

  bool get vegan => _vegan;

  bool get glutenFree => _glutenFree;

  bool get dairyFree => _dairyFree;

  String get carbs => _carbs;

  String get protein => _protein;

  String get calories => _calories;

}
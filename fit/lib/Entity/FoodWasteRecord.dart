
class FoodWasteRecord {
  String _name;
  String _unit;

  String get unit => _unit;

  set unit(String value) {
    _unit = value;
  }

  int  _quantity;
  String _thrownDate;


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  FoodWasteRecord(
      String name,
      int quantity,
      String unit,
      String thrownDate,

      )
      : _name = name,
        _quantity = quantity,
        _unit=unit,
        _thrownDate=thrownDate;

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  String get thrownDate => _thrownDate;

  set thrownDate(String value) {
    _thrownDate = value;
  }
}

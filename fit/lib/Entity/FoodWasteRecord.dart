
class FoodWasteRecord {
  String _name;
  int  _quantity;
  DateTime _thrownDate;


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  FoodWasteRecord(
      String name,
      int quantity,
      DateTime thrownDate,

      )
      : _name = name,
        _quantity = quantity,
        _thrownDate=thrownDate;

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  DateTime get thrownDate => _thrownDate;

  set thrownDate(DateTime value) {
    _thrownDate = value;
  }
}

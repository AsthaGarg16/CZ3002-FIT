
// need to check if date of birth and target range have been added to account details, profilepage and food preference

class FoodRecord {
  String _name;
  int  _quantity;
  String _unit;
  DateTime _expiryDate;
  String _imageUrl;
  int _compNum;

  int get compNum => _compNum;

  set compNum(int value) {
    _compNum = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  FoodRecord(
      String name,
      int quantity,
      String unit,
      DateTime expiryDate,
  int compNumber,
  String imageUrl
      )
      : _name = name,
        _quantity = quantity,
        _unit=unit,
        _expiryDate=expiryDate,
        _imageUrl=imageUrl,
        _compNum=compNumber;

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  String get unit => _unit;

  set unit(String value) {
    _unit = value;
  }

  DateTime get expiryDate => _expiryDate;

  set expiryDate(DateTime value) {
    _expiryDate = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }
}

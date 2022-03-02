


import 'package:fit/Entity/FoodWasteRecord.dart';

class FoodWasteList {
  String _email;
  List<FoodWasteRecord> _foodWasteRecords;

  List<FoodWasteRecord> get foodWasteRecords => _foodWasteRecords;

  set foodWasteRecords(List<FoodWasteRecord> value) {
    _foodWasteRecords = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  FoodWasteList(
      String email,
      List<FoodWasteRecord> foodWasteRecords
      )
      : _email = email,
        _foodWasteRecords=foodWasteRecords;



  // inventoryMgr class- update to firebase, entity call and image retrieval will be done there
  void addRecord(String name, int quantity, DateTime thrownDate,) {
    if (_foodWasteRecords == null)
      _foodWasteRecords = <FoodWasteRecord>[];

    FoodWasteRecord foodWasteRecord= FoodWasteRecord(name, quantity,thrownDate);
    foodWasteRecords.add(foodWasteRecord);
  }


  }






}

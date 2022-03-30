


import 'package:fit/Entity/FoodWasteRecord.dart';

class FoodWasteList {
  // String _email;
  List<FoodWasteRecord> _foodWasteRecords;

  List<FoodWasteRecord> get foodWasteRecords => _foodWasteRecords;

  set foodWasteRecords(List<FoodWasteRecord> value) {
    _foodWasteRecords = value;
  }

  // String get email => _email;
  //
  // set email(String value) {
  //   _email = value;
  // }

  FoodWasteList(
      List<FoodWasteRecord> foodWasteRecords
      )
      :
        _foodWasteRecords=foodWasteRecords;



  // inventoryMgr class- update to firebase, entity call and image retrieval will be done there
  void addRecord(String name, int quantity, String unit, String thrownDate) {
    if (_foodWasteRecords == null)
      _foodWasteRecords = <FoodWasteRecord>[];

    FoodWasteRecord foodWasteRecord= FoodWasteRecord(name, quantity, unit, thrownDate);
    foodWasteRecords.add(foodWasteRecord);
  }


  }


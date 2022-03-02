


import 'package:fit/Entity/FoodRecord.dart';

class Inventory {
  String _email;
  List<FoodRecord> _inventoryItems;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  Inventory(
      String email,
      List<FoodRecord> inventoryItems
      )
      : _email = email,
        _inventoryItems=inventoryItems;

  List < FoodRecord > get inventoryItems => _inventoryItems;

  set inventoryItems(List<FoodRecord> value) {
    _inventoryItems = value;
  }

  // inventoryMgr class- update to firebase, entity call and image retrieval will be done there
  void addRecord(String name, int quantity, String unit, DateTime expiryDate, int compNumber, String imageUrl) {
    if (_inventoryItems == null)
      _inventoryItems = <FoodRecord>[];

    FoodRecord foodRecord= FoodRecord(name, quantity, unit, expiryDate, compNumber,imageUrl);
    _inventoryItems.add(foodRecord);
  }

  void deleteRecord(String name,DateTime expiryDate) {

    for(var fR in _inventoryItems){
      if (fR.name==name && fR.expiryDate==expiryDate){

        _inventoryItems.remove(fR);
        return;

      }
    }
  }

  void updateRecord(String name, int quantity, String unit, DateTime expiryDate, int compNumber) {

    for(var fR in _inventoryItems){
      if (fR.name==name && fR.expiryDate==expiryDate){
        fR.quantity=quantity;
        fR.expiryDate=expiryDate;
        fR.compNum=compNumber;

      }
    }
  }






}

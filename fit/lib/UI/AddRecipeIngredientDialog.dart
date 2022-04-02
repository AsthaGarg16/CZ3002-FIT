import 'package:flutter/material.dart';
import '../Entity/Units.dart';
import '../Controller/services/UserController.dart';
import '../Controller/services/ShoppingListController.dart';
import '../Entity/FoodItem.dart';

class AddRecipeIngredientDialog extends StatefulWidget {
  String name;
  String quantity;
  String unit;
  int recipeID;
  AddRecipeIngredientDialog(
      {Key? key,
      required this.name,
      required this.quantity,
      required this.unit,
      required this.recipeID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddRecipeIngredientDialog();
  }
}

class _AddRecipeIngredientDialog extends State<AddRecipeIngredientDialog> {
  String title = "Add item";
  String okBtnText = "Save";
  String cancelBtnText = "Cancel";
  String? chosenValue;
  String _unit = Units.units[0];

  final GlobalKey<FormState> _dialogformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        //height: 320,
        child: Column(children: <Widget>[
          Form(
            key: _dialogformKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Item name: ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              initialValue: widget.name,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: (Colors.grey[400])!,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: (Colors.grey[400])!)),
                              ),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return "Please enter the name of the item";
                                }

                                return null;
                              },
                              onChanged: (val) {
                                setState(() => widget.name = val);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Quantity: ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              initialValue: widget.quantity,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: (Colors.grey[400])!,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: (Colors.grey[400])!)),
                              ),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return "Please enter the quantity";
                                }
                                if (value != null &&
                                    double.parse(value) == null) {
                                  return "Please enter numeric quantity";
                                }

                                return null;
                              },
                              onChanged: (val) {
                                setState(() => widget.quantity = val);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Unit: ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField<String>(
                                value: _unit,
                                //elevation: 5,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                                items: Units.units
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          fontFamily: "mw",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    ),
                                  );
                                }).toList(),
                                hint: const Text(
                                  "Please choose a unit",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    chosenValue = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ]),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () async {
            print(_unit);
            print(chosenValue);
            FoodItem newItem = FoodItem(
                widget.name,
                int.parse(widget.quantity),
                chosenValue!,
                false,
                false,
                true,
                int.parse(widget.quantity),
                widget.recipeID.toString());
            ShoppingListController.addFoodItem(
                UserController.getCurrentUserEmail(),
                newItem.name,
                newItem.quantity,
                newItem.unit,
                newItem.status,
                newItem.inventory_status,
                newItem.from_saved_recipes,
                newItem.quantity_from_saved,
                newItem.recipe_ID);
            Navigator.pop(context, newItem);
            //add to shopping list
          },
          color: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(okBtnText,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(cancelBtnText,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        )
      ],
    );
  }
}

// showCustomDialog(BuildContext context,
//       { }) {

//     FoodItem newItem ;
//     String _name="";
//     int  _quantity=0;
//     String _unit = Units.units[0];
//     String? chosenValue;
//     bool _status=false;
//     bool _inventory_status=false;
//     bool _from_saved_recipes=false;
//     int _quantity_from_saved = 0;
//     String _recipe_ID="0";

// //here
//     Future futureValue = showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AddItemDialog;
//         }
//     );

//     return futureValue.then( (value) {

//       Map<String,Object> newObj = {
//         'label': value.name,
//         'quantity': value.quantity.toString() +" "+value.unit,
//         'recipe': '',
//         'isRecipe' : false,
//         'value': false,
//       };

//       //add to db
//       setState(() {
//           shopList.add(newObj);

//       });

//       print(value);

//     });

//   }
import 'package:flutter/material.dart';
import '../../Entity/Preferences.dart';

class FilterCheckbox extends StatefulWidget {
  Preferences preference;

  FilterCheckbox({
    Key? key,
    required this.preference,
  }) : super(key: key);

  @override
  State<FilterCheckbox> createState() => _FilterCheckboxState();
}

class _FilterCheckboxState extends State<FilterCheckbox> {
  late List<Map> dietaryPrefList;
  late String carbsDropdownValue;
  late String proteinDropdownValue;
  late String calDropdownValue;
  @override
  void initState() {
    dietaryPrefList = [
      {
        "pref": "Vegetarian",
        "isChecked": widget.preference.vegetarian,
        "text": "Vegetarian"
      },
      {"pref": "Vegan", "isChecked": widget.preference.vegan, "text": "Vegan"},
      {
        "pref": "Dairy Free",
        "isChecked": widget.preference.dairyFree,
        "text": "Dairy Free"
      },
      {
        "pref": "Gluten Free",
        "isChecked": widget.preference.glutenFree,
        "text": "Gluten Free"
      },
    ];
    carbsDropdownValue = widget.preference.carbs;
    calDropdownValue = widget.preference.calories;
    proteinDropdownValue = widget.preference.protein;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return SimpleDialog(
        title: Text(
          "Select Preferences",
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(
              height: 400.00,
              width: 300.00,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("Carbohydrate: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Spacer(),
                      DropdownButton<String>(
                        value: carbsDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.teal),
                        underline: Container(
                          height: 2,
                          color: Colors.teal,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            carbsDropdownValue = newValue!;
                          });
                        },
                        items: <String>['Any', 'Low', 'Medium', 'High']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Protein: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Spacer(),
                      DropdownButton<String>(
                        value: proteinDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.teal),
                        underline: Container(
                          height: 2,
                          color: Colors.teal,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            proteinDropdownValue = newValue!;
                          });
                        },
                        items: <String>['Any', 'Low', 'Medium', 'High']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Calories: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Spacer(),
                      DropdownButton<String>(
                        value: calDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.teal),
                        underline: Container(
                          height: 2,
                          color: Colors.teal,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            calDropdownValue = newValue!;
                          });
                        },
                        items: <String>['Any', 'Low', 'Medium', 'High']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: CheckboxListTile(
                              value: dietaryPrefList[index]["isChecked"],
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              subtitle: Text(
                                dietaryPrefList[index]["text"],
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  dietaryPrefList[index]["isChecked"] =
                                      newValue;
                                });
                              },
                            ),
                          ));
                    },
                  )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Map preferenceList = {};
                          bool vegetarianIsChecked = false;
                          bool veganIsChecked = false;
                          bool dairyFreeIsChecked = false;
                          bool glutenFreeIsChecked = false;

                          for (Map pref in dietaryPrefList) {
                            if (pref["pref"] == "Vegetarian") {
                              vegetarianIsChecked = pref["isChecked"];
                            }
                            if (pref["pref"] == "Vegan") {
                              veganIsChecked = pref["isChecked"];
                            }
                            if (pref["pref"] == "Dairy Free") {
                              dairyFreeIsChecked = pref["isChecked"];
                            }
                            if (pref["pref"] == "Gluten Free") {
                              glutenFreeIsChecked = pref["isChecked"];
                            }
                          }
                          Preferences userPref = Preferences(
                              vegetarianIsChecked,
                              veganIsChecked,
                              glutenFreeIsChecked,
                              dairyFreeIsChecked,
                              carbsDropdownValue,
                              proteinDropdownValue,
                              calDropdownValue);
                          // preferenceList["Calories"] = calDropdownValue;
                          // preferenceList["Carbs"] = carbsDropdownValue;
                          // preferenceList["Protein"] = proteinDropdownValue;
                          print(preferenceList);
                          Navigator.pop(context, userPref);
                        },
                        child: const Text("Filter",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ))
                ],
              ))
        ]);
  }
}

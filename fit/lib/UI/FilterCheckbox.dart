import 'package:flutter/material.dart';

class FilterCheckbox extends StatefulWidget {
  const FilterCheckbox({Key? key}) : super(key: key);

  @override
  State<FilterCheckbox> createState() => _FilterCheckboxState();
}

class _FilterCheckboxState extends State<FilterCheckbox> {
  List<Map> dietaryPrefList = [
    {"pref": "Vegetarian", "isChecked": false, "text": "Vegetarian"},
    {"pref": "Vegan", "isChecked": false, "text": "Vegan"},
    {"pref": "Dairy Free", "isChecked": false, "text": "Dairy Free"},
    {"pref": "Gluten Free", "isChecked": false, "text": "Gluten Free"},
  ];
  String carbsDropdownValue = 'Any';
  String calDropdownValue = 'Any';
  String proteinDropdownValue = 'Any';

  // List<FoodPreference> preferenceList = [
  //   FoodPreference("Saved Recipes", false, "Saved Recipes"),
  //   FoodPreference("Vegetarian", false, "Vegetarian"),
  //   FoodPreference("Vegan", false, "Vegan"),
  //   FoodPreference("Dairy Free", false, "Dairy Free"),
  //   FoodPreference("Gluten Free", false, "Gluten Free"),
  //   FoodPreference("Low Carb", false, "Low"),
  //   FoodPreference("Medium Carb", false, "Medium"),
  //   FoodPreference("High Carb", false, "High"),
  //   FoodPreference("Low Protein", false, "Low"),
  //   FoodPreference("Medium Protein", false, "Medium"),
  //   FoodPreference("High Protein", false, "High"),
  //   FoodPreference("Low Calorie", false, "Low"),
  //   FoodPreference("Medium Calorie", false, "Medium"),
  //   FoodPreference("High Calorie", false, "High"),
  // ];

  List<FoodPreference> finalPref = [];

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
        title: const Text("Select Preferences"),
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
                      Text("Carbohydrate",
                          style: Theme.of(context).textTheme.labelMedium),
                      Spacer(),
                      DropdownButton<String>(
                        value: carbsDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
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
                      Text("Protein",
                          style: Theme.of(context).textTheme.labelMedium),
                      Spacer(),
                      DropdownButton<String>(
                        value: proteinDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
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
                      Text("Calories",
                          style: Theme.of(context).textTheme.labelMedium),
                      Spacer(),
                      DropdownButton<String>(
                        value: calDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
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
                          for (Map pref in dietaryPrefList) {
                            if (pref["pref"] == "Vegetarian") {
                              preferenceList["Vegetarian"] = pref["isChecked"];
                            }
                            if (pref["pref"] == "Vegan") {
                              preferenceList["Vegan"] = pref["isChecked"];
                            }
                            if (pref["pref"] == "Dairy Free") {
                              preferenceList["Dairy Free"] = pref["isChecked"];
                            }
                            if (pref["pref"] == "Gluten Free") {
                              preferenceList["Gluten Free"] = pref["isChecked"];
                            }
                          }
                          preferenceList["Calories"] = calDropdownValue;
                          preferenceList["Carbs"] = carbsDropdownValue;
                          preferenceList["Protein"] = proteinDropdownValue;
                          print(preferenceList);
                          Navigator.pop(context, preferenceList);
                        },
                        child: const Text("Filter"),
                      ))
                ],
              ))
        ]);
  }
}

// CheckboxListTile(
//                       value: preferenceList[index]["isChecked"],
//                       contentPadding: EdgeInsets.all(0),
//                       controlAffinity: ListTileControlAffinity.leading,
//                       title: Text(
//                         preferenceList[index]["text"],
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                       onChanged: (newValue) {
//                   8      setState(() {
//                           preferenceList[index]["isChecked"] = newValue;
//                         });
//                       },
//                     )

class FoodPreference {
  late String pref;
  late bool isChecked;
  late String text;
  FoodPreference(String pref, bool isChecked, String text) {
    this.pref = pref;
    this.isChecked = isChecked;
    this.text = text;
  }
}

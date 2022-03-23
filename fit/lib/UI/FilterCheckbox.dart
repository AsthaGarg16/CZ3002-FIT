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
  List<Map> carbPrefList = [
    {"pref": "Low Carb", "isChecked": false, "text": "Low"},
    {"pref": "Medium Carb", "isChecked": false, "text": "Medium"},
    {"pref": "High Carb", "isChecked": false, "text": "High"},
  ];
  List<Map> proteinPrefList = [
    {"pref": "Low Protein", "isChecked": false, "text": "Low"},
    {"pref": "Medium Protein", "isChecked": false, "text": "Medium"},
    {"pref": "High Protein", "isChecked": false, "text": "High"},
  ];
  List<Map> caloriePrefList = [
    {"pref": "Low Calorie", "isChecked": false, "text": "Low"},
    {"pref": "Medium Calorie", "isChecked": false, "text": "Medium"},
    {"pref": "High Calorie", "isChecked": false, "text": "High"},
  ];

  List<FoodPreference> preferenceList = [
    FoodPreference("Saved Recipes", false, "Saved Recipes"),
    FoodPreference("Low Carb", false, "Low"),
    FoodPreference("Medium Carb", false, "Medium"),
    FoodPreference("High Carb", false, "High"),
    FoodPreference("Low Protein", false, "Low"),
    FoodPreference("Medium Protein", false, "Medium"),
    FoodPreference("High Protein", false, "High"),
    FoodPreference("Low Calorie", false, "Low"),
    FoodPreference("Medium Calorie", false, "Medium"),
    FoodPreference("High Calorie", false, "High"),
    FoodPreference("Vegetarian", false, "Vegetarian"),
    FoodPreference("Vegan", false, "Vegan"),
    FoodPreference("Dairy Free", false, "Dairy Free"),
    FoodPreference("Gluten Free", false, "Gluten Free")
  ];

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

    return SimpleDialog(title: const Text("Select Preferences"), children: <
        Widget>[
      Container(
          height: 400.00,
          width: 500.00,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Carbohydrate",
                  style: Theme.of(context).textTheme.labelMedium),
              Expanded(
                  child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.1),
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    value: carbPrefList[index]["isChecked"],
                    contentPadding: EdgeInsets.all(0),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      carbPrefList[index]["text"],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        carbPrefList[index]["isChecked"] = newValue;
                      });
                    },
                  );
                },
              )),
              Text("Protein", style: Theme.of(context).textTheme.labelMedium),
              Expanded(
                  child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    value: proteinPrefList[index]["isChecked"],
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      proteinPrefList[index]["text"],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        proteinPrefList[index]["isChecked"] = newValue;
                      });
                    },
                  );
                },
              )),
              Text("Calories", style: Theme.of(context).textTheme.labelMedium),
              Expanded(
                  child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    value: caloriePrefList[index]["isChecked"],
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      caloriePrefList[index]["text"],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        caloriePrefList[index]["isChecked"] = newValue;
                      });
                    },
                  );
                },
              )),
              Expanded(
                  child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                    width: 30,
                    child: CheckboxListTile(
                      value: dietaryPrefList[index]["isChecked"],
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: Text(
                        dietaryPrefList[index]["text"],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          dietaryPrefList[index]["isChecked"] = newValue;
                        });
                      },
                    ),
                  );
                },
              )),
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

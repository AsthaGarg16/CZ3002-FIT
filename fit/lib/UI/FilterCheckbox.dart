import 'package:flutter/material.dart';

class FilterCheckbox extends StatefulWidget {
  const FilterCheckbox({Key? key}) : super(key: key);

  @override
  State<FilterCheckbox> createState() => _FilterCheckboxState();
}

class _FilterCheckboxState extends State<FilterCheckbox> {
  List<Map> preferenceList = [
    {"pref": "Low Carb", "isChecked": false, "text": "Low"},
    {"pref": "Medium Carb", "isChecked": false, "text": "Medium"},
    {"pref": "High Carb", "isChecked": false, "text": "High"},
    {"pref": "Low Protein", "isChecked": false, "text": "Low"},
    {"pref": "Medium Protein", "isChecked": false, "text": "Medium"},
    {"pref": "High Protein", "isChecked": false, "text": "High"},
    {"pref": "Low Calorie", "isChecked": false, "text": "Low"},
    {"pref": "Medium Calorie", "isChecked": false, "text": "Medium"},
    {"pref": "High Calorie", "isChecked": false, "text": "High"},
    {"pref": "Vegetarian", "isChecked": false, "text": "Vegetarian"},
    {"pref": "Vegan", "isChecked": false, "text": "Vegan"},
    {"pref": "Dairy Free", "isChecked": false, "text": "Dairy Free"},
    {"pref": "Gluten Free", "isChecked": false, "text": "Gluten Free"},
  ];

  @override
  Widget build(BuildContext context) {
    preferenceList.map((pref) => new CheckboxListTile(value: pref["isChecked"], onChanged: (newValue) {
                        setState(() {
                          preferenceList[index]["isChecked"] = newValue;
                        });
                      },)
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
          width: 550.00,
          child: Column(children: [Text("Carbohydrate")], Row(children: []),)
          )
    ]);
  }
}
CheckboxListTile(
                      value: preferenceList[index]["isChecked"],
                      contentPadding: EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        preferenceList[index]["text"],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          preferenceList[index]["isChecked"] = newValue;
                        });
                      },
                    )
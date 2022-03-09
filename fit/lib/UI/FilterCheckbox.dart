import 'package:flutter/material.dart';

class FilterCheckbox extends StatefulWidget {
  const FilterCheckbox({Key? key}) : super(key: key);

  @override
  State<FilterCheckbox> createState() => _FilterCheckboxState();
}

class _FilterCheckboxState extends State<FilterCheckbox> {
  List<Map> preferenceList = [
    {"pref": "Low Carb", "isChecked": false},
    {"pref": "Medium Carb", "isChecked": false},
    {"pref": "High Carb", "isChecked": false},
    {"pref": "Low Protein", "isChecked": false},
    {"pref": "Medium Protein", "isChecked": false},
    {"pref": "High Protein", "isChecked": false},
    {"pref": "Low Calorie", "isChecked": false},
    {"pref": "Medium Calorie", "isChecked": false},
    {"pref": "High Calorie", "isChecked": false},
    {"pref": "Vegetarian", "isChecked": false},
    {"pref": "Vegan", "isChecked": false},
    {"pref": "Dairy Free", "isChecked": false},
    {"pref": "Gluten Free", "isChecked": false},
  ];

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
        children: <Widget>[
          Container(
              height: 400.00,
              width: 350.00,
              child: GridView.builder(
                  itemCount: preferenceList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    //crossAxisSpacing: 4.0,
                    //mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //preferenceList.map((preference) {
                    return CheckboxListTile(
                      value: preferenceList[index]["isChecked"],
                      contentPadding: EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        preferenceList[index]["pref"],
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          preferenceList[index]["isChecked"] = newValue;
                        });
                      },
                    );
                  }))
        ]);
  }
}

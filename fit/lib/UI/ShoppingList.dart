import 'dart:ui';

import 'package:flutter/material.dart';
import '../Entity/FoodItem.dart';
import '../Entity/Units.dart';
import 'ShopListCard.dart';

class ShoppingList extends StatefulWidget {
  List<String> altItem = ['alt 1', 'alt 2', 'alt 3'];
  List<Map<String, Object>> shopList = [
    {
      'label': 'Spaghetti',
      'quantity': '200 g',
      'recipe': 'Spaghetti Bolognese',
      'isRecipe' : true,
      'value': false,
      'alternatives': List<String>.filled(3,"alternate "),
      'isVisible' :false,
    },
    {
      'label': 'Tomatoes',
      'quantity': '200 g',
      'recipe': '',
      'isRecipe' : false,
    'value': false,
      'alternatives': List<String>.filled(3,"alternate "),
      'isVisible' :false,
    },
    {
      'label': 'Chilli Flakes',
      'quantity': '50 g',
      'recipe': '',
      'isRecipe' : false,
    'value': false,
      'alternatives': List<String>.filled(3,"alternate "),
      'isVisible' :false,
    },
    {
      'label': 'Apples',
      'quantity': '5',
      'recipe': 'Fruit Bowl',
      'isRecipe' : true,
      'value': false,
      'alternatives': List<String>.filled(3,"alternate "),
      'isVisible' :false,
    },
  ];

  List<Map<String, Object>> shopListChecked = [
    {
      'label': 'Flour',
      'quantity': '200 g',
      'recipe': 'Spaghetti Bolognese',
      'isRecipe' : true,
      'value': true,
    },
    {
      'label': 'Onion',
      'quantity': '200 g',
      'recipe': '',
      'isRecipe' : false,
      'value': true,
    },
    {
      'label': 'Sunflower Oil',
      'quantity': '5 l',
      'recipe': '',
      'isRecipe' : false,
      'value': true,
    },
    {
      'label': 'Oranges',
      'quantity': '5',
      'recipe': 'Fruit Bowl',
      'isRecipe' : true,
      'value': true,
    },
  ];

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShoppingList> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        resizeToAvoidBottomInset: false,

        body: Container(
            //height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                    child:SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                        ListView.builder(
                            controller: ScrollController(),
                        shrinkWrap: true,
                            itemCount: widget.shopList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children:<Widget>[
                                      Dismissible(
                                      key: ValueKey(widget.shopList[index]),
                                      onDismissed: (direction) {
                                      setState(() {
                                      Map<String,Object> deletedItem = widget.shopList[index];
                                      String deletedLabel = widget.shopList[index]['label'].toString();
                                      widget.shopList.removeAt(index);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                            duration: const Duration(seconds: 2, milliseconds: 50),
                                            content: Text('$deletedLabel deleted'),
                                            action: SnackBarAction(
                                            label: "UNDO",
                                            onPressed: () => setState(() => widget.shopList.insert(index, deletedItem),) // this is what you needed
                                        )));
                                        }); },
                                        background: Container(color: Colors.redAccent),
                                        child:ShopListWidget(
                                        key:ValueKey(widget.shopList[index]),
                                        label:
                                        widget.shopList[index]['label'].toString(),
                                        quantity: widget.shopList[index]['quantity'].toString(),
                                        recipe: widget.shopList[index]['recipe'].toString(),
                                        isRecipe: widget.shopList[index]['isRecipe'].toString().toLowerCase() == 'true',
                                        value: widget.shopList[index]['value'].toString().toLowerCase() == 'true',
                                        labelColor: Colors.black87,
                                        visible:widget.shopList[index]['isVisible']==true,
                                        onValueChanged: (){
                                        setState((){
                                        Map<String, Object> shopListItem = widget.shopList.removeAt(index);
                                        shopListItem["value"] = true;
                                        widget.shopListChecked.add(shopListItem);
                                        // print(widget.shopListChecked);
                                        // print(widget.shopList);
                                        });
                                        },
                                        onButtonPress: (){
                                          setState((){
                                            print("Changing state");
                                            widget.shopList[index]['isVisible'] = !(widget.shopList[index]['isVisible']==true);
                                          });
                                          },
                                        )),
                                  Visibility(
                                    visible: widget.shopList[index]['isVisible']==true,
                                    replacement:Container(),
                                    maintainState: true,
                                    child:(
                                        ListView.separated(
                                            controller: ScrollController(),
                                            shrinkWrap: true,
                                            itemCount: 2,
                                            itemBuilder:(context, index2)
                                            {
                                                  return Material(
                                                      child: ListTile(
                                                        title: Text("tileItem[index2]", style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.normal,
                                                            color: Colors.black87)),
                                                        dense:true,
                                                      )
                                                  );
                                            },
                                          separatorBuilder: (context, index) {
                                            return const Divider();
                                          },
                                        )
                                    )

                                  )
                                ]
                              );

                            }),
                            ListView.builder(
                                controller: ScrollController(),
                                shrinkWrap: true,
                                itemCount: widget.shopListChecked.length,
                                itemBuilder: (context, index) {
                                  return ShopListWidget(
                                      key:ValueKey(widget.shopListChecked[index]),
                                      label:
                                      widget.shopListChecked[index]['label'].toString(),
                                      quantity: widget.shopListChecked[index]['quantity'].toString(),
                                      recipe: widget.shopListChecked[index]['recipe'].toString(),
                                      isRecipe: widget.shopListChecked[index]['isRecipe'].toString().toLowerCase() == 'true',
                                      value: widget.shopListChecked[index]['value'].toString().toLowerCase() == 'true',
                                      labelColor: Colors.black87,
                                      visible:false,
                                      onButtonPress:(){} ,
                                      onValueChanged: (index){

                                      },
                                  );
                                })
                          ]
                        ))



            ),]),),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      // showCustomDialog(context).then((valueFromDialog){
                      //   // use the value as you wish
                      //   print(valueFromDialog);
                      // });
                      showCustomDialog(context);

                    },

                    child: const Icon(Icons.add, size:30.0),
                  )
    );
  }

  showCustomDialog(BuildContext context,
      {String title = "Add item",
        String okBtnText = "Save",
        String cancelBtnText = "Cancel" }) {

    FoodItem newItem ;
    String _name="";
    int  _quantity=0;
    String _unit = Units.units[0];
    String? chosenValue;
    bool _status=false;
    bool _inventory_status=false;
    bool _from_saved_recipes=false;
    String _recipeID="";

    final GlobalKey<FormState> _dialogformKey = GlobalKey<FormState>();

    AlertDialog AddItemDialog = AlertDialog(
      title: Text(title, style:Theme
          .of(context)
          .textTheme
          .subtitle2,textAlign: TextAlign.center,),
      content: Container(
        height: 320,
        child: Column(
          children: <Widget>[

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
                                                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: (Colors.grey[400])!,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: (Colors.grey[400])!)),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),

                                            validator: (String? value) {
                                              if (value != null && value.isEmpty) {
                                                return "Please enter the name of the item";
                                              }

                                              return null;
                                            },
                                            onChanged: (val) {
                                              setState(() => _name = val);
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
                                                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: (Colors.grey[400])!,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: (Colors.grey[400])!)),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),

                                            validator: (String? value) {
                                              if (value != null && value.isEmpty) {
                                                return "Please enter the quantity";
                                              }
                                              if (value != null && double.parse(value) == null) {
                                                return "Please enter numeric quantity";
                                              }

                                              return null;
                                            },
                                            onChanged: (val) {
                                              setState(() => _quantity = int.parse(val));
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
                                                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DropdownButtonFormField<String>(
                                              value: _unit,
                                              //elevation: 5,
                                              style: const TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),

                                              items: Units.units.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value, style: const TextStyle(
                                                      fontFamily:"mw",fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                                                  ),
                                                );
                                              }).toList(),
                                              hint: const Text(
                                                "Please choose a unit",
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                                              ),
                                              onChanged: (String? value) {

                                                setState(() {
                                                  chosenValue=value;
                                                });

                                              }
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                )]),
        ),]),),

      actions: <Widget>[
        MaterialButton(
          onPressed: () async{
            if(_dialogformKey.currentState!.validate())
            {
              if(chosenValue!=null)
              {
                _unit = chosenValue??Units.units[0];
              }
              newItem = FoodItem(_name,_quantity,_unit,_status,_inventory_status,_from_saved_recipes,_recipeID);
              Navigator.pop(context,newItem);
            }

          },
          color: Theme
              .of(context)
              .colorScheme
              .primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Text(okBtnText, style: const TextStyle(fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme
              .of(context)
              .colorScheme
              .primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Text(cancelBtnText, style: const TextStyle(fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
        )
      ],
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddItemDialog;
        }
    );

    futureValue.then( (value) {
      setState(() {
        Map<String,Object> newObj = {
          'label': value.name,
          'quantity': value.quantity,
          'recipe': '',
          'isRecipe' : false,
          'value': false,
        };
        widget.shopList.add(newObj);
      });
      print(value);
    });

  }



}
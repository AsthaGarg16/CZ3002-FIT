import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import '../Entity/FoodRecord.dart';
import '../Entity/Units.dart';



/// My app class to display the date range picker
class FoodInventorryUtils extends StatefulWidget {
  FoodInventorryUtils(
      {Key? key,
        required this.foodList,
        required this.onFoodRecordChanged,
      })
      : super(key: key);
  List<Map<String, dynamic>> foodList;
  final Function(List<Map<String, dynamic>>) onFoodRecordChanged;
  @override
  FoodInventorryUtilsState createState() => FoodInventorryUtilsState();
}

/// State for MyApp
class FoodInventorryUtilsState extends State<FoodInventorryUtils> {

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey _accKey = GlobalKey();
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        _date.text = DateFormat.yMd().format(picked);
      });
  }

  showCustomDialog(BuildContext context,
      {String title = "Add item",
        String okBtnText = "Done",
        String addNextBtnText = "Add another" }) {

    FoodRecord newItem ;
    String _name="";
    int  _quantity=0;
    String _unit = Units.units[0];
    String? chosenValue;
    DateTime _expiryDate = DateTime.now();
    String _imageUrl='assets/images/apple.jpg';
    int _compNum = 0;
    // qr_code_scanner_rounded
    final GlobalKey<FormState> _dialogformKey = GlobalKey<FormState>();
    final dateFormatter = DateFormat('dd-MM-yy');
    AlertDialog AddItemDialog = AlertDialog(
      title: Text(title, style:Theme
          .of(context)
          .textTheme
          .subtitle2,textAlign: TextAlign.center,),
      content: SingleChildScrollView(
        //height: 320,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Text(
                                //   "Food expiry ",
                                //   style: TextStyle(
                                //       fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                // ),
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      obscureText: false,
                                      controller: _date,
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                        hintText: 'Food Expiry',
                                          prefixIcon: const Icon(Icons.calendar_today),
                                      ),
                                      style: const TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                                      onChanged: (val) {
                                        setState(() => _expiryDate = DateTime.parse(val));
                                      }
                                    ),
                                  ),
                                ) //
                              ],
                            )
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
              newItem = FoodRecord(_name,_quantity,_unit,_expiryDate,_compNum, _imageUrl);
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
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Text(addNextBtnText, style: const TextStyle(fontSize: 14.0,
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
          'title': value.name,
          'expiry': dateFormatter.format(value.expiryDate),
          'image': 'assets/images/apple.jpg',
          'quantity': value.quantity.toString(),
          'compartment': 3,
        };
        widget.foodList.add(newObj);
        widget.onFoodRecordChanged(widget.foodList);
      });

    });

  }
  @override
  Widget build(BuildContext context) {

      return SpeedDial(
        icon: Icons.more_horiz,
        backgroundColor: Theme.of(context).colorScheme.primary,
        overlayOpacity: 0,

        children: [
          SpeedDialChild(
                child: const Icon(Icons.add),
                key: _accKey,

                onTap: ()
                {
                  final RenderBox renderBox =_accKey.currentContext?.findRenderObject() as RenderBox;
                  final Size size = renderBox.size;
                  final Offset offset = renderBox.localToGlobal(Offset.zero);
                  showMenu(
                      context: context,
                      useRootNavigator: true,
                      position: RelativeRect.fromLTRB(
                          offset.dx + size.width,
                          offset.dy,
                          offset.dx - size.width/2,
                          offset.dy + size.height),
                      items: [
                        PopupMenuItem(
                          child: MaterialButton(
                              onPressed: () {
                                // showCustomDialog(context);
                              },
                              child: Text('Add items from shopping list', style: Theme.of(context).textTheme.bodyText1)),
                        ),

                        PopupMenuItem(
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showCustomDialog(context);
                            },
                            child: Text('Add new items', style: Theme.of(context).textTheme.bodyText1),
                          ),
                        ),
                      ]);
                }
            ,
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,

          ),
          SpeedDialChild(
            child: const Icon(Icons.mode_edit_outline_outlined ),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            onTap: () {/* Do something */},
          )
        ]);
  }
}

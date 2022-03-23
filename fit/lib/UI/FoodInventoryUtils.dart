import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import '../Controller/services/InventoryController.dart';
import '../Controller/services/ShoppingListController.dart';
import '../Entity/FoodRecord.dart';
import '../Entity/Units.dart';
import 'FoodInventory.dart';



/// My app class to display the date range picker
class FoodInventorryUtils extends StatefulWidget {
  FoodInventorryUtils(
      {Key? key,
        required this.foodList,
        required this.shopListDb,
        required this.onFoodRecordChanged,
        required this.onEdit,
        required this.InventoryTabController,
        required this.numOfCompartments,
      })
      : super(key: key);
  List<Map<String, dynamic>> foodList;
  List<Map<String, Object>> shopListDb;
  int numOfCompartments;
  final Function(List<Map<String, dynamic>>) onFoodRecordChanged;
  final Function(bool) onEdit;
  TabController InventoryTabController;
  bool showFloatingSearchButton = true;

  @override
  FoodInventorryUtilsState createState() => FoodInventorryUtilsState();
}

/// State for MyApp
class FoodInventorryUtilsState extends State<FoodInventorryUtils> {
  final TextEditingController _textEditingController = new TextEditingController();
  final TextEditingController _date = new TextEditingController();
  final GlobalKey _accKey = GlobalKey();
  DateTime selectedDate = DateTime.now();

  final dateFormatter = DateFormat('yyyy-MM-dd');
  List<Map<String, dynamic>> addingList = [];


  @override
  void initState() {
    // Start listening to changes.
    _date.addListener(_printLatestValue);
    super.initState();
  }
  void _printLatestValue() {
    print('Second text field: ${_date.text}');
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _textEditingController.dispose();
    _date.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, textController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textController.text = dateFormatter.format(picked);
      });
    }
  }

  clearTextInput(){
    print("why not clear???");
    _date.clear();

  }
  showCustomDialog(BuildContext context,
      {String title = "Add item",
        String okBtnText = "Done",
        String addNextBtnText = "Add another" }) {

    FoodRecord newItem ;
    String _name="";
    int  _quantity=0;
    String _unit = Units.units[0];
    String _compartment = "1";
    String? chosenValue;
    String? chosenValue2;
    DateTime _expiryDate = DateTime.now();
    String _imageUrl='';
    int _compNum = 1;
    // qr_code_scanner_rounded
    final GlobalKey<FormState> _dialogformKey = GlobalKey<FormState>();

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

                                const Text("Compartment: ", style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                ),
                                DropdownButtonFormField<String>(
                                    value: _compartment,
                                    //elevation: 5,
                                    style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),

                                    items: List<String>.generate(widget.numOfCompartments, (i) => (i + 1).toString()).map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: const TextStyle(
                                            fontFamily:"mw",fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      "Select compartment",
                                      style: TextStyle(
                                          fontFamily:"mw",fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                                    ),
                                    onChanged: (String? value) {

                                      setState(() {
                                        chosenValue2=value;
                                        _compNum = int.parse(chosenValue2!);
                                      });

                                    }
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
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
                                  onTap: () => _selectDate(context, _date),
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
                                          clearTextInput();
                                          print("why not clear???");
                                          _date.clear();
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

              var date = dateFormatter.format(selectedDate).split('-').toList();
              print(DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])));

              String imgUrl = await InventoryController.createFoodRecord("nisha.rmanian@gmail.com",_name,_quantity,_unit, DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])),_name, _compNum);

              setState(() {
                _imageUrl = imgUrl;
                _date.text = '';

              });
              // _date.clear();
              // _date.dispose();
              newItem = FoodRecord(_name,_quantity,_unit,selectedDate,_compNum, imgUrl);
              clearTextInput();
              print("why not clear???");
              _date.clear();
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
          onPressed: () async {
            if(_dialogformKey.currentState!.validate())
            {
              if(chosenValue!=null)
              {
                _unit = chosenValue??Units.units[0];
              }

              var date = dateFormatter.format(selectedDate).split('-').toList();
              print(DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])));

              String imgUrl = await InventoryController.createFoodRecord("nisha.rmanian@gmail.com",_name,_quantity,_unit, DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])),_name, _compNum);

              setState(() {
                _imageUrl = imgUrl;
              });
              clearTextInput();
              print("why not clear???");
              _date.clear();

              newItem = FoodRecord(_name,_quantity,_unit,selectedDate,_compNum, imgUrl);
              Navigator.pop(context,newItem);
            };

            showCustomDialog(context);
            // Navigator.pop(context);
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
          'image': value.imageUrl,
          'quantity': value.quantity.toString(),
          'compartment': value.compNum,
          'unit': value.unit,
        };
        widget.foodList.add(newObj);
        widget.onFoodRecordChanged(widget.foodList);
      });

    });

  }

  setupAlertDialogContainer() {
    String _compartment = "1";
    return Container(
      height: MediaQuery.of(context).size.height*0.8, // Change as per your requirement
      width: 400.0, // Change as per your requirement
      child:
        ListView.builder(
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: addingList.length,
        itemBuilder: (BuildContext context, int index) {
          final GlobalKey<FormState> _itemKey = GlobalKey<FormState>();

            return Column(
              key: _itemKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Compartment: ", style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                ),
                DropdownButtonFormField<String>(
                    value: _compartment,
                    //elevation: 5,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),

                    items: List<String>.generate(widget.numOfCompartments, (i) => (i + 1).toString()).map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(
                            fontFamily:"mw",fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                      );
                    }).toList(),
                    hint: const Text(
                      "Select compartment",
                      style: TextStyle(
                          fontFamily:"mw",fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                    onChanged: (String? val) {
                      setState(() {
                        addingList[index]['compartment'] = int.parse(val!);
                      });

                    }
                ),
                Text(addingList[index]['title'], style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Quantity', style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87)),
                    Row(
                      children: [
                        Text(addingList[index]['quantity'], style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87)),
                        Text(addingList[index]['unit'], style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87)),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text('Expiry Date', style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87)),),

                    Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () => _selectDate(context, _textEditingController),
                          child: AbsorbPointer(
                            child: TextField(
                                obscureText: false,
                                controller: _textEditingController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  hintText: 'Today',
                                  prefixIcon: const Icon(Icons.calendar_today),
                                ),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                                onChanged: (val) {
                                  setState(() => addingList[index]['expiry'] = DateTime.parse(val));

                                }
                            ),
                          ),
                        )
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ]);

        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    // return StatefulBuilder(builder: (context, StateSetter setState){
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          widget.showFloatingSearchButton ? FloatingActionButton(onPressed: (){
            showSearch(context: context, delegate: InventorySearch(widget.InventoryTabController));
          }, child: Icon(Icons.search)) : SizedBox(),

          SizedBox(height: 10),

          SpeedDial(
              icon: Icons.more_horiz,
              backgroundColor: Theme.of(context).colorScheme.primary,
              overlayOpacity: 0,
              onOpen: (){
                setState(() {
                  widget.showFloatingSearchButton = false;
                });
              },
              onClose: (){
                setState(() {
                  widget.showFloatingSearchButton = true;
                });
              },

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
                                  addingList = [];
                                  for (var item in widget.shopListDb) {
                                    if (item['value'] == true) {
                                      List<String> quant = item['quantity'].toString().split(' ').toList();
                                      if (quant.length == 1) quant.add("");
                                      Map<String, Object> newObj = {
                                        'title': item['label'].toString(),
                                        'expiry':
                                        dateFormatter.format(DateTime.now()),
                                        'image': 'assets/images/apple.jpg',
                                        'quantity': quant[0],
                                        'unit' :  quant[1],
                                        'compartment': 1,
                                      };
                                      addingList.add(newObj);
                                    }
                                  };

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {

                                        return AlertDialog(
                                          title: Text('Confirm adding shopping items', style:Theme
                                              .of(context)
                                              .textTheme
                                              .subtitle2,textAlign: TextAlign.center,),
                                          content: setupAlertDialogContainer(),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () async {
                                                for (var item in addingList) {
                                                  var date = item['expiry'].split('-').toList();
                                                  print(DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])));

                                                  String imgUrl = await InventoryController.createFoodRecord("nisha.rmanian@gmail.com",item['title'],int.parse(item['quantity']),item['unit'], DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])),item['title'], item['compartment']);
                                                  ShoppingListController.updateFoodItem("nisha.rmanian@gmail.com", item['title'], int.parse(item['quantity']), item['unit'], true, true, false, int.parse(item['quantity']), "0");
                                                  setState(() {
                                                    item['image'] = imgUrl;
                                                  });
                                                };

                                                setState(() {
                                                  widget.foodList = [...widget.foodList, ...addingList,];

                                                  widget.onFoodRecordChanged(widget.foodList);
                                                });
                                                print("hello");
                                                print(addingList);

                                                Navigator.pop(context, addingList);
                                                Navigator.pop(context);
                                              },
                                              color: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Text("OK", style: const TextStyle(fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                            ),
                                          ],
                                        );
                                      });


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
                  onTap: () {
                    setState(() {
                      bool hide = true;
                      widget.onEdit(hide);
                    });

                  },
                ),
              ]),


        ]
    );
  }
}

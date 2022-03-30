import 'package:flutter/material.dart';
import 'FoodCard.dart';
import 'FoodInventoryUtils.dart';
import '../Entity/Inventory.dart';
import '../Entity/ShoppingList.dart';
import '../Controller/services/UserController.dart';
import '../Controller/services/ShoppingListController.dart';
import '../Controller/services/InventoryController.dart';


import 'package:intl/intl.dart';
import 'dart:core';

// List<Map<String, dynamic>> foodList = [
//   {
//     'title': 'Apple',
//     'expiry': '2022-05-10',
//     'image': 'assets/images/apple.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 1,
//     'value': false,
//   },
//   {
//     'title': 'Grape',
//     'expiry': '2022-05-10',
//     'image': 'assets/images/grape.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 2,
//     'value': false,
//   },
//   {
//     'title': 'Pear',
//     'expiry': '2022-05-10',
//     'image': 'assets/images/pear.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 3,
//     'value': false,
//   },
//   {
//     'title': 'apple',
//     'expiry': '2022-05-10',
//     'image': 'assets/images/apple.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 4,
//     'value': false,
//   },
//   {
//     'title': 'banana',
//     'expiry': '2022-03-13',
//     'image': 'assets/images/banana.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 5,
//     'value': false,
//   },
//   {
//     'title': 'apple',
//     'expiry': '2022-03-20',
//     'image': 'assets/images/apple.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 1,
//     'value': false,
//   },
//   {
//     'title': 'apple',
//     'expiry': '2022-03-18',
//     'image': 'assets/images/apple.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 2,
//     'value': false,
//   },
//   {
//     'title': 'apple',
//     'expiry': '2022-03-15',
//     'image': 'assets/images/apple.jpg',
//     'quantity': "1",
//     'unit': '',
//     'compartment': 3,
//     'value': false,
//   }
// ];

List<Map<String, dynamic>> globalFoodList = [];

class FoodInventory extends StatefulWidget {
  FoodInventory({Key? key}) : super(key: key);

  @override
  _FoodInventoryState createState() => new _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory> with SingleTickerProviderStateMixin {
  final dateFormatter = DateFormat('yyyy-MM-dd');
  int numCompartments = UserController.getProfileDetails()["fridgeDetails"];
  late TabController controller;
  var hasSoonExpire;
  late var countSoonExpire = 0;
  late FoodInventorryUtils fabMenu;
  List<Map<String, Object>> shopListDb = [];

  Future<Inventory> fetchInventory() async
  {

    var obj = (await InventoryController.getInventory(UserController.getCurrentUserEmail())) ;
    return obj;
  }

  Future<List<Map<String, dynamic>>> createFoodList() async{

    List<Map<String, dynamic>> FoodList = [];
    for(var obj in inventoryList.inventoryItems)
    {
      Map<String, Object> object = {
        'title': obj.name,
        'expiry': dateFormatter.format(obj.expiryDate),
        'image': obj.imageUrl,
        'quantity': obj.quantity.toString(),
        'unit': obj.unit,
        'compartment': obj.compNum,
        'value': false,

      };
      FoodList.add(object);

    }
    return FoodList;
  }

  Future<ShoppingList> fetchShoppingList() async
  {

    var obj = (await ShoppingListController.getShoppingList(UserController.getCurrentUserEmail())) ;
    print(obj);
    return obj;
  }


  Future<List<Map<String, Object>>> createShopList() async{

    List<Map<String, Object>> ShopList=[];

    for(var obj in groceryList.FoodItemList)
    {
      if(obj.status == false && obj.inventory_status==false)
      {
        Map<String, Object> object = {
          'label': obj.name,
          'quantity': (obj.from_saved_recipes?obj.quantity_from_saved.toString():obj.quantity.toString()) + " "+obj.unit,
          'recipe': obj.from_saved_recipes?obj.recipe_ID:"0",
          'isRecipe' : obj.from_saved_recipes,
          'value': false,
          'alternatives': List<String>.filled(3,"alternate "),
          'isVisible' :false,
        };
        ShopList.add(object);
      }
    }
    return ShopList;

  }

  Future<List<Map<String, Object>>> createShopListChecked() async{
    List<Map<String, Object>> ShopListChecked = [];

    for(var object in groceryList.FoodItemList)
    {
      if(object.status == true && object.inventory_status == false)
      {
        Map<String, Object> obj = {
          'label': object.name,
          'quantity': (object.from_saved_recipes?object.quantity_from_saved.toString():object.quantity.toString()) +" "+ object.unit,
          'recipe': object.from_saved_recipes?object.recipe_ID:"0",
          'isRecipe' : object.from_saved_recipes,
          'value': true,
        };
        ShopListChecked.add(obj);
      }
    }

    return ShopListChecked;

  }



  late Future<ShoppingList> shoppingList;
  late ShoppingList groceryList;
  late Future<List<Map<String, Object>>> ShopList;
  late Future<List<Map<String, Object>>> ShopListChecked;
  late List<Map<String, Object>> shopList;
  late List<Map<String, Object>> shopListChecked;

  late Future<Inventory> foodInventoryList;
  late Inventory inventoryList;
  late Future<List<Map<String, dynamic>>> FoodList;
  late List<Map<String, dynamic>> foodList;

  var _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    controller = TabController(length: numCompartments + 1, vsync: this);

    foodInventoryList = fetchInventory() ;
    foodInventoryList.then((value) {
      inventoryList = value;

      createFoodList().then((value) {
        foodList=value;
        print("food list in initiation ");
        print(foodList);
        hasSoonExpire = List.filled(foodList.length, false);

        for( int i=0;i<foodList.length;i++)
        {
          if(DateTime.now().difference(DateTime.parse(foodList[i]["expiry"])).inDays==0)
          {
            hasSoonExpire[i]=true;
            countSoonExpire++;
          }
        }
        setState(() {
          globalFoodList = value;
        });
        shoppingList = fetchShoppingList() ;
        shoppingList.then((value) {
          groceryList = value;
          print(groceryList.FoodItemList);
          createShopList().then((value) {
            shopList=value;
            createShopListChecked().then((value) => shopListChecked =value);
          } );
        });

      } );
    });
    super.initState();

  }
  bool editBtn = false;
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Future.wait([foodInventoryList]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          if(snapshot.hasData )
          {
            return FutureBuilder(
                future: Future.wait([shoppingList]),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(snapshot.hasData) {
                    fabMenu = FoodInventorryUtils(
                      foodList: foodList,
                      shopListDb: shopListChecked,
                      onFoodRecordChanged: (List<Map<String, dynamic>> val) {
                        setState(() => foodList = val);
                      },
                      onEdit: (bool val) {
                        setState(() => editBtn = val);
                      },
                      InventoryTabController: controller,
                      numOfCompartments: numCompartments,
                    );
                    return Scaffold(
                      body:
                        // initialIndex: widget.showPage,
                        NestedScrollView(
                          // scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
                          {
                            return <Widget>[
                                SliverAppBar(
                                  automaticallyImplyLeading:false,
                                  pinned: true,
                                  floating: true,
                                  snap: false,
                                  forceElevated: innerBoxIsScrolled,
                                  flexibleSpace: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TabBar(
                                        controller: controller,
                                        isScrollable: true,
                                        tabs: List<Widget>.generate(numCompartments + 1, (int index) {
                                          return Tab(
                                              child: Text(
                                                  index > 0
                                                      ? "Compartment " + (index).toString()
                                                      : "All",
                                                  style: Theme.of(context).textTheme.bodyText2));
                                        }),
                                      )
                                    ],
                                  ),
                              )];
                            },
                          body: Container(

                            child: TabBarView(
                              controller: controller,
                              children: List<Widget>.generate(numCompartments + 1, (int index) {
                                List<Map<String, dynamic>> filteredData = foodList;

                                if (index > 0) {
                                  filteredData = foodList
                                      .where((item) => item["compartment"] == index)
                                      .toList();
                                }

                                return Stack(
                                  children: [
                                    if(countSoonExpire>0)Positioned(
                                      top:0,
                                      left:0,
                                      width:MediaQuery.of(context).size.width,
                                      height:60,
                                      child: Card(
                                        margin: const EdgeInsets.all(2.0),
                                        child: SafeArea(
                                          child: ListTile(
                                            leading: const Icon(Icons.warning, color: Colors.red,),
                                            title: const Text('Some items are expiring soon!', style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87)),
                                            trailing: Wrap(
                                              children: <Widget>[
                                                IconButton(icon: Icon(Icons.delete_forever), onPressed: () {
                                                  //display thrown dialog
                                                  setState(() {
                                                    countSoonExpire = 0;
                                                  });
                                                },), // icon-1
                                                IconButton(icon: Icon(Icons.close),
                                                  onPressed: () { setState(() {
                                                    countSoonExpire = 0;
                                                  }); },),// icon-2
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ),
                                    Positioned(
                                        top:countSoonExpire>0?55:0,
                                        left: 0,
                                        width:MediaQuery.of(context).size.width,
                                        child:
                                        Container(
                                          height: MediaQuery.of(context).size.height,
                                          width: double.infinity,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 150),
                                            // const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            itemCount: filteredData.length,
                                            itemBuilder: (ctx, int i) {
                                              return FoodCard(
                                                foodName: filteredData[i]['title'].toString(),
                                                foodExpiry: filteredData[i]['expiry'].toString(),
                                                foodImage: filteredData[i]['image'].toString(),
                                                foodQuantity: int.parse(filteredData[i]['quantity']),
                                                unit: filteredData[i]['unit'].toString(),
                                                value: filteredData[i]['value'] == true,
                                                visible: editBtn,
                                                onQuantityChanged: (int val) {
                                                  setState(() => filteredData[i]['quantity'] =  val.toString());
                                                },
                                                labelColor: Colors.black87,
                                                onValueChanged: (bool val){
                                                  setState((){
                                                    Map<String, dynamic> foodListItem =  foodList[i];
                                                    foodListItem["value"] = val;
                                                  });
                                                },
                                              );
                                            },
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 0.75,
                                              crossAxisSpacing: 1.0,
                                              mainAxisSpacing: 10,
                                              mainAxisExtent: 145,
                                            ),
                                          ),
                                        )),
                                    if (editBtn) Positioned(
                                        bottom: 30,
                                        left: 20,
                                        child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              FlatButton(
                                                child: Icon(Icons.check_circle_outline),
                                                onPressed: () {
                                                  setState(() {
                                                    editBtn = !editBtn;
                                                    for (var item in filteredData.where((item) => item['value']=true)) item['value']=false;

                                                  });

                                                },
                                                shape: CircleBorder(),
                                                color: Theme.of(context).colorScheme.primary,
                                                textColor: Color.fromRGBO(255, 255, 255, 1.0),
                                                height: 45,

                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              FlatButton(
                                                child: Icon(Icons.delete_rounded),
                                                shape: CircleBorder(),
                                                color: Theme.of(context).colorScheme.primary,
                                                textColor: Color.fromRGBO(255, 255, 255, 1.0),
                                                height: 45,
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext ctx) {
                                                        return AlertDialog(
                                                          title: Text('Please Confirm', style: Theme.of(context).textTheme.subtitle2,),
                                                          content: Text('Are you sure to remove the items?', style:Theme.of(context).textTheme.bodyText1),
                                                          actions: [
                                                            // The "Yes" button
                                                            TextButton(
                                                                onPressed: () =>
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext ctx) {
                                                                          return AlertDialog(
                                                                            title: Text('Instruction to dispose food', style: Theme.of(context).textTheme.subtitle2,),
                                                                            content: Image.asset('assets/images/food_disposal.jpg', ),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () async {
                                                                                    // Close the dialog
                                                                                    setState(() {
                                                                                      var deletedItem = filteredData.where((item) => item['value']==true).toList();
                                                                                      filteredData.removeWhere((item) {
                                                                                        return item['value']==true;
                                                                                      });
                                                                                      print("this is deletedItem");
                                                                                      print(deletedItem);
                                                                                      for (var item in deletedItem) {
                                                                                        var date = item['expiry'].split('-').toList();
                                                                                        InventoryController.deleteFoodRecord(UserController.getCurrentUserEmail(),item['title'], DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])));
                                                                                      }

                                                                                    });


                                                                                    // pop up 2 times to come back main page
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pop(context);

                                                                                  },
                                                                                  child: const Text('OK'))
                                                                            ],
                                                                          );
                                                                        }),
                                                                child: const Text('Thrown')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    var deletedItem = filteredData.where((item) => item['value']==true).toList();
                                                                    filteredData.removeWhere((item) {
                                                                      return item['value']==true;
                                                                    });
                                                                    print("this is deletedItem");
                                                                    print(deletedItem);
                                                                    for (var item in deletedItem) {
                                                                      var date = item['expiry'].split('-').toList();
                                                                      InventoryController.deleteFoodRecord(UserController.getCurrentUserEmail(),item['title'], DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])));
                                                                    }

                                                                  });
                                                                  // Close the dialog
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('Consume')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    var deletedItem = filteredData.where((item) => item['value']==true).toList();
                                                                    filteredData.removeWhere((item) {
                                                                      return item['value']==true;
                                                                    });
                                                                    print("this is deletedItem");
                                                                    print(deletedItem);
                                                                    for (var item in deletedItem) {
                                                                      var date = item['expiry'].split('-').toList();
                                                                      InventoryController.deleteFoodRecord(UserController.getCurrentUserEmail(),item['title'], DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])));
                                                                    }

                                                                  });
                                                                  // Close the dialog
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('Delete'))
                                                          ],
                                                        );});

                                                },
                                              ),
                                            ]
                                        )
                                    ),
                                  ],
                                );
                              }),
                            ),
                          )
                        ),
                       floatingActionButton:  fabMenu
                    );


                  } else if(snapshot.hasError)
                  {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}',style:const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  letterSpacing: 1.5)),
                            )
                          ]
                      ),
                    );
                  }
                  else
                  {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ]
                      ),
                    );
                  }
                }
            );

          }
          else if(snapshot.hasError)
          {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}',style:const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 1.5)),
                    )
                  ]
              ),
            );
          }
          else
          {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ]
              ),
            );
          }
        }
    );
  }
}

class InventorySearch extends SearchDelegate<String>{

  TabController controller;


  InventorySearch(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(
        onPressed: (){
          query = "";
        },
        icon: const Icon(Icons.clear)
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, "");
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation
        )
    );
  }



  @override
  Widget buildSuggestions(BuildContext context) {
    // final suggestionList = items.where((p) => p.toLowerCase().startsWith(query)).toList();
    final suggestionList = globalFoodList.where((p) => p["title"].toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          close(context, "");
          controller.animateTo(suggestionList[index]["compartment"]);
        },
        leading: const Icon(Icons.free_breakfast),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index]["title"].substring(0, query.length),
                style: Theme.of(context).textTheme.labelMedium,
                children: [TextSpan(
                  text: suggestionList[index]["title"].substring(query.length),
                  style: Theme.of(context).textTheme.labelSmall,
                )]
            )
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

}

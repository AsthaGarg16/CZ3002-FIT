import 'dart:ui';

import 'package:flutter/material.dart';
import '../Controller/services/UserController.dart';
import '../Entity/FoodItem.dart';
import '../Entity/ShoppingList.dart';
import '../Controller/services/ShoppingListController.dart';
import '../Entity/Units.dart';
import 'ShopListCard.dart';

List<Map<String,List<String>>> alternates =[
  {
    'bread': ['Wholemeal Bread (-12 calories)', 'Multigrain Bread (-40 calories)'],

  },
  {
    'milk':['Low Fat Milk (-1.25% fat)', 'Full Cream Milk (+0.75% fat)'],
  },
  {
    'mayonnaise':['Diet Mayonnaise (-1.4% fat)','Eggless Mayonnaise (+2% fat)'],
  },
  {
    'cheese':['Low Fat Cheese (-33 calories)','Vegan Cheese (-20 calories'],
  }
];



List<Map<String, Object>> shopListDb = [
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
  {
    'label': 'Flour',
    'quantity': '200 g',
    'recipe': 'Spaghetti Bolognese',
    'isRecipe' : true,
    'value': true,
    'alternatives': List<String>.filled(3,"alternate "),
    'isVisible' :false,
  },
  {
    'label': 'Onion',
    'quantity': '200 g',
    'recipe': '',
    'isRecipe' : false,
    'value': true,
    'alternatives': List<String>.filled(3,"alternate "),
    'isVisible' :false,
  },
  {
    'label': 'Sunflower Oil',
    'quantity': '5 l',
    'recipe': '',
    'isRecipe' : false,
    'value': true,
    'alternatives': List<String>.filled(3,"alternate "),
    'isVisible' :false,
  },
  {
    'label': 'Oranges',
    'quantity': '5',
    'recipe': 'Fruit Bowl',
    'isRecipe' : true,
    'value': true,
    'alternatives': List<String>.filled(3,"alternate "),
    'isVisible' :false,
  },

];

class GroceryList extends StatefulWidget {
  List<String> altItem = ['alt 1', 'alt 2', 'alt 3'];

  // List<Map<String, Object>> shopList = [
  //   {
  //     'label': 'Spaghetti',
  //     'quantity': '200 g',
  //     'recipe': 'Spaghetti Bolognese',
  //     'isRecipe' : true,
  //     'value': false,
  //     'alternatives': List<String>.filled(3,"alternate "),
  //     'isVisible' :false,
  //   },
  //   {
  //     'label': 'Tomatoes',
  //     'quantity': '200 g',
  //     'recipe': '',
  //     'isRecipe' : false,
  //   'value': false,
  //     'alternatives': List<String>.filled(3,"alternate "),
  //     'isVisible' :false,
  //   },
  //   {
  //     'label': 'Chilli Flakes',
  //     'quantity': '50 g',
  //     'recipe': '',
  //     'isRecipe' : false,
  //   'value': false,
  //     'alternatives': List<String>.filled(3,"alternate "),
  //     'isVisible' :false,
  //   },
  //   {
  //     'label': 'Apples',
  //     'quantity': '5',
  //     'recipe': 'Fruit Bowl',
  //     'isRecipe' : true,
  //     'value': false,
  //     'alternatives': List<String>.filled(3,"alternate "),
  //     'isVisible' :false,
  //   },
  // ];
  //
  // List<Map<String, Object>> shopListChecked = [
  //   {
  //     'label': 'Flour',
  //     'quantity': '200 g',
  //     'recipe': 'Spaghetti Bolognese',
  //     'isRecipe' : true,
  //     'value': true,
  //   },
  //   {
  //     'label': 'Onion',
  //     'quantity': '200 g',
  //     'recipe': '',
  //     'isRecipe' : false,
  //     'value': true,
  //   },
  //   {
  //     'label': 'Sunflower Oil',
  //     'quantity': '5 l',
  //     'recipe': '',
  //     'isRecipe' : false,
  //     'value': true,
  //   },
  //   {
  //     'label': 'Oranges',
  //     'quantity': '5',
  //     'recipe': 'Fruit Bowl',
  //     'isRecipe' : true,
  //     'value': true,
  //   },
  // ];

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<GroceryList> {

  Future<ShoppingList> fetchShoppingList() async
  {

    var obj = (await ShoppingListController.getShoppingList(UserController.getCurrentUserEmail())) ;
    print(obj);
    return obj;
    //     .then((value) {
    //   groceryList = value;
    //   createShopList().then((value) {
    //     shopList = value;
    //     createShopListChecked().then((value) => shopListChecked = value);
    //   });
    //   return value;
    // });

    //get from db
    //print(await ShoppingListController.getShoppingList("trial3@email.com"));
    // Future<ShoppingList> obj = (await ShoppingListController.getShoppingList("trial3@email.com"));
    // // FoodItem fi = new FoodItem("apple", 2, "l", false, false, false, 0, "");
    // // List<FoodItem> listFood = List<FoodItem>.filled(1,fi);
    // // ShoppingList obj = ShoppingList(listFood);
    // obj.then((value) => groceryList=value);
    // print(groceryList.FoodItemList[0]);
    // return obj;
  }


  Future<List<Map<String, dynamic>>> createShopList() async{

    List<Map<String, dynamic>> ShopList=[];
    //   {
    //     'label': 'Spaghetti',
    //     'quantity': '200 g',
    //     'recipe': 'Spaghetti Bolognese',
    //     'isRecipe' : true,
    //     'value': false,
    //     'alternatives': List<String>.filled(3,"alternate "),
    //     'isVisible' :false,
    //   },
    //   {
    //     'label': 'Tomatoes',
    //     'quantity': '200 g',
    //     'recipe': '',
    //     'isRecipe' : false,
    //     'value': false,
    //     'alternatives': List<String>.filled(3,"alternate "),
    //     'isVisible' :false,
    //   },
    //   {
    //     'label': 'Chilli Flakes',
    //     'quantity': '50 g',
    //     'recipe': '',
    //     'isRecipe' : false,
    //     'value': false,
    //     'alternatives': List<String>.filled(3,"alternate "),
    //     'isVisible' :false,
    //   },
    //   {
    //     'label': 'Apples',
    //     'quantity': '5',
    //     'recipe': 'Fruit Bowl',
    //     'isRecipe' : true,
    //     'value': false,
    //     'alternatives': List<String>.filled(3,"alternate "),
    //     'isVisible' :false,
    //   },
    // ];
    // List<Map<String,List<String>>> alternates =[
    //   {
    //     'bread': ['Wholemeal Bread (-12 calories)', 'Multigrain Bread (-40 calories)'],
    //
    //   },
    //   {
    //     'milk':['Low Fat Milk (-1.25% fat)', 'Full Cream Milk (+0.75% fat)'],
    //   },
    //   {
    //     'mayonnaise':['Diet Mayonnaise (-1.4% fat)','Eggless Mayonnaise (+2% fat)'],
    //   },
    //   {
    //     'cheese':['Low Fat Cheese (-33 calories)','Vegan Cheese (-20 calories'],
    //   }
    // ];

    for(var obj in groceryList.FoodItemList)
    {
      List<String> alt = ["No alternatives available"];
      if(obj.status == false)
      {
        if(obj.name.toLowerCase().compareTo('bread')==0)
          {
            alt = ['Wholemeal Bread (-12 calories)', 'Multigrain Bread (-40 calories)'];
          }
        else if(obj.name.toLowerCase().compareTo('milk')==0)
          {
            alt = ['Low Fat Milk (-1.25% fat)', 'Full Cream Milk (+0.75% fat)'];
          }
        else if(obj.name.toLowerCase().compareTo('mayonnaise')==0)
          {
            alt = ['Diet Mayonnaise (-1.4% fat)','Eggless Mayonnaise (+2% fat)'];
          }
        else if(obj.name.toLowerCase().compareTo('cheese')==0)
          {
            alt = ['Low Fat Cheese (-33 calories)','Vegan Cheese (-20 calories)'];
          }
        Map<String, dynamic> object = {
          'label': obj.name,
          'quantity': (obj.from_saved_recipes?obj.quantity_from_saved.toString():obj.quantity.toString()) + " "+obj.unit,
          'recipe': obj.from_saved_recipes?obj.recipe_ID:"0",
          'isRecipe' : obj.from_saved_recipes,
          'value': false,
          'alternatives': alt,
          'length':alt.length,
          'isVisible' :false,
        };
        ShopList.add(object);
      }
    }
    return ShopList;

  }

  Future<List<Map<String, dynamic>>> createShopListChecked() async{
    List<Map<String, dynamic>> ShopListChecked = [];
    //   {
    //     'label': 'Flour',
    //     'quantity': '200 g',
    //     'recipe': 'Spaghetti Bolognese',
    //     'isRecipe' : true,
    //     'value': true,
    //   },
    //   {
    //     'label': 'Onion',
    //     'quantity': '200 g',
    //     'recipe': '',
    //     'isRecipe' : false,
    //     'value': true,
    //   },
    //   {
    //     'label': 'Sunflower Oil',
    //     'quantity': '5 l',
    //     'recipe': '',
    //     'isRecipe' : false,
    //     'value': true,
    //   },
    //   {
    //     'label': 'Oranges',
    //     'quantity': '5',
    //     'recipe': 'Fruit Bowl',
    //     'isRecipe' : true,
    //     'value': true,
    //   },
    // ];
    for(var object in groceryList.FoodItemList)
    {

        List<String> alt = ["No alternatives available"];
        if(object.status == true && object.inventory_status == false)
        {
          if(object.name.toLowerCase().compareTo('bread')==0)
          {
            alt = ['Wholemeal Bread (-12 calories)', 'Multigrain Bread (-40 calories)'];
          }
          else if(object.name.toLowerCase().compareTo('milk')==0)
          {
            alt = ['Low Fat Milk (-1.25% fat)', 'Full Cream Milk (+0.75% fat)'];
          }
          else if(object.name.toLowerCase().compareTo('mayonnaise')==0)
          {
            alt = ['Diet Mayonnaise (-1.4% fat)','Eggless Mayonnaise (+2% fat)'];
          }
          else if(object.name.toLowerCase().compareTo('cheese')==0)
          {
            alt = ['Low Fat Cheese (-33 calories)','Vegan Cheese (-20 calories)'];
          }
        Map<String, dynamic> obj = {
          'label': object.name,
          'quantity': (object.from_saved_recipes?object.quantity_from_saved.toString():object.quantity.toString()) +" "+ object.unit,
          'recipe': object.from_saved_recipes?object.recipe_ID:"0",
          'isRecipe' : object.from_saved_recipes,
          'value': true,
          'alternatives': alt,
          'length':alt.length,
          'isVisible' :false,
        };
        ShopListChecked.add(obj);
      }
    }

    return ShopListChecked;

  }



  late Future<ShoppingList> shoppingList;
  late ShoppingList groceryList;
  late Future<List<Map<String, dynamic>>> ShopList;
  late Future<List<Map<String, dynamic>>> ShopListChecked;
  late List<Map<String, dynamic>> shopList;
  late List<Map<String, dynamic>> shopListChecked;
  late List<String> alternatives;
  @override
  void initState(){

    shoppingList = fetchShoppingList() ;
    shoppingList.then((value) {
      groceryList = value;
      print(groceryList.FoodItemList);
      createShopList().then((value) {
        shopList=value;
        createShopListChecked().then((value) => shopListChecked =value);
      } );
    });
    //print(groceryList);
    //ShopList = createShopList();
    //ShopList.then((value) => shopList=value);
    //ShopListChecked = createShopListChecked();
    // ShopListChecked.then((value) => shopListChecked =value);
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: FutureBuilder(
          future: Future.wait([shoppingList]),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
            if(snapshot.connectionState==ConnectionState.done && snapshot.hasData)
            {
              // List<FoodItem> blah=[];
              // List<Map<String, Object>> blah2=[];
              // List<Map<String, Object>> blah3=[];
              // snapshot.data![0].then((value) => blah=value.FoodItemList);
              // snapshot.data![1].then((value) => blah2=value);
              // snapshot.data![2].then((value) => blah3=value);

              return Container(
                //height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                    children: <Widget>[
                      Expanded(
                          child:SingleChildScrollView(
                              child: Column(
                                  children: <Widget>[
                                    if(shopList.length>0)

                                      ListView.builder(
                                          controller: ScrollController(),
                                          shrinkWrap: true,
                                          itemCount: shopList.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                                children:<Widget>[
                                                  Dismissible(
                                                      key: ValueKey(shopList[index]),
                                                      onDismissed: (direction) {
                                                        setState(() {
                                                          Map<String,dynamic> deletedItem = shopList[index];
                                                          String deletedLabel = shopList[index]['label'].toString();
                                                          shopList.removeAt(index);
                                                          String recipe_id = deletedItem['isRecipe']==true?deletedItem['recipe'].toString():"0";
                                                          print("here");
                                                          print(deletedLabel +" "+ recipe_id);
                                                          ShoppingListController.deleteFoodItem(UserController.getCurrentUserEmail(),deletedLabel,recipe_id);

                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(
                                                              duration: const Duration(seconds: 2, milliseconds: 50),
                                                              content: Text('$deletedLabel deleted'),
                                                              action: SnackBarAction(
                                                                  label: "UNDO",
                                                                  onPressed: () => setState(() {
                                                                    shopList
                                                                        .insert(
                                                                        index,
                                                                        deletedItem);

                                                                    ShoppingListController.addFoodItem(UserController.getCurrentUserEmail(), deletedItem["label"].toString(), int.parse(deletedItem["quantity"].toString().split(" ")[0]), deletedItem["quantity"].toString().split(" ")[1], false, false, deletedItem["isRecipe"].toString()=="true", int.parse(deletedItem["quantity"].toString().split(" ")[0]), deletedItem["isRecipe"]==true?deletedItem["recipe"].toString():"0"
                                                                    );
                                                                  }) // this is what you needed
                                                              )));
                                                        }); },
                                                      background: Container(color: Colors.redAccent),
                                                      child:ShopListWidget(
                                                        key:ValueKey(shopList[index]),
                                                        label:
                                                        shopList[index]['label'].toString(),
                                                        quantity: shopList[index]['quantity'].toString(),
                                                        recipe: shopList[index]['recipe'].toString(),
                                                        isRecipe: shopList[index]['isRecipe'].toString().toLowerCase() == 'true',
                                                        value: shopList[index]['value'].toString().toLowerCase() == 'true',
                                                        labelColor: Colors.black87,
                                                        visible:shopList[index]['isVisible']==true,
                                                        onValueChanged: (){
                                                          setState((){
                                                            Map<String, dynamic> shopListItem = shopList.removeAt(index);
                                                            String recipe_id = shopListItem['isRecipe']==true?shopListItem['recipe'].toString():"0";
                                                            shopListItem["value"] = true;
                                                            shopListChecked.add(shopListItem);
                                                            print(shopListItem["quantity"].toString().split(" ")[0]);
                                                            print(shopListItem["quantity"].toString().split(" ")[1]);
                                                            ShoppingListController.updateFoodItem(UserController.getCurrentUserEmail(), shopListItem["label"].toString(), int.parse(shopListItem["quantity"].toString().split(" ")[0]), shopListItem["quantity"].toString().split(" ")[1], true, false, shopListItem["isRecipe"].toString()=="true", int.parse(shopListItem["quantity"].toString().split(" ")[0]), recipe_id);
                                                            // print(widget.shopListChecked);
                                                            // print(widget.shopList);
                                                          });
                                                        },
                                                        onButtonPress: (){
                                                          setState((){
                                                            print("Changing state");
                                                            shopList[index]['isVisible'] = !(shopList[index]['isVisible']==true);

                                                          });
                                                        },
                                                      )),
                                                  Visibility(
                                                      visible: shopList[index]['isVisible']==true,
                                                      replacement:Container(),
                                                      maintainState: true,
                                                      child:(
                                                          ListView.separated(
                                                            controller: ScrollController(),
                                                            shrinkWrap: true,
                                                            itemCount: int.parse(shopList[index]['length'].toString()),
                                                            itemBuilder:(context, index2)
                                                            {
                                                              return Material(
                                                                  child: ListTile(
                                                                    title: Text(shopList[index]['alternatives'][index2], style: const TextStyle(
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
                                    if(shopList.length<=0 && shopListChecked.length<=0 )
                                      Container(
                                        height:600,
                                        padding:const EdgeInsets.all(10.0),
                                        margin:const EdgeInsets.all(20.0),
                                        alignment: Alignment.center ,
                                        child: const Text("The list is empty. Add an item using the button below.", style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87),
                                          textAlign: TextAlign.center,),
                                      ),

                                    if(shopListChecked.length>0)
                                      ListView.builder(
                                          controller: ScrollController(),
                                          shrinkWrap: true,
                                          itemCount: shopListChecked.length,
                                          itemBuilder: (context, index) {
                                            return
                                              Dismissible(
                                                key: ValueKey(shopListChecked[index]),
                                                onDismissed: (direction) {
                                                setState(() {
                                                Map<String,dynamic> deletedItem = shopListChecked[index];
                                                String deletedLabel = shopListChecked[index]['label'].toString();
                                                shopListChecked.removeAt(index);
                                                String recipe_id = deletedItem['isRecipe']==true?deletedItem['recipe'].toString():"0";
                                                print("here");
                                                print(deletedLabel +" "+ recipe_id);
                                                ShoppingListController.deleteFoodItem(UserController.getCurrentUserEmail(),deletedLabel,recipe_id);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        duration: const Duration(seconds: 2, milliseconds: 50),
                                                        content: Text('$deletedLabel deleted'),
                                                        action: SnackBarAction(
                                                        label: "UNDO",
                                                        onPressed: () => setState(() {
                                                        shopListChecked
                                                            .insert(
                                                        index,
                                                        deletedItem);

                                                        ShoppingListController.addFoodItem(UserController.getCurrentUserEmail(), deletedItem["label"].toString(), int.parse(deletedItem["quantity"].toString().split(" ")[0]), deletedItem["quantity"].toString().split(" ")[1], true, false, deletedItem["isRecipe"].toString()=="true", int.parse(deletedItem["quantity"].toString().split(" ")[0]), deletedItem["isRecipe"]==true?deletedItem["recipe"].toString():"0"
                                                        );
                                                        }) // this is what you needed
                                                )));
                                                }); },
                                                background: Container(color: Colors.redAccent),
                                              child: ShopListWidget(
                                              key:ValueKey(shopListChecked[index]),
                                              label:
                                              shopListChecked[index]['label'].toString(),
                                              quantity: shopListChecked[index]['quantity'].toString(),
                                              recipe: shopListChecked[index]['recipe'].toString(),
                                              isRecipe: shopListChecked[index]['isRecipe'].toString().toLowerCase() == 'true',
                                              value: shopListChecked[index]['value'].toString().toLowerCase() == 'true',
                                              labelColor: Colors.black87,
                                              visible:false,
                                              onButtonPress:(){} ,
                                              onValueChanged: (){
                                                setState((){
                                                  Map<String, dynamic> item = shopListChecked.removeAt(index);
                                                  Map<String, dynamic> shopListItem={
                                                    'label': item['label'],
                                                    'quantity': item['quantity'],
                                                    'recipe': item['isRecipe'].toString()=='true'?item['recipe']:"0",
                                                    'isRecipe' : item['isRecipe'],
                                                    'value': false,
                                                    'alternatives': item['alternatives'] ?? ["No alternatives available"],
                                                    'length':item['length'] ?? 1,
                                                    'isVisible' :false,
                                                  };
                                                  String recipe_id = shopListItem['isRecipe']==true?shopListItem['recipe'].toString():"0";
                                                  //shopListItem["value"] = false;
                                                  shopList.add(shopListItem);
                                                  print(shopListItem["label"]);
                                                  print(shopListItem["quantity"]);
                                                  print(shopListItem["recipe"]);
                                                  print(shopListItem["isRecipe"]);
                                                  print(shopListItem["value"]);
                                                  print(shopListItem["alternatives"]);
                                                  print(shopListItem["length"]);
                                                  print(shopListItem["isVisible"]);
                                                  print(shopListItem["quantity"].toString().split(" ")[0]);
                                                  print(shopListItem["quantity"].toString().split(" ")[1]);
                                                  ShoppingListController.updateFoodItem(UserController.getCurrentUserEmail(), shopListItem["label"].toString(), int.parse(shopListItem["quantity"].toString().split(" ")[0]), shopListItem["quantity"].toString().split(" ")[1], false, false, shopListItem["isRecipe"].toString()=="true", int.parse(shopListItem["quantity"].toString().split(" ")[0]), recipe_id);
                                                  // print(widget.shopListChecked);
                                                  // print(widget.shopList);
                                                });

                                              },
                                            ),);
                                          })
                                  ]
                              ))



                      ),]),


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

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showCustomDialog(context).then((valueFromDialog){
          //   // use the value as you wish
          //   print(valueFromDialog);
          // });
          showCustomDialog(context);

        },

        child: const Icon(Icons.add, size:30.0),
      ),

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
    int _quantity_from_saved = 0;
    String _recipe_ID="0";

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
              newItem = FoodItem(_name,_quantity,_unit,_status,_inventory_status,_from_saved_recipes,_quantity_from_saved,_recipe_ID);
              ShoppingListController.addFoodItem(UserController.getCurrentUserEmail(),newItem.name,newItem.quantity,newItem.unit,newItem.status,newItem.inventory_status,newItem.from_saved_recipes,newItem.quantity_from_saved,newItem.recipe_ID);
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

    return futureValue.then( (value) {

      List<String> alt = ["No alternatives available"];

        if(value.name.toLowerCase().compareTo('bread')==0)
        {
          alt = ['Wholemeal Bread (-12 calories)', 'Multigrain Bread (-40 calories)'];
        }
        else if(value.name.toLowerCase().compareTo('milk')==0)
        {
          alt = ['Low Fat Milk (-1.25% fat)', 'Full Cream Milk (+0.75% fat)'];
        }
        else if(value.name.toLowerCase().compareTo('mayonnaise')==0)
        {
          alt = ['Diet Mayonnaise (-1.4% fat)','Eggless Mayonnaise (+2% fat)'];
        }
        else if(value.name.toLowerCase().compareTo('cheese')==0)
        {
          alt = ['Low Fat Cheese (-33 calories)','Vegan Cheese (-20 calories)'];
        }



      Map<String,dynamic> newObj = {
        'label': value.name,
        'quantity': value.quantity.toString() +" "+value.unit,
        'recipe': '',
        'isRecipe' : false,
        'value': false,
        'length' : alt.length,
        'alternatives' : alt,
      };

      //add to db
      setState(() {
        shopList.add(newObj);

      });

      print(value);

    });

  }



}
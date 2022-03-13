import 'package:flutter/material.dart';
import 'FoodCard.dart';
import 'FoodInventoryUtils.dart';
import 'HomePage.dart';

List<Map<String, dynamic>> foodList = [
  {
    'title': 'Apple',
    'expiry': '10/05/22',
    'image': 'assets/images/apple.jpg',
    'quantity': "1",
    'compartment': 1,
    'value': false,
  },
  {
    'title': 'Grape',
    'expiry': '10/05/22',
    'image': 'assets/images/grape.jpg',
    'quantity': "1",
    'compartment': 2,
    'value': false,
  },
  {
    'title': 'Pear',
    'expiry': '10/05/22',
    'image': 'assets/images/pear.jpg',
    'quantity': "1",
    'compartment': 3,
    'value': false,
  },
  {
    'title': 'apple',
    'expiry': '10/05/22',
    'image': 'assets/images/apple.jpg',
    'quantity': "1",
    'compartment': 4,
    'value': false,
  },
  {
    'title': 'banana',
    'expiry': '10/05/22',
    'image': 'assets/images/banana.jpg',
    'quantity': "1",
    'compartment': 5,
    'value': false,
  },
  {
    'title': 'apple',
    'expiry': '10/05/22',
    'image': 'assets/images/apple.jpg',
    'quantity': "1",
    'compartment': 1,
    'value': false,
  },
  {
    'title': 'apple',
    'expiry': '10/05/22',
    'image': 'assets/images/apple.jpg',
    'quantity': "1",
    'compartment': 2,
    'value': false,
  },
  {
    'title': 'apple',
    'expiry': '10/05/22',
    'image': 'assets/images/apple.jpg',
    'quantity': "1",
    'compartment': 3,
    'value': false,
  }
];


class FoodInventory extends StatefulWidget {
  FoodInventory({Key? key}) : super(key: key);

  @override
  _FoodInventoryState createState() => new _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory> with SingleTickerProviderStateMixin {
  int numCompartments = 5;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: numCompartments + 1, vsync: this);

  }
  bool editBtn = false;
  Widget build(BuildContext context) {
    FoodInventorryUtils fabMenu = FoodInventorryUtils(
      foodList: foodList,
      onFoodRecordChanged: (List<Map<String, dynamic>> val) {
        setState(() => foodList = val);
      },
      onEdit: (bool val) {
        setState(() => editBtn = val);
      },
      InventoryTabController: controller,
    );

    return DefaultTabController(
      length: numCompartments + 1,
      // initialIndex: widget.showPage,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // actions: <Widget>[
            //   IconButton(
            //       onPressed: (){
            //         showSearch(context: context, delegate: InventorySearch(controller));
            //       },
            //       icon: const Icon(Icons.search)
            //   )
            // ],
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
          ),
          body: TabBarView(
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
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemCount: filteredData.length,
                      itemBuilder: (ctx, int i) {
                      return FoodCard(
                          foodName: filteredData[i]['title'].toString(),
                          foodExpiry: filteredData[i]['expiry'].toString(),
                          foodImage: filteredData[i]['image'].toString(),
                          foodQuantity: int.parse(filteredData[i]['quantity']),
                          value: filteredData[i]['value'] == true,
                          visible: editBtn,
                          onQuantityChanged: (int val) {
                            setState(() => filteredData[i]['quantity'] =  val.toString());
                          },
                          labelColor: Colors.black87,
                          onValueChanged: (){
                            setState((){
                            Map<String, dynamic> foodListItem =  foodList[i];
                            foodListItem["value"] = true;
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
                  ),
                  if (editBtn) Positioned(
                      bottom: 30,
                      left: 20,
                      child:  Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                              child: Icon(Icons.check_circle_outline),
                              onPressed: () {
                                setState(() {
                                  editBtn = !editBtn;
                                });
                              },
                              heroTag: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FloatingActionButton(
                              child: Icon(Icons.delete_rounded),
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
                                        onPressed: () {
                                          // Remove the box
                                          setState(() {
                                            filteredData.removeWhere((item) {
                                              return item['value']==true;
                                            } );
                                          });

                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Thrown')),
                                    TextButton(
                                        onPressed: () {
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Consume'))
                                  ],
                                );});


                              },
                              heroTag: 2,
                            ),
                          ]
                      )
                  )
                ],
              );
            }),
          ),
          floatingActionButton: fabMenu
      ),
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
    final suggestionList = foodList.where((p) => p["title"].toLowerCase().startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          close(context, "");
          controller.animateTo(foodList[index]["compartment"]);
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

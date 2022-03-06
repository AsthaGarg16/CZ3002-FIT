import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'FoodCard.dart';


class FoodInventory extends StatefulWidget {

  FoodInventory({Key? key}) : super(key: key);

  List<Map<String, dynamic>> foodList = [
    {
      'title': 'Apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity': "1",
      'compartment': 1,
    },
    {
      'title': 'Grape',
      'expiry': '10/05/22',
      'image': 'assets/images/grape.jpg',
      'quantity': "1",
      'compartment': 2,
    },
    {
      'title': 'Pear',
      'expiry': '10/05/22',
      'image': 'assets/images/pear.jpg',
      'quantity': "1",
      'compartment': 3,
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity': "1",
      'compartment': 4,
    },
    {
      'title': 'banana',
      'expiry': '10/05/22',
      'image': 'assets/images/banana.jpg',
      'quantity': "1",
      'compartment': 5,
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity': "1",
      'compartment': 1,
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity': "1",
      'compartment': 2,
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity': "1",
      'compartment': 3,
    }
  ];

  @override
  _FoodInventoryState createState() => new _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory> {
  int numCompartments = 5;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: numCompartments + 1,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
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
          children: List<Widget>.generate(numCompartments + 1, (int index) {
            List<Map<String, dynamic>> filteredData = widget.foodList;

            if (index > 0) {
              filteredData = widget.foodList
                  .where((item) => item["compartment"] == index)
                  .toList();
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GridView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: filteredData.length,
                itemBuilder: (ctx, int i) {
                  // if(foodList[i]["compartment"] == index + 1) {
                  return FoodCard(
                    foodName: filteredData[i]['title'].toString(),
                    foodExpiry: filteredData[i]['expiry'].toString(),
                    foodImage: filteredData[i]['image'].toString(),
                    foodQuantity: int.parse(filteredData[i]['quantity']),
                    onQuantityChanged: (int val) {
                      setState(() => filteredData[i]['quantity'] =  val.toString());
                      print("new value " + filteredData[i]['quantity']);
                    },
                  );
                  // }
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 2,
                  mainAxisExtent: 120,
                    ),
                  ),
                );
              }),
            ),
            floatingActionButton:
              SpeedDial(
                  icon: Icons.more_horiz,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  overlayOpacity: 0,
                  children: [
                    SpeedDialChild(
                      child: const Icon(Icons.add),
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onTap: () {/* Do someting */},
                    ),
                    SpeedDialChild(
                      child: const Icon(Icons.mode_edit_outline_outlined ),
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onTap: () {/* Do something */},
                    ),
                  ])
      ),
    );
  }
}

class InventorySearch extends SearchDelegate<String>{
  List<String> items = [ //use a function to get a list of inventory items as a string for this attribute
    "Apple",
    "Banana",
    "Pear",
  ];

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
  Widget buildResults(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.red,
          shape: StadiumBorder(),
          child: Center(
            child: Text(query),
          )
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = items.where((p) => p.toLowerCase().startsWith(query)).toList();
    
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: (){
            showResults(context);
          },
          leading: const Icon(Icons.free_breakfast),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: Theme.of(context).textTheme.labelMedium,
              children: [TextSpan(
                text: suggestionList[index].substring(query.length),
                style: Theme.of(context).textTheme.subtitle2,
              )]
            )
          ),
        ),
      itemCount: suggestionList.length,
    );
  }
  
}

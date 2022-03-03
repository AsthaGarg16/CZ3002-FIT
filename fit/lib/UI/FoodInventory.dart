import 'package:flutter/material.dart';
import 'FoodCard.dart';

class FoodInventory extends StatefulWidget {
  FoodInventory({Key? key}) : super(key: key);

  @override
  _FoodInventoryState createState() => new _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory> {
  int numCompartments = 5;

  @override
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
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    int noFood = foodList.length;
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
            List<Map<String, dynamic>> filteredData = foodList;

            if (index > 0) {
              filteredData = foodList
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
                      onQuantityChanged: (index){
                        setState((){
                        });
                      }
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

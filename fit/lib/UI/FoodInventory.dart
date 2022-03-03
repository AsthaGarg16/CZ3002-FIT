import 'package:flutter/material.dart';
import 'FoodCard.dart';
class FoodInventory extends StatefulWidget{
  FoodInventory({Key? key}) : super(key: key);

  @override
  _FoodInventoryState createState() => new _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory>{
  @override
  List<Map<String, dynamic>> foodList = [
    {
      'title': 'Apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity' : "1"
    },
    {
      'title': 'Grape',
      'expiry': '10/05/22',
      'image': 'assets/images/grape.jpg',
      'quantity' : "1"
    },
    {
      'title': 'Pear',
      'expiry': '10/05/22',
      'image': 'assets/images/pear.jpg',
      'quantity' : "1"
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity' : "1"
    },
    {
      'title': 'banana',
      'expiry': '10/05/22',
      'image': 'assets/images/banana.jpg',
      'quantity' : "1"
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity' : "1"
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity' : "1"
    },
    {
      'title': 'apple',
      'expiry': '10/05/22',
      'image': 'assets/images/apple.jpg',
      'quantity' : "1"
    }
  ];




  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    int noFood = foodList.length ;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(child: Text('All', style: Theme.of(context).textTheme.subtitle1)),
                  Tab(child: Text('Diary Free', style: Theme.of(context).textTheme.subtitle1)),
                  Tab(child: Text('Gluten Free', style: Theme.of(context).textTheme.subtitle1)),
                  Tab(child: Text('Vegan', style: Theme.of(context).textTheme.subtitle1)),
                  Tab(child: Text('Vegetarian', style: Theme.of(context).textTheme.subtitle1)),
                ],
              )
            ],
          ),
        ),
        body:
            Container(height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child:TabBarView(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemCount: noFood,
                      itemBuilder: (ctx, i) {
                        return FoodCard(
                          foodName: foodList[i]['title'].toString(),
                          foodExpiry:foodList[i]['expiry'].toString(),
                          foodImage: foodList[i]['image'].toString(),
                          foodQuantity: int.parse(foodList[i]['quantity']),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 2,
                        mainAxisExtent: 120,

                      ),
                    ),
                    Icon(Icons.flight, size: 350),
                    Icon(Icons.directions_transit, size: 350),
                    Icon(Icons.directions_car, size: 350),
                    Icon(Icons.directions_bike, size: 350),
                  ],
                ),
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
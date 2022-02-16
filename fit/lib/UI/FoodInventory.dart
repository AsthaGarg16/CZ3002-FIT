import 'package:flutter/material.dart';

class FoodInventory extends StatefulWidget {
  @override
  _FoodInventoryState createState() => _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(child: Text('All')),
                  Tab(child: Text('Diary Free')),
                  Tab(child: Text('Gluten Free')),
                  Tab(child: Text('Vegan')),
                  Tab(child: Text('Vegetarian')),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemCount: 10,
              itemBuilder: (ctx, i) {
                List<Image> foodImage = [
                  Image.asset('assets/images/apple.jpg'),
                  Image.asset('assets/images/pear.jpg'),
                  Image.asset('assets/images/banana.jpg'),
                  Image.asset('assets/images/grape.jpg'),
                  Image.asset('assets/images/banana.jpg'),
                  Image.asset('assets/images/banana.jpg'),
                  Image.asset('assets/images/banana.jpg'),
                  Image.asset('assets/images/banana.jpg'),
                  Image.asset('assets/images/banana.jpg'),
                  Image.asset('assets/images/banana.jpg'),
                ];
                return Card(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: foodImage[i],
                            ),
                            Text(
                              'Title',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Subtitle',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 100,
              ),
            ),
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
            Icon(Icons.directions_bike, size: 350),
          ],
        ),
      ),
    );
  }
}
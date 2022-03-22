import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:random_color/random_color.dart';

import 'indicator.dart';

class FoodWastagePage extends StatefulWidget {
  const FoodWastagePage({Key? key}) : super(key: key);


  @override
  _FoodWasteState createState() => _FoodWasteState();
}

class _FoodWasteState extends State<FoodWastagePage> {

  final RandomColor _randomColor = RandomColor();
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
        return SingleChildScrollView(

                child: Column(
            children:[

              Card(
                  margin: EdgeInsets.all(10.0),
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3.0,
                        blurRadius: 1.5, // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                    const SizedBox(
                    height: 18,
                    ),
                    Expanded(
                        child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                    if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                    });
                                    }),
                                borderData: FlBorderData(
                                show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: showingSections()),
                            ),
                        ),
                    ),
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                          color: Color(0xff0293ee),
                          text: 'Bread',
                          isSquare: true,
                          ),
                          SizedBox(
                          height: 4,
                          ),
                          Indicator(
                          color: Color(0xfff8b250),
                          text: 'Eggs',
                          isSquare: true,
                          ),
                          SizedBox(
                          height: 4,
                          ),
                          Indicator(
                          color: Color(0xff845bef),
                          text: 'Milk',
                          isSquare: true,
                          ),
                          SizedBox(
                          height: 4,
                          ),
                          Indicator(
                          color: Color(0xff13d38e),
                          text: 'Avocado',
                          isSquare: true,
                          ),
                          SizedBox(
                          height: 18,
                          ),
                        ],
                        ),
                    const SizedBox(
                    width: 28,
                    ),
                    ],
                    ),),
                ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding:EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3.0,
                  blurRadius: 1.5, // changes position of shadow
                  ),
                  ],
                ),
              child: Table(
                  border: TableBorder.all(),
                children:const [
                  TableRow(children:[Text(" Item", style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),),
                    Text(" Quantity", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),),
                    Text(" Frequency", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),),
                  ]),
                  TableRow(children:[Text(" Bread", style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87),),
                    Text(" 15 count", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),
                    Text(" 5", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),]),
                  TableRow(children:[Text(" Eggs",style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87)),
                    Text(" 12 count", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),
                    Text(" 2", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),]),
                  TableRow(children:[Text(" Milk",style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87)),
                    Text(" 12 l", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),
                    Text(" 10", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),]),
                  TableRow(children:[Text(" Avocado",style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87)),
                    Text(" 100 g", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),
                    Text(" 3", style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),),]),

                ]
              ),),
    ],),
            );
        }

        List<PieChartSectionData> showingSections() {
        return List.generate(4, (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        switch (i) {
        case 0:
        return PieChartSectionData(
        color: const Color(0xff0293ee),
        value: 40,
        title: '40%',
        radius: radius,
        titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff)),
        );
        case 1:
        return PieChartSectionData(
        color: const Color(0xfff8b250),
        value: 30,
        title: '30%',
        radius: radius,
        titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff)),
        );
        case 2:
        return PieChartSectionData(
        color: const Color(0xff845bef),
        value: 15,
        title: '15%',
        radius: radius,
        titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff)),
        );
        case 3:
        return PieChartSectionData(
        color: const Color(0xff13d38e),
        value: 15,
        title: '15%',
        radius: radius,
        titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff)),
        );
        default:
        throw Error();
        }
        });
        }
  }
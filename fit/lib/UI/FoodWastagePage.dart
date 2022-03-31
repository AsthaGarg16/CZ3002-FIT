import 'dart:ui';
import 'dart:math' as math;

import 'package:fit/Entity/FoodWasteRecord.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:random_color/random_color.dart';

import '../Controller/services/FoodWastageController.dart';
import '../Controller/services/UserController.dart';
import '../Entity/FoodWasteList.dart';
import 'indicator.dart';

class FoodWastagePage extends StatefulWidget {
  const FoodWastagePage({Key? key}) : super(key: key);


  @override
  _FoodWasteState createState() => _FoodWasteState();
}

class _FoodWasteState extends State<FoodWastagePage> {

  Future<FoodWasteList> fetchFoodWasteList() async
  {
    var obj = (await FoodWastageController.getFoodWasteList(
        UserController.getCurrentUserEmail()));
    print(obj);
    return obj;
  }

  Future<List<Map<String, dynamic>>> createListForSections() async
  {
    List<Map<String, dynamic>> itemThrown = [];
    int count = 0;
    bool flag = false;
    DateTime currentNow = DateTime.now();

    for (FoodWasteRecord obj in wasteRecords) {

      if (currentNow
          .difference(DateTime.parse(obj.thrownDate))
          .inDays <= 30) {
        total = total + 1;
        if (count == 0) {
          count++;
          Map<String, dynamic> toAdd = {
            "name": obj.name,
            "freq": 1,
          };
          itemThrown.add(toAdd);
          continue;
        }
        flag = false;
        for (int i = 0; i < itemThrown.length; i++) {
          if (itemThrown[i]['name'].toString().compareTo(obj.name) == 0) {
            flag = true;
            itemThrown[i]['freq'] = itemThrown[i]['freq'] + 1;
          }
        }
        if (flag == false) {
          Map<String, dynamic> toAdd = {
            "name": obj.name,
            "freq": 1,
          };
          itemThrown.add(toAdd);
        }
        count++;
      }
    }
    return itemThrown;
  }



  final RandomColor _randomColor = RandomColor();
  int touchedIndex = -1;

  late Future<FoodWasteList> foodWasteList;
  late FoodWasteList wasteList;
  late List<FoodWasteRecord> wasteRecords;
  late List<Map> tableData;
  late List<Map<String, dynamic>> listForSections;
  late List<PieChartSectionData> chartSections;
  int total = 0;
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  void initState() {
    foodWasteList = fetchFoodWasteList();
    foodWasteList.then((value) {
      wasteList = value;
      wasteRecords = wasteList.foodWasteRecords;
      createListForSections().then((value) {
        listForSections = value;

      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([foodWasteList]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return SingleChildScrollView(

              child: Column(
                children: [

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

                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 2.0,
                                    centerSpaceRadius: 40,
                                    sections: theSections()),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: theIndicators(),
                              //<Widget>[
                            //   theIndicators(),
                            //   // Indicator(
                            //   //   color: Color(0xff0293ee),
                            //   //   text: 'Bread',
                            //   //   isSquare: true,
                            //   // ),
                            //   // SizedBox(
                            //   //   height: 4,
                            //   // ),
                            //   // Indicator(
                            //   //   color: Color(0xfff8b250),
                            //   //   text: 'Eggs',
                            //   //   isSquare: true,
                            //   // ),
                            //   // SizedBox(
                            //   //   height: 4,
                            //   // ),
                            //   // Indicator(
                            //   //   color: Color(0xff845bef),
                            //   //   text: 'Milk',
                            //   //   isSquare: true,
                            //   // ),
                            //   // SizedBox(
                            //   //   height: 4,
                            //   // ),
                            //   // Indicator(
                            //   //   color: Color(0xff13d38e),
                            //   //   text: 'Avocado',
                            //   //   isSquare: true,
                            //   // ),
                            //   SizedBox(
                            //     height: 18,
                            //   ),
                            // ],
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                        ],
                      ),),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
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
                    child: _createDataTable(),
                    // child: Table(
                    //     border: TableBorder.all(),
                    //     children: const [
                    //       TableRow(children: [Text(" Item", style: TextStyle(
                    //           fontSize: 18.0,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black87),),
                    //         Text(" Quantity", style: TextStyle(
                    //             fontSize: 18.0,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.black87),),
                    //         Text(" Frequency", style: TextStyle(
                    //             fontSize: 18.0,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.black87),),
                    //       ]),
                    //       TableRow(children: [Text(" Bread", style: TextStyle(
                    //           fontSize: 15.0,
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.black87),),
                    //         Text(" 15 count", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //         Text(" 5", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //       ]),
                    //       TableRow(children: [Text(" Eggs", style: TextStyle(
                    //           fontSize: 15.0,
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.black87)),
                    //         Text(" 12 count", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //         Text(" 2", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //       ]),
                    //       TableRow(children: [Text(" Milk", style: TextStyle(
                    //           fontSize: 15.0,
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.black87)),
                    //         Text(" 12 l", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //         Text(" 10", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //       ]),
                    //       TableRow(children: [Text(" Avocado", style: TextStyle(
                    //           fontSize: 15.0,
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.black87)),
                    //         Text(" 100 g", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //         Text(" 3", style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.black87),),
                    //       ]),
                    //
                    //     ]
                    // ),
                      ),
                ],),
            );
          }
          else if (snapshot.hasError) {
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
                      child: Text(
                          'Error: ${snapshot.error}', style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 1.5)),
                    )
                  ]
              ),
            );
          }
          else {
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
        });
  }

    List<PieChartSectionData> theSections()
    {
      List<PieChartSectionData> sections = [];
      for (int i = 0; i < listForSections.length; i++) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 14.0;
        final radius = isTouched ? 60.0 : 50.0;
        double val = 100 * listForSections[i]["freq"] / total;
        PieChartSectionData pcs = PieChartSectionData(
          color: Colors.primaries[math.Random().nextInt(Colors.primaries.length)][math.Random().nextInt(9) * 100],
          value: val,
          title: val.toStringAsFixed(0) + " %",
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
        sections.add(pcs);
      }
      chartSections = sections;
      return sections;
    }


  List<Widget> theIndicators() {
    List<Widget> theWidgets = [];
    SizedBox sb = const SizedBox(height: 4,);
    for (int i = 0; i < chartSections.length; i++) {
      Indicator ind = Indicator(
        color: chartSections[i].color,
        text: listForSections[i]["name"],
        isSquare: true,

      );

      theWidgets.add(ind);
      theWidgets.add(sb);
    }
    theWidgets.add(SizedBox(height:18,));
    return theWidgets;
  }

  DataTable _createDataTable() {

    List<Map> forTable =[];
    int count2 = 0;
    bool flag2 = false;

    for (FoodWasteRecord obj in wasteRecords) {
      flag2 = false;
      if(count2==0)
      {
        Map<String,dynamic> newEntry = {
          "name" : obj.name,
          "quantity" : obj.quantity,
          "frequency" : 1,
          "unit" : obj.unit,
        };
        forTable.add(newEntry);
        count2++;
      }
      else
      {
        count2++;
        for (int i = 0; i < forTable.length; i++) {
          if (forTable[i]['name'].toString().compareTo(obj.name) == 0) {
            flag2 = true;
            print("here");
            forTable[i]['frequency'] = forTable[i]['frequency'] + 1;
            forTable[i]['quantity'] = forTable[i]['quantity'] + obj.quantity;
            break;
          }
        }
        if (!flag2) {
          Map<String, dynamic> newAdd = {
            "name": obj.name,
            "quantity" : obj.quantity,
            "frequency": 1,
            "unit" : obj.unit,
          };
          forTable.add(newAdd);
        }

      }

    }
    tableData = forTable;

    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isSortAsc,
      dividerThickness: 2.5,
      dataRowHeight: 50,
      showBottomBorder: true,
      headingTextStyle: const TextStyle(
        fontFamily: "mw",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      headingRowColor: MaterialStateProperty.resolveWith(
              (states) => Colors.teal
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item'), ),
            const DataColumn(label: Text('Quantity'),),
              DataColumn(label: const Text('Frequency'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              tableData.sort((a, b) => b['frequency'].toString().compareTo(a['frequency'].toString()));
            } else {
              tableData.sort((a, b) => a['frequency'].toString().compareTo(b['frequency'].toString()));
            }
            _isSortAsc = !_isSortAsc;
          });
        },)
    ];
  }
  List<DataRow> _createRows() {
    return tableData
        .map((entry) => DataRow(cells: [
      DataCell(Text(entry['name'], style: const TextStyle( fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.black))),
      DataCell(Text(entry['quantity'].toString()+" "+entry['unit'], style: const TextStyle( fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.black))),
      DataCell(Text(entry['frequency'].toString(), style: const TextStyle( fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.black))),
    ]))
        .toList();
  }



}
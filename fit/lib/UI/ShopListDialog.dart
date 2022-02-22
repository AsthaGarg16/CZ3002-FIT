import 'dart:ui';

import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  _dismissDialog() {
    Navigator.pop(context);
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add item', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87), textAlign: TextAlign.center),
            content: Container(

                child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Item name: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            obscureText: false,

                            decoration: InputDecoration(
                              isDense: true,

                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: (Colors.grey[400])!,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (Colors.grey[400])!)),
                            ),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                            onChanged: (val) {
                              ;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 20.0
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Quantity: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            obscureText: false,

                            decoration: InputDecoration(
                              isDense: true,

                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: (Colors.grey[400])!,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (Colors.grey[400])!)),
                            ),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                            onChanged: (val) {
                              ;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 10.0
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Unit: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            obscureText: false,

                            decoration: InputDecoration(
                              isDense: true,

                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: (Colors.grey[400])!,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (Colors.grey[400])!)),
                            ),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                            onChanged: (val) {
                              ;
                            },
                          ),
                        ],
                      ),

                    ]
                )),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  _dismissDialog();
                },
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text('Save', style: TextStyle(fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
              ),
              MaterialButton(
                onPressed: () {
                  _dismissDialog();
                },
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text('Cancel', style: TextStyle(fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
              )

            ],
          );
        });
  }
}
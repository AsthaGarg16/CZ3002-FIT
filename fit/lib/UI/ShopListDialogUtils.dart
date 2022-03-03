import 'dart:ui';

import 'package:flutter/material.dart';

class ShopListDialogUtils {
  static final ShopListDialogUtils _instance = ShopListDialogUtils.internal();

  ShopListDialogUtils.internal();

  factory ShopListDialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {String title = "Add item",
        String okBtnText = "Save",
        String cancelBtnText = "Cancel",
        required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
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
                okBtnFunction;
                Navigator.pop(context);
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
        });
  }
}

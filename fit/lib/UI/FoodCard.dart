import 'package:flutter/material.dart';
import 'dart:async';

class FoodCard extends StatefulWidget {
  FoodCard(
      {Key? key,
        required this.foodName,
        required this.foodExpiry,
        required this.foodImage,
        required this.foodQuantity,
        required this.onQuantityChanged,
      })
      : super(key: key);
  final String foodName;
  final String foodExpiry;
  final String foodImage;
  final Function(int) onQuantityChanged;
  int foodQuantity;

  @override
  FoodCardState createState() => FoodCardState();
}

class FoodCardState extends State<FoodCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
            Container(margin:EdgeInsets.all(8.0), height: 250, child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, StateSetter setState)
                          {
                            return AlertDialog(
                              content: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                              widget.foodName.toUpperCase(),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline3),
                                        ),
                                        Center(
                                          child: Padding(
                                          padding: EdgeInsets.only(top: 16.0),
                                          child: Text(
                                              "Quantity",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .labelMedium),
                                          )
                                        ),

                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            IconButton(
                                              icon: new Icon(Icons.remove),
                                              onPressed: ()
                                              {
                                                if (widget.foodQuantity > 0) setState(() => widget.foodQuantity--);
                                                widget.onQuantityChanged(widget.foodQuantity);
                                              },),
                                            Text(widget.foodQuantity.toString(),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1),
                                            IconButton(
                                                icon: new Icon(Icons.add),
                                                onPressed: ()
                                                {
                                                  setState(() => widget.foodQuantity++);
                                                  widget.onQuantityChanged(widget.foodQuantity);
                                                })
                                          ],
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.only(bottom: 8.0),
                                              child: Text(
                                              "Food Expiry",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .labelMedium),)
                                        ),
                                        Center(
                                          child: Text(
                                              widget.foodExpiry,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        });
                  },
                  child:
                  Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AspectRatio(
                              aspectRatio: 18.0 / 13.0,
                              child: Image.asset(widget.foodImage, height: 70, fit: BoxFit.contain),
                            ),
                            Center(
                              child: Text(widget.foodName,
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                            Center(
                              child: Text(widget.foodExpiry,
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ],
                        ),
                      ]
                  )
              ),
            ]),)
        ,

    );
  }
}

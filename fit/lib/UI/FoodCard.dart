import 'package:flutter/material.dart';
import 'dart:async';

class FoodCard extends StatefulWidget {
  FoodCard(
      {Key? key,
        required this.foodName,
        required this.foodExpiry,
        required this.foodImage,
        required this.foodQuantity,
        required this.unit,
        required this.onQuantityChanged,
        required this.onValueChanged,
        required this.labelColor,
        required this.value,
        required this.visible
      })
      : super(key: key);
  final String foodName;
  final String foodExpiry;
  final String foodImage;
  final Function(int) onQuantityChanged;
  final Function onValueChanged;
  final String unit;
  Color labelColor;
  bool value;
  bool visible;
  int foodQuantity;

  @override
  FoodCardState createState() => FoodCardState();
}

class FoodCardState extends State<FoodCard> {
  Color expiryColor = Colors.white;
  @override
  void initState() {
    super.initState();
    expiryColor = (DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<3?Colors.red:
    ((DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<6?Colors.orange:
    ((DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<8?Colors.yellow:Colors.white));
  }
  // final GlobalKey _closeKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    bool _isSelected = false;
    return Center(
      child: Container(
        margin:EdgeInsets.all(5.0),
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: expiryColor,
            width: 5,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
              bottomLeft: Radius.circular(7),
              bottomRight: Radius.circular(7)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3, // changes position of shadow
            ),
          ],
        ),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.visible) Expanded(
                child: Checkbox(
                  value: widget.value,
                  onChanged: (newValue) {
                    setState(() {
                      _isSelected = newValue!;
                      widget.value = _isSelected;
                      widget.labelColor = widget.value?Colors.teal:Colors.black87;
                      widget.onValueChanged(_isSelected);
                    });
                  },),
              ),
              InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, StateSetter setState){
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

                  child: Stack(

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
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      letterSpacing: 1.5),),
                            ),
                            Center(
                              child: Text(widget.foodExpiry,
                                  style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            ),
                          ],
                        ),
                      ]
                  )
              ),
            ]
        ),
      ),
    );
  }
}

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
  bool expired = false;
  @override
  void initState() {
    super.initState();
    expiryColor = (DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<0? Colors.white70:
    ((DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<3?Colors.red:
    ((DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<6?Colors.orange:
    ((DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<8?Colors.yellow:Colors.white)));
    expired = (DateTime.parse(widget.foodExpiry).difference(DateTime.now()).inDays)<0?true:false;
  }
  // final GlobalKey _closeKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    bool _isSelected = false;
    return Center(
      child: Container(
        margin:EdgeInsets.all(2.5),
        height: 300,
        foregroundDecoration: BoxDecoration(
          color: expired ? Colors.grey:Colors.transparent,
          backgroundBlendMode: BlendMode.saturation,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: expiryColor,
            width: 4,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 1.0, // changes position of shadow
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
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: expired?Colors.black38:Colors.black87,
                                      letterSpacing: 1.5),),
                            ),
                            if(expiryColor != Colors.white)Center(
                              child: Text(widget.foodExpiry,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: expired?Colors.black45:Colors.black87)),
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

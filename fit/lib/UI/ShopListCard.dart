import 'package:flutter/material.dart';

class ShopListWidget extends StatefulWidget {
  ShopListWidget({Key? key,
    required this.label,
    required this.quantity,
    required this.isRecipe,
    required this.recipe,}) : super(key: key);

  final String label;
  final String quantity;
  final bool isRecipe;
  final String recipe;
  bool value = false;
  Color labelColor = Colors.black87;

  @override
  State<ShopListWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ShopListWidget> {


  @override
  Widget build(BuildContext context) {
    bool _isSelected = false;

    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black26),
            bottom: BorderSide(color: Colors.black26),
          ),),
        child: Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isSelected = !widget.value;
                  widget.value=_isSelected;
                  widget.labelColor = widget.value?Colors.teal:Colors.black87;
                });

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Checkbox(
                        value: widget.value,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isSelected = newValue!;
                            widget.value = _isSelected;
                            widget.labelColor = widget.value?Colors.teal:Colors.black87;
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 5.0),
                    Expanded(flex: 4,child: Text(widget.label, style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: widget.labelColor))),
                    Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(widget.quantity, style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: widget.labelColor)),
                        )

                    ),
                    const SizedBox(width: 2.0),
                    Expanded(
                      child: IconButton(icon: const Icon(Icons.arrow_drop_down_rounded), onPressed: () {  },),
                    ),

                  ],
                ),
              ),
            )
        )
    );

  }
}
